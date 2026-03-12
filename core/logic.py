import random
import math


def generate_round_robin_groups(players):
    """Splits a list of players into groups of 4."""
    random.shuffle(players)
    # Grouping logic: yields lists of 4 names
    return [players[i : i + 4] for i in range(0, len(players), 4)]


def validate_bracket_size(player_count):
    """Checks if the player count is a power of 2 (8, 16, 32)."""
    if player_count < 2:
        return False
    return player_count & (player_count - 1) == 0
