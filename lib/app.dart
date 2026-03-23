import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/auth/auth_notifier.dart';
import 'core/navigation/app_router.dart';

/// Root widget. Creates [AuthNotifier] and [GoRouter] once, then hands
/// [routerConfig] to [MaterialApp.router].
class GoRouterDemoApp extends StatefulWidget {
  const GoRouterDemoApp({super.key});

  @override
  State<GoRouterDemoApp> createState() => _GoRouterDemoAppState();
}

class _GoRouterDemoAppState extends State<GoRouterDemoApp> {
  final _authNotifier = AuthNotifier();
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = createRouter(_authNotifier);
  }

  @override
  void dispose() {
    _authNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GoRouter Features Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
