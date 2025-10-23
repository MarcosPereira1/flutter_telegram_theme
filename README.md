<div align="center">

# Circular Theme Reveal 🎨

**A beautiful Telegram-style circular reveal animation for theme transitions in Flutter**

[![style: flutter_lints](https://img.shields.io/badge/style-flutter__lints-blue)](https://pub.dev/packages/flutter_lints)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/MarcosPereira1/flutter_telegram_theme?style=social)](https://github.com/MarcosPereira1/flutter_telegram_theme)

---

https://github.com/user-attachments/assets/b158ea91-6afc-42bf-aed8-24e4e4f00902

**✨ Smooth • 🔄 Bidirectional • ⚡ Performant • 🎯 Zero Dependencies**

</div>

---

## Features ✨

- 🔄 **Smooth circular reveal animation** - Just like Telegram
- 🌓 **Bidirectional transition** - Expands when going dark, contracts when going light
- 🎯 **Center-based animation** - Starts from any point (e.g., your theme toggle button)
- ⚡ **High performance** - Uses efficient snapshot + blend mode technique
- 🎨 **Customizable** - Adjust duration, curves, and more
- 📦 **Zero dependencies** - Only uses Flutter SDK

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  circular_theme_reveal: ^1.0.0
```

Or install it from the command line:

```bash
flutter pub add circular_theme_reveal
```

## Usage

### 1. Wrap your MaterialApp

Wrap your `MaterialApp` (or the root widget) with `CircularThemeRevealOverlay`:

```dart
import 'package:circular_theme_reveal/circular_theme_reveal.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _currentThemeMode, // Your theme mode state
      builder: (context, child) {
        return CircularThemeRevealOverlay(
          child: child ?? SizedBox.shrink(),
        );
      },
      home: HomePage(),
    );
  }
}
```

### 2. Trigger the animation

In your theme toggle button:

```dart
IconButton(
  icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
  onPressed: () async {
    // Get button position
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);
    final Size size = box.size;
    final Offset center = Offset(
      position.dx + size.width / 2,
      position.dy + size.height / 2,
    );

    // Get overlay
    final overlay = CircularThemeRevealOverlay.of(context);

    if (overlay != null) {
      // Start animation
      await overlay.startTransition(
        center: center,
        reverse: isDark, // true when going from dark to light
        onThemeChange: () {
          // Change your theme here
          setState(() {
            isDark = !isDark;
          });
        },
      );
    } else {
      // Fallback if overlay not found
      setState(() {
        isDark = !isDark;
      });
    }
  },
)
```

## Complete Example

See the `/example` folder for a complete working example with:
- State management
- Theme persistence
- Multiple pages
- Custom theme toggle button

## How it works 🔧

The animation uses a clever technique inspired by Telegram:

1. **Captures a snapshot** of the current screen
2. **Overlays the snapshot** on top
3. **Changes the theme** underneath (user doesn't see it yet)
4. **Animates a circular mask** that reveals the new theme
5. **Fades out gracefully** to prevent visual glitches

The animation direction reverses automatically:
- 🌞 → 🌙 **Expands** from the button
- 🌙 → 🌞 **Contracts** back to the button

## Customization

You can customize the animation by modifying the `CircularThemeRevealOverlay` source:

- **Duration**: Change `Duration(milliseconds: 600)` in the controller
- **Curve**: Modify `Curves.easeInOut` to any curve you prefer
- **Fade timing**: Adjust the `0.85` threshold in `CircularRevealPainter`

## Performance Tips

- ✅ Uses `RepaintBoundary` for efficient snapshot capture
- ✅ Disposes images properly to prevent memory leaks
- ✅ Uses `BlendMode.dstOut` for hardware-accelerated masking
- ✅ Minimal rebuilds during animation

## Platform Support

| Platform | Support |
|----------|---------|
| Android  | ✅      |
| iOS      | ✅      |
| Web      | ✅      |
| macOS    | ✅      |
| Windows  | ✅      |
| Linux    | ✅      |

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License - see LICENSE file for details

## Credits

Inspired by Telegram's beautiful theme transition animation.

## Author

Created with ❤️ by [marcospereira](https://github.com/MarcosPereira1)

