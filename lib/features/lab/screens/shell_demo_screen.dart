import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/route_names.dart';

/// Shell widget for the simple [ShellRoute] demo (Feature 17).
///
/// Unlike [StatefulShellRoute], a plain [ShellRoute] shares ONE navigator
/// for all children. Switching "tabs" via go() replaces the child — state
/// (e.g. scroll position) is NOT preserved.
///
/// Contrast with [MainScaffold] (StatefulShellRoute): switching the bottom
/// nav there DOES preserve each branch's scroll position.
class ShellDemoScreen extends StatelessWidget {
  final Widget child;

  const ShellDemoScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final isChildA = state.uri.toString().contains('child-a');

    return Scaffold(
      appBar: AppBar(title: const Text('ShellRoute Demo')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Feature #17 — ShellRoute (Simple)\n\n'
                'Scroll down in Child A, then switch to Child B and back. '
                'The scroll position RESETS — ShellRoute shares one navigator. '
                '\n\nContrast: the bottom nav (StatefulShellRoute) preserves '
                'scroll state per tab.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
              ),
            ),
          ),
          // Manual tab bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: _TabButton(
                    label: 'Child A',
                    active: isChildA,
                    onTap: () => context.goNamed(RouteNames.shellChildA),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _TabButton(
                    label: 'Child B',
                    active: !isChildA,
                    onTap: () => context.goNamed(RouteNames.shellChildB),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // Child route content renders here
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _TabButton({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return active
        ? FilledButton(onPressed: onTap, child: Text(label))
        : OutlinedButton(onPressed: onTap, child: Text(label));
  }
}
