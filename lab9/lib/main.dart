import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

/// Головний віджет застосунку з підтримкою перемикання світлої та темної теми
class MyApp extends StatefulWidget {
  final ThemeMode initialThemeMode;

  const MyApp({
    super.key,
    this.initialThemeMode = ThemeMode.light,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
  }

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = _themeMode == ThemeMode.dark;

    return MaterialApp(
      title: 'Лабораторна робота 9 - Теми та стилі',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: ProfileScreen(
        isDark: isDark,
        onThemeToggle: _toggleTheme,
      ),
    );
  }
}
