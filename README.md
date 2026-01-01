# Thieves City

A 2.5D multiplayer thief game built with Godot Engine. Compete with 30 AI/Online thieves to collect the most loot in a fast-paced city environment.

## Game Concept

**Thieves City** is an action-packed game where players control a thief in a bustling city. Your goal is to collect as much loot as possible while competing against other thieves. The player with the most money at the end of each round wins!

## Core Gameplay Mechanics

### Looting
- Scattered items on the ground: Jewels, Wallets, and Cash
- Walking over items automatically adds them to your "Current Match Money"
- Different loot types have different values:
  - Cash: 10 points
  - Jewel: 50 points
  - Wallet: 100 points

### Collision Mechanics
- When two thieves collide, the one with more money steals ALL money from the other
- The loser's balance resets to 0
- Strategic positioning and timing are key to survival

### Match Timer
- Each round lasts 120-180 seconds
- Real-time countdown displayed on screen
- Match ends when timer reaches zero

### Leaderboard
- Real-time ranking during the match based on current money
- Final rank summary displayed at match end
- Track your position among 30 other players

## Meta-Progression & Economy

### Global Wallet
- Money earned in a match is added to a "Permanent Global Wallet" after the round ends
- Your global wallet persists between matches
- Use your global wallet to purchase upgrades and cosmetics

### Shop System
- Purchase "Skins" to customize your thief's appearance
- Buy "Power-ups" to gain temporary advantages in matches

### Upgrades
Pre-match upgrade system allows you to spend global wallet money on:
- **Speed Boost**: Increases movement speed during the match
- **Starting Cash**: Start the match with X amount of money instead of 0

### Monetization
- Rewarded Video Ads to double earned money
- Optional cosmetic purchases
- No pay-to-win mechanics

## Technical Stack

- **Engine**: Godot Engine 3.2.3
- **Language**: GDScript
- **Platform**: Web, Android, iOS, Windows, macOS, Linux
- **Architecture**: 2.5D with 3D city environment and 2D sprite characters

## Project Structure

```
Thieves_City/
├── scenes/              # Game scenes and UI layouts
├── scripts/             # GDScript files
│   ├── GameManager.gd   # Main game logic and state management
│   ├── Player.gd        # Player controller and mechanics
│   ├── Loot.gd          # Loot item logic
│   ├── LootManager.gd   # Loot spawning system
│   ├── UI.gd            # User interface
│   └── AIPlayer.gd      # AI opponent logic (coming soon)
├── assets/              # Game assets
│   ├── sprites/         # Character and item sprites
│   ├── sounds/          # Audio files
│   └── fonts/           # Font files
├── project.godot        # Godot project configuration
└── README.md            # This file
```

## Getting Started

### Prerequisites
- Godot Engine 3.2.3 or later
- Git (for cloning the repository)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/Thieves_City.git
cd Thieves_City
```

2. Open the project in Godot:
```bash
godot3 --path .
```

3. Press F5 to run the game

## Development Roadmap

### Phase 1: Core Gameplay (Current)
- [x] Project setup
- [x] Game manager and state management
- [ ] Player movement and controls
- [ ] Loot collection system
- [ ] Collision and money stealing mechanics
- [ ] AI players
- [ ] UI and leaderboard

### Phase 2: Meta-Progression
- [ ] Global wallet system
- [ ] Shop and cosmetics
- [ ] Upgrade system
- [ ] Save/Load system

### Phase 3: Multiplayer
- [ ] Server architecture
- [ ] Online matchmaking
- [ ] Real-time synchronization
- [ ] Chat system

### Phase 4: Polish & Optimization
- [ ] Graphics and animations
- [ ] Sound design
- [ ] Performance optimization
- [ ] Bug fixes and testing

### Phase 5: Platform Deployment
- [ ] Web build
- [ ] Android build
- [ ] iOS build
- [ ] Desktop builds (Windows, macOS, Linux)

## Controls

- **Arrow Keys** or **WASD**: Move your thief
- **Space**: (Future) Use power-up
- **ESC**: Pause game

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues, questions, or suggestions, please open an issue on GitHub.

## Credits

- Developed with [Godot Engine](https://godotengine.org/)
- Inspired by ".io" games and crowd-based mechanics

---

**Status**: Early Development

**Last Updated**: January 2, 2026
