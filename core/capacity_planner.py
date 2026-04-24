from datetime import datetime, timedelta

def calculate_max_capacity(start_date_str, end_date_str, num_courts=6):
    """
    Returns the maximum number of matches that can mathematically fit into
    the club's available courts and defined active hours over a date range.
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
        weekday = curr_day.weekday()
        if 1 <= weekday <= 4:
            # Tuesday to Friday (16, 17:30, 19, 20:30)
            total_slots += 4
        elif weekday == 5:
            # Saturday (9, 10:30, 12, 13:30, 16, 17:30, 19, 20:30)
            total_slots += 8
        elif weekday == 6:
            # Sunday (9, 10:30, 12, 13:30, 15, 16:30, 18, 19:30)
            total_slots += 8
            
        curr_day += timedelta(days=1)
        
    return total_slots * num_courts
