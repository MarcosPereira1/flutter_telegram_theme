## 1.0.0

**Initial Release** 🎉

### Features
* ✨ Smooth circular reveal animation for theme transitions
* 🔄 Bidirectional animation (expands when going dark, contracts when going light)
* 🎯 Center-based animation starting from any point (e.g., your theme toggle button)
* 🌓 Automatic direction handling based on theme change
* ⚡ High performance using snapshot + blend mode technique
* 🎨 Works with any custom theme colors
* 📦 Zero external dependencies (only Flutter SDK)
* 🚀 Easy-to-use API with helper methods

### API
* `CircularThemeRevealOverlay` - Main widget to wrap your MaterialApp
* `CircularThemeRevealOverlay.of(context)` - Get overlay state from context
* `CircularThemeRevealOverlay.getCenterFromContext(context)` - Helper to get widget center position
* `startTransition()` - Method to trigger the circular reveal animation

### Technical Highlights
* Fade based on actual radius (not time) for natural dissipation
* Subtle glow effect in final 10% for smooth termination
* `easeInExpo` curve for cinematic contraction animation
* Precise timing to eliminate visual glitches
* Efficient memory management with proper image disposal
* Full dartdoc documentation for all public APIs

### Platform Support
* ✅ Android
* ✅ iOS
* ✅ Web
* ✅ macOS
* ✅ Windows
* ✅ Linux
