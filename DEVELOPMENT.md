# Development Guide - Thieves City

This document provides guidelines for developing and contributing to the Thieves City project.

## Project Architecture

### Core Systems

#### 1. GameManager (GameManager.gd)
- Central game state management
- Match timer and duration control
- Money tracking (current match + global wallet)
- Signal emission for game events

**Key Methods:**
- `setup_match()` - Initialize new match
- `update_match_timer(delta)` - Update match time
- `end_match()` - End match and save earnings
- `add_money(amount)` - Add money to current match
- `save_global_wallet()` - Persist wallet data

#### 2. Player System (Player.gd)
- Player movement and controls
- Collision detection
- Money management
- Interaction with loot

**Key Methods:**
- `handle_input()` - Process player input
- `update_movement(delta)` - Update position
- `check_collisions()` - Detect collisions
- `collect_loot(loot_item)` - Collect items
- `handle_player_collision(other_player)` - Handle player-to-player collision

#### 3. AI System (AIPlayer.gd)
- Autonomous player behavior
- Three behavior modes: wander, chase, flee
- Dynamic decision making
- Money management

**Behavior Logic:**
- **Wander**: Move to random positions on map
- **Chase**: Pursue players with more money
- **Flee**: Avoid players with more money

#### 4. Loot System (Loot.gd, LootManager.gd)
- Loot item spawning and management
- Three loot types: cash (10), jewel (50), wallet (100)
- Automatic spawning based on timer
- Maximum loot limit on map

#### 5. UI System (UI.gd)
- Real-time money display
- Match timer display
- Player rank display
- Signal-based updates

#### 6. Leaderboard (LeaderboardManager.gd)
- Real-time ranking calculation
- Sorting by money
- Rank tracking

#### 7. Economy System (Shop.gd, UpgradeSystem.gd, SaveSystem.gd)
- Shop with skins and power-ups
- Upgrade system for permanent benefits
- Save/load game data
- Settings management

## Development Workflow

### Adding New Features

1. **Create Script File**
   - Place in `scripts/` directory
   - Use descriptive naming (e.g., `FeatureName.gd`)

2. **Implement Core Logic**
   - Follow GDScript conventions
   - Use signals for event communication
   - Add comments for complex logic

3. **Connect to GameManager**
   - Get reference in `_ready()`
   - Connect relevant signals
   - Handle events appropriately

4. **Test Locally**
   - Run with `godot3 --path .`
   - Test all edge cases
   - Check performance

### Code Style Guidelines

- Use snake_case for variables and functions
- Use PascalCase for class names
- Add comments for complex logic
- Keep functions focused and small
- Use signals for inter-system communication

### Common Patterns

#### Getting GameManager Reference
```gdscript
var game_manager = null

func _ready():
    game_manager = get_tree().root.get_node("Main/GameManager")
```

#### Emitting Signals
```gdscript
signal custom_event(parameter)

func trigger_event():
    emit_signal("custom_event", value)
```

#### Connecting Signals
```gdscript
if game_manager:
    game_manager.connect("signal_name", self, "_on_signal_name")

func _on_signal_name(parameter):
    # Handle signal
    pass
```

## Testing

### Unit Testing
- Test individual systems in isolation
- Verify collision detection
- Test money calculations
- Validate AI behavior

### Integration Testing
- Test system interactions
- Verify signal flow
- Test save/load functionality

### Performance Testing
- Monitor frame rate with 30+ AI players
- Check memory usage
- Profile hot code paths

## Building for Different Platforms

### Web Build
```bash
godot3 --export "HTML5" --path .
```

### Android Build
```bash
godot3 --export "Android" --path .
```

### Desktop Builds
```bash
godot3 --export "Windows Desktop" --path .
godot3 --export "Mac OSX" --path .
godot3 --export "Linux/X11" --path .
```

## Debugging

### Console Output
```gdscript
print("Debug message: ", variable)
```

### Breakpoints
- Use Godot debugger (F5 to run, F6 to pause)
- Set breakpoints in editor
- Step through code execution

### Performance Profiler
- Tools → Profiler
- Monitor CPU, memory, physics

## Common Issues

### Issue: Player not moving
**Solution:** Check input handling and velocity application

### Issue: Collisions not working
**Solution:** Verify collision shapes and groups

### Issue: Money not updating
**Solution:** Check signal connections and GameManager state

### Issue: AI players stuck
**Solution:** Verify map boundaries and pathfinding logic

## Future Enhancements

1. **Graphics**
   - Sprite animations
   - Particle effects
   - Environmental details

2. **Audio**
   - Background music
   - Sound effects
   - Voice acting

3. **Gameplay**
   - Power-up mechanics
   - Special abilities
   - Seasonal events

4. **Multiplayer**
   - Server architecture
   - Network synchronization
   - Matchmaking system

5. **Optimization**
   - Object pooling
   - Spatial partitioning
   - LOD system

## Resources

- [Godot Documentation](https://docs.godotengine.org/)
- [GDScript Reference](https://docs.godotengine.org/en/stable/getting_started/scripting/gdscript/index.html)
- [Godot Physics](https://docs.godotengine.org/en/stable/tutorials/physics/index.html)

## Contact & Support

For questions or issues, please open an issue on GitHub or contact the development team.

---

**Last Updated:** January 2, 2026
