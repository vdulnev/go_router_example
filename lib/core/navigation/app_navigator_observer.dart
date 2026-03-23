import 'package:flutter/material.dart';

/// A [NavigatorObserver] that records navigation events into a static
/// [ValueNotifier] so the [ObserverScreen] can display them reactively.
///
/// Demonstrates Feature 14: NavigatorObserver.
class AppNavigatorObserver extends NavigatorObserver {
  /// Live log of navigation events — listened to by [ObserverScreen].
  static final ValueNotifier<List<String>> eventLog =
      ValueNotifier<List<String>>([]);

  static void _add(String event) {
    final now = DateTime.now();
    final ts =
        '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}';
    eventLog.value = ['[$ts] $event', ...eventLog.value].take(60).toList();
  }

  /// Records an onEnter interception event (go_router v17 feature).
  static void addOnEnterEvent(String message) => _add('⚡ onEnter: $message');

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _add('PUSH  → ${_name(route)}');

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _add('POP   ← ${_name(route)} (prev: ${_name(previousRoute)})');

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      _add('REPLACE ${_name(oldRoute)} → ${_name(newRoute)}');

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _add('REMOVE  ${_name(route)}');

  static String _name(Route<dynamic>? route) =>
      route?.settings.name ?? 'unknown';
}
