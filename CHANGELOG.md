# Changelog

All notable changes to Thieves City will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned Features
- Scene implementation (main game, menus, UI)
- Sprite assets and animations
- Sound effects and background music
- Multiplayer networking
- Tutorial system
- Achievements
- Localization support

## [0.1.0] - 2026-01-02

### Added
- Initial project setup with Godot Engine 3.2.3
- Core game systems:
  - **GameManager**: Central game state management, match timer, money tracking
  - **Player**: Player movement, collision detection, loot collection
  - **AIPlayer**: AI opponent with three behavior modes (wander, chase, flee)
  - **Loot System**: Loot spawning with three item types (cash, jewel, wallet)
  - **LootManager**: Automatic loot spawning and management
  - **UI System**: Real-time display of money, timer, and rank
  - **LeaderboardManager**: Real-time ranking system
  - **Shop**: Purchase system for skins and power-ups
  - **UpgradeSystem**: Permanent upgrade system
  - **SaveSystem**: Game data persistence
- Project documentation:
  - README.md with game overview
  - DEVELOPMENT.md with developer guidelines
  - BUILD.md with platform build instructions
  - CONTRIBUTING.md with contribution guidelines
  - LICENSE (MIT)
- Git repository initialization
- GitHub repository created: https://github.com/elith-bot/Thieves-City

### Game Mechanics
- Match duration: 120 seconds
- 30 AI opponents
- Three loot types with different values:
  - Cash: 10 points
  - Jewel: 50 points
  - Wallet: 100 points
- Collision-based money stealing
- Global wallet system
- Save/load functionality

### Technical
- GDScript implementation
- Signal-based event system
- Modular architecture
- Cross-platform support structure

## [0.0.1] - 2026-01-02

### Added
- Project initialization
- Basic folder structure
- Godot project configuration

---

## Version History

### Version Numbering
- **Major (X.0.0)**: Significant changes, major features, breaking changes
- **Minor (0.X.0)**: New features, improvements, non-breaking changes
- **Patch (0.0.X)**: Bug fixes, small improvements

### Release Schedule
- **Alpha**: Core features implementation (v0.1.x - v0.5.x)
- **Beta**: Testing and polish (v0.6.x - v0.9.x)
- **Release**: Public launch (v1.0.0)
- **Updates**: Regular updates and improvements (v1.x.x+)

---

## Upcoming Milestones

### v0.2.0 - Scene Implementation
- Main game scene with city environment
- Menu scenes (main menu, pause, game over)
- UI scene implementation
- Scene transitions

### v0.3.0 - Visual Assets
- Player and AI sprites
- Loot item sprites
- UI graphics
- Background and environment art
- Animations

### v0.4.0 - Audio
- Background music
- Sound effects (collection, collision, UI)
- Audio settings

### v0.5.0 - Polish & Testing
- Bug fixes
- Performance optimization
- Balance adjustments
- Playtesting feedback

### v0.6.0 - Multiplayer Foundation
- Server architecture
- Network synchronization
- Lobby system

### v0.7.0 - Multiplayer Features
- Online matchmaking
- Real-time gameplay
- Chat system
- Leaderboards

### v0.8.0 - Additional Features
- Tutorial system
- Achievements
- Statistics tracking
- More skins and power-ups

### v0.9.0 - Beta Testing
- Public beta release
- Bug fixes
- Performance optimization
- User feedback integration

### v1.0.0 - Official Release
- Full feature set
- All platforms supported
- Documentation complete
- Marketing materials

---

## Notes

### Breaking Changes
Breaking changes will be clearly marked in release notes and this changelog.

### Deprecations
Deprecated features will be announced at least one version before removal.

### Support
Each major version will be supported for at least 6 months after the next major release.

---

**Last Updated:** January 2, 2026
