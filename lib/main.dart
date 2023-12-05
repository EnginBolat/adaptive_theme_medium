import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.savedThemeMode});

  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      debugShowFloatingThemeButton: true,
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      initial: savedThemeMode ?? AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Adaptive Theme Learn',
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        home: const OneButonThemeChange(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    // Change Theme To Light
                    AdaptiveTheme.of(context).setLight();
                  },
                  icon: const Icon(Icons.light),
                ),
                IconButton(
                  onPressed: () {
                    // Change Theme To Dark
                    AdaptiveTheme.of(context).setDark();
                  },
                  icon: const Icon(Icons.dark_mode),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Change Theme
                AdaptiveTheme.of(context).toggleThemeMode();
              },
              child: Text(AdaptiveTheme.of(context).mode.modeName),
            )
          ],
        ),
      ),
    );
  }
}

class OneButonThemeChange extends StatelessWidget {
  const OneButonThemeChange({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = AdaptiveTheme.of(context);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              themeManager.mode.isLight
                  ? themeManager.setDark()
                  : themeManager.setLight();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(themeManager.mode.isLight
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode),
                const SizedBox(width: 4),
                Text(themeManager.mode.modeName),
              ],
            )),
      ),
    );
  }
}
