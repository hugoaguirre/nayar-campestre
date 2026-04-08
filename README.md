# 🎾 Club Nayar Campestre - Tournament Management System

A premium, bespoke tournament operations dashboard built specifically for **Club Nayar Campestre**. 

Designed strictly to the "Wimbledon Luxury" aesthetic standard, this architecture moves club operations away from chaotic spreadsheets and manual group formulations into a mathematically robust, cloud-synchronized PostgreSQL environment. 

This platform eliminates scheduling bottlenecks, mitigates physical capacity failures, and actively manages complex registration logic in real-time.

## 🚀 Key Features & Solved Problems

- **Intelligent Club Capacity Planner**: Mathematically calculates the absolute physical maximum matches your club can field based on your exact tournament dates and physical court counts. It surfaces a real-time UI capacity metric that visually turns **RED (¡SOBRECUPO!)** when coaches accept more players than the temporal boundaries allow, permanently destroying the risk of overflowing your physical club.
- **Advanced Constraint-Based Auto-Scheduler**: Eliminates random "best-effort" time slotting. The custom scheduling engine actively analyzes dates to:
  - Spread games heavily across vacant days.
  - Automatically enforce Prime-Time (19:00+) for Elite Categories (AA, A, B+).
  - Actively detect and penalize heavy player fatigue (same-day back-to-back games).
  - Isolate knock-out ("Eliminatoria") matches solely to the final days using gravitational penalties.
- **Bidirectional Doubles Synchronization**: An intelligent partner-swapping engine that ensures if Player A abandons Player B, their entire database mapping safely unwinds the dependency immediately, preventing orphaned logic loops globally.
- **Universal Knockout Calculus**: The architecture utilizes advanced $N-1$ algebra to automatically construct exactly how many single-elimination matches a given bracket needs, injecting structural placeholders globally without manually traversing logical branches.
- **Capacity-Driven Synthetic Factory**: Built-in Python scripting (`scripts/generate_test_seeds.py`) that computationally spins up complete SQL testing arrays based on percentages (e.g., "Synthesize an 80% Capacity Tournament", "Synthesize a 150% Overflow Tournament"). Allowing robust Staging-Environment testing and instantaneous teardown.

*(More media/usage documentation coming soon...)*
