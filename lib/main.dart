import 'package:flutter/material.dart';

import 'app/app_shell.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EduSwapApp());
}

class EduSwapApp extends StatelessWidget {
  const EduSwapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EduSwap',
      themeMode: ThemeMode.dark,
      theme: AppTheme.darkTheme,
      home: const AppShell(),
    );
  }
}
