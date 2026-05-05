"""
Shared scheduling utilities for both Tournament and Ranking systems.

Extracted from services/scheduling_service.py to enable code reuse.
Contains generalized time-slot generation and capacity calculation
that both schedulers depend on.
"""
from datetime import datetime, timedelta, time, date as date_type

# ═══════════════════════════════════════════════════════════════
# Constants
# ═══════════════════════════════════════════════════════════════

SLOT_DURATION_MINUTES = 90

# Default tournament time grid (weekday_int → (start_hour, num_slots)).
# Monday (0) is absent — club is closed on Mondays.
TOURNAMENT_GRID = {
    1: (16, 4),   # Tuesday    → 16:00, 17:30, 19:00, 20:30
    2: (16, 4),   # Wednesday
    3: (16, 4),   # Thursday
    4: (16, 4),   # Friday
    5: (9, 8),    # Saturday   → 09:00, 10:30, 12:00, 13:30, 15:00, 16:30, 18:00, 19:30
    6: (9, 8),    # Sunday     → same as Saturday
}

# Prime-time threshold (hour >= this is "prime time")
PRIME_HOUR = 19


# ═══════════════════════════════════════════════════════════════
# Generalized Time-Slot Generation
# ═══════════════════════════════════════════════════════════════

def generate_time_slots(day_date, first_game, last_game, slot_duration=SLOT_DURATION_MINUTES):
    """
    Generate continuous time slots for a single calendar day.

    Args:
        day_date:      date object for the target day.
        first_game:    time object — start of the first slot (e.g., time(18, 0)).
        last_game:     time object — start of the LAST allowed slot (e.g., time(19, 30)).
        slot_duration: int — minutes per slot (default 90).

    Returns:
        List of datetime objects representing each slot's start time.
        Empty list if first_game > last_game.
    """
    if isinstance(day_date, datetime):
        day_date = day_date.date()

    slots = []
    current = datetime.combine(day_date, first_game)
    end = datetime.combine(day_date, last_game)

    while current <= end:
        slots.append(current)
        current += timedelta(minutes=slot_duration)

    return slots


def generate_tournament_day_slots(day):
    """
    Generate time slots for a single TOURNAMENT day using the hardcoded grid.

    This is the shared equivalent of scheduling_service._build_day_slots().
    Returns list of {"time": datetime, "is_prime": bool} dicts.
    Compatible with the existing tournament scheduling engine.

    Args:
        day: datetime object for the target day.

    Returns:
        List of {"time": datetime, "is_prime": bool} slot dicts.
        Empty list for Mondays or days outside the grid.
    """
    weekday = day.weekday() if isinstance(day, datetime) else day.weekday()
    config = TOURNAMENT_GRID.get(weekday)
    if config is None:
        return []

    start_hour, num_slots = config
    d = day if isinstance(day, datetime) else datetime.combine(day, time(0))

    slots = []
    t = d.replace(hour=start_hour, minute=0, second=0, microsecond=0)
    for _ in range(num_slots):
        slots.append({"time": t, "is_prime": t.hour >= PRIME_HOUR})
        t += timedelta(minutes=SLOT_DURATION_MINUTES)
    return slots


# ═══════════════════════════════════════════════════════════════
# Capacity Calculation
# ═══════════════════════════════════════════════════════════════

def calculate_day_slot_count(day_date, first_game, last_game, slot_duration=SLOT_DURATION_MINUTES):
    """Return the number of time slots that fit in a single day's window."""
    return len(generate_time_slots(day_date, first_game, last_game, slot_duration))


def calculate_tournament_day_capacity(day, num_courts=6):
    """
    Return the number of matches that fit in a single TOURNAMENT day
    using the hardcoded grid. Equivalent to the old capacity_planner logic.
    """
    slots = generate_tournament_day_slots(day)
    return len(slots) * num_courts


def calculate_date_range_capacity(
    start_date, end_date,
    weekday_config, weekend_config,
    num_courts=6, slot_duration=SLOT_DURATION_MINUTES
):
    """
    Calculate total match capacity across a date range with configurable windows.

    Used by the ranking scheduler where time windows change week to week.

    Args:
        start_date, end_date: date objects defining the range (inclusive).
        weekday_config:       tuple(time, time) — (first_game, last_game) for Tue–Fri.
        weekend_config:       tuple(time, time) — (first_game, last_game) for Sat–Sun.
        num_courts:           int — number of courts available.
        slot_duration:        int — minutes per match slot.

    Returns:
        int — total number of match slots across the entire date range.
    """
    if isinstance(start_date, datetime):
        start_date = start_date.date()
    if isinstance(end_date, datetime):
        end_date = end_date.date()

    total = 0
    current = start_date

    while current <= end_date:
        weekday = current.weekday()

        if weekday == 0:
            # Monday — club closed
            current += timedelta(days=1)
            continue

        if weekday <= 4:
            first, last = weekday_config
        else:
            first, last = weekend_config

        slot_count = calculate_day_slot_count(current, first, last, slot_duration)
        total += slot_count * num_courts
        current += timedelta(days=1)

    return total


def is_club_closed(d):
    """Check if the club is closed on this date (Mondays)."""
    weekday = d.weekday() if isinstance(d, (datetime, date_type)) else d
    return weekday == 0
