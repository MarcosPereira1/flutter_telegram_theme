import 'package:flutter/material.dart';
import 'package:circular_theme_reveal/circular_theme_reveal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Theme Reveal Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      themeAnimationDuration: Duration.zero,
      builder: (BuildContext context, Widget? child) {
        return CircularThemeRevealOverlay(
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: HomePage(
        onThemeToggle: _toggleTheme,
        isDark: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    required this.onThemeToggle,
    required this.isDark,
    super.key,
  });

  final VoidCallback onThemeToggle;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circular Theme Reveal'),
        actions: [
          ThemeToggleButton(
            isDark: isDark,
            onToggle: onThemeToggle,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              isDark ? 'Dark Mode' : 'Light Mode',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Tap the button in the app bar to see the beautiful circular reveal animation!',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.info_outline),
        label: const Text('Example Button'),
      ),
    );
  }
}

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({
    required this.isDark,
    required this.onToggle,
    super.key,
  });

  final bool isDark;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return RotationTransition(
            turns: animation,
            child: child,
          );
        },
        child: Icon(
          isDark ? Icons.light_mode : Icons.dark_mode,
          key: ValueKey<bool>(isDark),
        ),
      ),
      onPressed: () async {
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final Offset position = box.localToGlobal(Offset.zero);
          final Size size = box.size;
          final Offset center = Offset(
            position.dx + size.width / 2,
            position.dy + size.height / 2,
          );

          final CircularThemeRevealOverlayState? overlay = CircularThemeRevealOverlay.of(context);

          if (overlay != null) {
            await overlay.startTransition(
              center: center,
              reverse: isDark,
              onThemeChange: onToggle,
            );
          } else {
            onToggle();
          }
        } else {
          onToggle();
        }
      },
    );
  }
}
