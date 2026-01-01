# Contributing to Thieves City

Thank you for your interest in contributing to Thieves City! This document provides guidelines for contributing to the project.

## Code of Conduct

We are committed to providing a welcoming and inspiring community for all. Please be respectful and constructive in all interactions.

## How to Contribute

### Reporting Bugs

If you find a bug, please create an issue on GitHub with:

- **Clear title** describing the bug
- **Steps to reproduce** the issue
- **Expected behavior** vs actual behavior
- **Screenshots** or videos if applicable
- **Platform** and version information
- **Error messages** or logs

### Suggesting Features

We welcome feature suggestions! Please create an issue with:

- **Clear description** of the feature
- **Use case** explaining why it's needed
- **Implementation ideas** if you have any
- **Mockups** or diagrams if applicable

### Submitting Pull Requests

1. **Fork the repository**
   ```bash
   gh repo fork elith-bot/Thieves-City
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow the code style guidelines
   - Add comments for complex logic
   - Test your changes thoroughly

4. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add: Brief description of changes"
   ```

5. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request**
   - Go to the original repository
   - Click "New Pull Request"
   - Select your branch
   - Fill in the PR template

## Development Guidelines

### Code Style

- **GDScript Conventions:**
  - Use `snake_case` for variables and functions
  - Use `PascalCase` for class names
  - Use `UPPER_CASE` for constants
  - Indent with tabs (4 spaces)

- **Comments:**
  - Add docstrings for functions
  - Explain complex logic
  - Use `#` for single-line comments
  - Use `"""` for multi-line docstrings

- **Example:**
  ```gdscript
  # This is a single-line comment
  
  func calculate_distance(point_a, point_b):
      """
      Calculate the distance between two points.
      
      Args:
          point_a: Vector2 - First point
          point_b: Vector2 - Second point
      
      Returns:
          float - Distance between points
      """
      return point_a.distance_to(point_b)
  ```

### Project Structure

- **scripts/** - All GDScript files
- **scenes/** - Godot scene files (.tscn)
- **assets/** - Game assets (sprites, sounds, fonts)
- **builds/** - Build outputs (not committed)

### Testing

- Test your changes on multiple platforms if possible
- Verify no regressions in existing features
- Check performance impact
- Test edge cases

### Commit Messages

Use clear, descriptive commit messages:

- **Add:** New feature or file
- **Fix:** Bug fix
- **Update:** Modify existing feature
- **Remove:** Delete code or file
- **Refactor:** Code restructuring
- **Docs:** Documentation changes

**Examples:**
```
Add: Player dash ability
Fix: Collision detection with AI players
Update: Loot spawn rate to 0.3 seconds
Remove: Unused debug code
Refactor: Player movement system
Docs: Update README with new features
```

## Areas for Contribution

### High Priority

- [ ] Scene creation (main game scene, UI scenes)
- [ ] Sprite assets and animations
- [ ] Sound effects and music
- [ ] Multiplayer networking
- [ ] Performance optimization

### Medium Priority

- [ ] Additional power-ups
- [ ] More skin options
- [ ] Tutorial system
- [ ] Achievements system
- [ ] Localization (multiple languages)

### Low Priority

- [ ] Advanced AI behaviors
- [ ] Seasonal events
- [ ] Custom game modes
- [ ] Replay system
- [ ] Statistics tracking

## Getting Help

If you need help with your contribution:

- Check the [DEVELOPMENT.md](DEVELOPMENT.md) guide
- Review existing code for examples
- Ask questions in GitHub Discussions
- Join our community chat (if available)

## Review Process

1. **Initial Review** - Maintainers review your PR within 3-5 days
2. **Feedback** - Address any requested changes
3. **Testing** - Changes are tested on multiple platforms
4. **Approval** - PR is approved and merged
5. **Release** - Changes included in next release

## Recognition

Contributors will be:
- Listed in the CONTRIBUTORS.md file
- Mentioned in release notes
- Credited in the game (for significant contributions)

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Questions?

If you have any questions about contributing, please:
- Open an issue on GitHub
- Contact the maintainers
- Check the documentation

Thank you for contributing to Thieves City! 🎮

---

**Last Updated:** January 2, 2026
