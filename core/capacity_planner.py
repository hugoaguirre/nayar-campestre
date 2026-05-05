from datetime import datetime, timedelta
from core.scheduling_utils import generate_tournament_day_slots

def calculate_max_capacity(start_date_str, end_date_str, num_courts=6):
    """
    Returns the maximum number of matches that can mathematically fit into
    the club's available courts and defined active hours over a date range.

    Delegates to the shared time-slot generator in core/scheduling_utils.py
    to ensure tournament and ranking systems use consistent slot logic.
    """
    if not start_date_str or not end_date_str:
        return 0
        
    try:
        start_date = datetime.strptime(start_date_str, "%Y-%m-%d")
        end_date = datetime.strptime(end_date_str, "%Y-%m-%d")
    except Exception:
        return 0

    total_slots = 0
    curr_day = start_date
    
    while curr_day <= end_date:
        day_slots = generate_tournament_day_slots(curr_day)
        total_slots += len(day_slots)
        curr_day += timedelta(days=1)
        
    return total_slots * num_courts
