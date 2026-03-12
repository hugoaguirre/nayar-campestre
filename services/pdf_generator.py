from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import LETTER
from io import BytesIO


def create_group_pdf(tournament_name, groups, l_logo=None, r_logo=None):
    """Generates the official 4x4 grid PDF with sponsor logos."""
    buffer = BytesIO()
    c = canvas.Canvas(buffer, pagesize=LETTER)

    # Header Branding
    c.setFont("Helvetica-Bold", 16)
    c.drawCentredString(300, 750, tournament_name)

    if l_logo:
        c.drawImage(l_logo, 50, 730, width=50, preserveAspectRatio=True)

    # Logic to draw the 4x4 grid lines would go here
    # (Drawing lines and text based on coordinates)

    c.showPage()
    c.save()
    buffer.seek(0)
    return buffer
