r<div align="center">

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

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Theme Reveal Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      themeAnimationDuration: Duration.zero, // Disable default animation
      builder: (context, child) {
        return CircularThemeRevealOverlay(
          child: child ?? SizedBox.shrink(),
        );
      },
      home: HomePage(
        onThemeToggle: () {
          setState(() {
            _themeMode = _themeMode == ThemeMode.light 
                ? ThemeMode.dark 
                : ThemeMode.light;
          });
        },
        isDark: _themeMode == ThemeMode.dark,
      ),
    );
  }
}
```

### 2. Trigger the animation

In your theme toggle button (simplified with helper method):

```dart
IconButton(
  icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
  onPressed: () async {
    // Get button center position using helper
    final center = CircularThemeRevealOverlay.getCenterFromContext(context);
    
    // Get overlay state
    final overlay = CircularThemeRevealOverlay.of(context);

    if (overlay != null) {
      // Start circular reveal animation
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

### Works with Any State Management

The package is agnostic to your state management solution. Works with:

#### Provider / Riverpod
```dart
onThemeChange: () {
  ref.read(themeProvider.notifier).toggle();
}
```

#### Bloc
```dart
onThemeChange: () {
  context.read<ThemeBloc>().add(ToggleTheme());
}
```

#### GetX
```dart
onThemeChange: () {
  Get.find<ThemeController>().toggleTheme();
}
```

## Complete Example

See the `/example` folder for a complete working example with:
- State management
- Theme persistence
- Multiple pages
- Custom theme toggle button

## How it works 🔧

The animation uses a clever technique inspired by Telegram:

1. **Captures a snapshot** of the current screen using `RepaintBoundary`
2. **Overlays the snapshot** on top of your app
3. **Changes the theme** underneath via your `onThemeChange` callback
4. **Animates a circular mask** using `BlendMode.dstOut` that reveals the new theme
5. **Fades out gracefully** at the end with progressive opacity + glow effect

The animation direction adapts automatically:
- 🌞 → 🌙 **Expands** from the button (circle grows, revealing dark theme)
- 🌙 → 🌞 **Contracts** back to the button (circle shrinks, revealing light theme)

The contraction uses special techniques to eliminate visual glitches:
- Fade based on actual radius (not time) for natural dissipation
- Subtle glow effect in the final 10% for smooth termination
- `easeInExpo` curve for cinematic acceleration
- Precise timing to remove overlay only when fully invisible

## Customization

### Current defaults:
- **Duration**: 600ms
- **Expansion curve**: `Curves.easeInOut`
- **Contraction curve**: `Curves.easeInExpo` (more cinematic)
- **Fade threshold**: Last 15% of radius
- **Glow effect**: Last 10% of radius

### Custom themes support:
The package works with **any theme colors** because it captures actual rendered pixels:

```dart
MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.purple,  // ✅ Your custom colors
      brightness: Brightness.light,
    ),
  ),
  darkTheme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.orange,  // ✅ Your custom dark colors
      brightness: Brightness.dark,
    ),
  ),
  // ... rest of setup
)
```

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

