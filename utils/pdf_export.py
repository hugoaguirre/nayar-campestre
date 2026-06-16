"""
PDF Export Utility — Generates printable match schedules for ranking weeks.
Black & white, minimalistic, ink-friendly design for on-court coaching use.
"""
import io
from datetime import date as date_type
from itertools import groupby

from reportlab.lib.pagesizes import LETTER, landscape
from reportlab.lib.units import inch
from reportlab.lib import colors
from reportlab.platypus import (
    SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer,
)
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.enums import TA_CENTER, TA_LEFT


# ── Spanish date helpers ──────────────────────────────────────
_DIAS_ES = [
    "Lunes", "Martes", "Miércoles", "Jueves",
    "Viernes", "Sábado", "Domingo",
]
_MESES_ES = [
    "", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
    "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre",
]


def _fmt_date_es(d):
    """Format a date object or ISO string → 'Martes 17 de Junio del 2026'."""
    if isinstance(d, str):
        parts = d.split("-")
        d = date_type(int(parts[0]), int(parts[1]), int(parts[2]))
    dia = _DIAS_ES[d.weekday()]
    mes = _MESES_ES[d.month]
    return f"{dia} {d.day} de {mes} del {d.year}"


def _short_name(first: str, last: str) -> str:
    """'Juan Carlos' + 'García López' → 'Juan García'."""
    first = (first or "").strip()
    last = (last or "").strip()
    if not first:
        return last
    last_word = last.split()[0] if last else ""
    return f"{first} {last_word}".strip()


# ── Styles ────────────────────────────────────────────────────
_LIGHT_GREY = colors.Color(0.92, 0.92, 0.92)
_ZEBRA_GREY = colors.Color(0.97, 0.97, 0.97)
_GRID_GREY = colors.Color(0.75, 0.75, 0.75)
_SET_PLACEHOLDER_COLOR = colors.Color(0.72, 0.72, 0.72)


def _build_styles():
    """Create all ParagraphStyles used in the PDF."""
    base = getSampleStyleSheet()

    title = ParagraphStyle(
        "PDFTitle",
        parent=base["Title"],
        fontName="Helvetica-Bold",
        fontSize=16,
        leading=20,
        alignment=TA_CENTER,
        spaceAfter=2,
    )

    subtitle = ParagraphStyle(
        "PDFSubtitle",
        parent=base["Normal"],
        fontName="Helvetica",
        fontSize=9,
        alignment=TA_CENTER,
        textColor=colors.grey,
        spaceAfter=18,
    )

    day_header = ParagraphStyle(
        "DayHeader",
        parent=base["Heading2"],
        fontName="Helvetica-Bold",
        fontSize=11,
        leading=14,
        spaceBefore=14,
        spaceAfter=6,
        textColor=colors.black,
    )

    cell = ParagraphStyle(
        "Cell",
        parent=base["Normal"],
        fontName="Helvetica",
        fontSize=9,
        leading=12,
    )

    cell_center = ParagraphStyle(
        "CellCenter",
        parent=cell,
        alignment=TA_CENTER,
    )

    cell_bold = ParagraphStyle(
        "CellBold",
        parent=cell,
        fontName="Helvetica-Bold",
    )

    set_cell = ParagraphStyle(
        "SetCell",
        parent=cell,
        fontSize=10,
        leading=13,
        alignment=TA_CENTER,
        textColor=_SET_PLACEHOLDER_COLOR,
    )

    return {
        "title": title,
        "subtitle": subtitle,
        "day_header": day_header,
        "cell": cell,
        "cell_center": cell_center,
        "cell_bold": cell_bold,
        "set_cell": set_cell,
    }


# ── Column widths (landscape LETTER ≈ 10 in usable) ──────────
_COL_WIDTHS = [
    0.7 * inch,   # Hora
    0.65 * inch,  # Cancha
    2.45 * inch,  # Defensor
    0.35 * inch,  # vs
    2.45 * inch,  # Retador
    1.1 * inch,   # Set 1
    1.1 * inch,   # Set 2
    1.1 * inch,   # Set 3
]

_TABLE_STYLE = TableStyle([
    # Header row
    ("BACKGROUND", (0, 0), (-1, 0), _LIGHT_GREY),
    ("FONTNAME", (0, 0), (-1, 0), "Helvetica-Bold"),
    ("FONTSIZE", (0, 0), (-1, 0), 8),

    # All cells
    ("GRID", (0, 0), (-1, -1), 0.5, _GRID_GREY),
    ("VALIGN", (0, 0), (-1, -1), "MIDDLE"),
    ("TOPPADDING", (0, 1), (-1, -1), 7),
    ("BOTTOMPADDING", (0, 1), (-1, -1), 7),
    ("LEFTPADDING", (0, 0), (-1, -1), 5),
    ("RIGHTPADDING", (0, 0), (-1, -1), 5),

    # Alternating row shading (skip header)
    ("ROWBACKGROUNDS", (0, 1), (-1, -1), [colors.white, _ZEBRA_GREY]),

    # Thicker border around the set-score columns to frame writing area
    ("BOX", (5, 0), (7, -1), 1, colors.Color(0.5, 0.5, 0.5)),
])


# ── Public API ────────────────────────────────────────────────

def generate_ranking_week_pdf(matches, week_data, category_name):
    """
    Generate a printable PDF for a ranking week's scheduled matches.

    Args:
        matches:       list of match dicts (from RankingService.get_week_matches).
        week_data:     dict with week_number, phase, week_start_date, etc.
        category_name: "Varonil" or "Femenil".

    Returns:
        bytes — PDF content ready for st.download_button.
    """
    buf = io.BytesIO()

    doc = SimpleDocTemplate(
        buf,
        pagesize=landscape(LETTER),
        topMargin=0.5 * inch,
        bottomMargin=0.5 * inch,
        leftMargin=0.5 * inch,
        rightMargin=0.5 * inch,
    )

    S = _build_styles()
    story = []

    # ── Title ─────────────────────────────────────────────────
    phase_label = "CHALLENGE" if week_data["phase"] == "challenge" else "DEFEND"
    story.append(
        Paragraph(
            f"RANKING &middot; SEMANA {week_data['week_number']} &middot; {phase_label}",
            S["title"],
        )
    )
    story.append(
        Paragraph(
            f"{category_name.upper()} &mdash; Club Nayar Campestre",
            S["subtitle"],
        )
    )

    # ── Sort matches ──────────────────────────────────────────
    sorted_matches = sorted(
        matches,
        key=lambda m: (
            m.get("scheduled_date") or "9999-99-99",
            m.get("scheduled_time") or "99:99",
            m.get("court_number") or 99,
        ),
    )

    # ── Group by day ──────────────────────────────────────────
    for day_key, day_iter in groupby(
        sorted_matches,
        key=lambda m: m.get("scheduled_date") or "9999-99-99",
    ):
        day_matches = list(day_iter)

        # Day header
        day_label = (
            _fmt_date_es(day_key).upper()
            if day_key != "9999-99-99"
            else "SIN FECHA ASIGNADA"
        )
        story.append(Paragraph(day_label, S["day_header"]))

        # Table header row
        header = [
            Paragraph("<b>HORA</b>", S["cell_center"]),
            Paragraph("<b>CANCHA</b>", S["cell_center"]),
            Paragraph("<b>DEFENSOR</b>", S["cell_bold"]),
            Paragraph("<b>VS</b>", S["cell_center"]),
            Paragraph("<b>RETADOR</b>", S["cell_bold"]),
            Paragraph("<b>SET 1</b>", S["cell_center"]),
            Paragraph("<b>SET 2</b>", S["cell_center"]),
            Paragraph("<b>SET 3</b>", S["cell_center"]),
        ]

        table_data = [header]

        for m in day_matches:
            defender = m.get("defender", {}) or {}
            challenger = m.get("challenger", {}) or {}

            d_name = _short_name(
                defender.get("first_name", ""),
                defender.get("last_name", ""),
            )
            c_name = _short_name(
                challenger.get("first_name", ""),
                challenger.get("last_name", ""),
            )

            d_label = f"#{m['defender_position']}  {d_name}"
            c_label = f"#{m['challenger_position']}  {c_name}"

            time_val = m.get("scheduled_time", "")
            if isinstance(time_val, str):
                time_val = time_val[:5]

            court = str(m.get("court_number", "—"))

            row = [
                Paragraph(str(time_val), S["cell_center"]),
                Paragraph(court, S["cell_center"]),
                Paragraph(d_label, S["cell"]),
                Paragraph("vs", S["cell_center"]),
                Paragraph(c_label, S["cell"]),
                Paragraph("___:___", S["set_cell"]),
                Paragraph("___:___", S["set_cell"]),
                Paragraph("___:___", S["set_cell"]),
            ]
            table_data.append(row)

        t = Table(table_data, colWidths=_COL_WIDTHS, repeatRows=1)
        t.setStyle(_TABLE_STYLE)
        story.append(t)
        story.append(Spacer(1, 12))

    # ── Build PDF ─────────────────────────────────────────────
    doc.build(story)
    buf.seek(0)
    return buf.getvalue()
