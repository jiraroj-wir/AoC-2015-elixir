### 💡 Day 18: Like a GIF For Your Yard

With strict new fire codes, you're limited to a 100x100 grid of lights — but Santa still expects a festive display. Each light is either **on (`#`)** or **off (`.`)**, and the entire grid updates in synchronized steps based on its neighbors, much like Conway’s Game of Life.

A light stays on if 2 or 3 neighbors are lit, and turns off otherwise. An off light turns on only if exactly 3 neighbors are on. After **100 animation steps**, you count how many lights remain on.

In part two, there’s a twist: the **four corner lights are permanently stuck on**, no matter what. With that constraint in place, you re-run the simulation and tally the lights again. A little life, a little logic — and a whole lot of blinking.
