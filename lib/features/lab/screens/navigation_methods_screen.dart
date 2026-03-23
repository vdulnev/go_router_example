import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/route_names.dart';

/// Demonstrates Feature 11: go() vs push() vs replace() vs pop().
///
/// Key differences:
/// - go()      — replaces the current URL (no new history entry, back button
///               behaviour depends on URL matching)
/// - push()    — adds to the navigator stack (back button always available)
/// - replace() — replaces the top entry on the stack (like push but removes
///               the current screen from history)
/// - pop()     — removes the top of the stack
class NavigationMethodsScreen extends StatelessWidget {
  const NavigationMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Methods')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Section(
            method: 'context.go()',
            color: Colors.blue,
            description:
                'Replaces the current URL. '
                'If the destination is outside the current shell branch, '
                'the bottom nav changes. No guaranteed back button.',
            buttonLabel: 'go() to destination',
            onTap: () => context.go(
              '/lab/navigation-methods/destination',
              extra: 'go()',
            ),
          ),
          _Section(
            method: 'context.push()',
            color: Colors.green,
            description:
                'Pushes a new route onto the stack. '
                'The back button always returns to this screen. '
                'Returns a Future you can await.',
            buttonLabel: 'push() to destination',
            onTap: () => context.push(
              '/lab/navigation-methods/destination',
              extra: 'push()',
            ),
          ),
          _Section(
            method: 'context.replace()',
            color: Colors.orange,
            description:
                'Replaces the top entry of the navigator stack. '
                'This screen is removed from history — '
                'back button skips it.',
            buttonLabel: 'replace() to destination',
            onTap: () => context.replace(
              '/lab/navigation-methods/destination',
              extra: 'replace()',
            ),
          ),
          _Section(
            method: 'context.goNamed()',
            color: Colors.purple,
            description:
                'Same as go() but uses the route name constant from '
                'RouteNames. Path & query parameters passed as maps.',
            buttonLabel: 'goNamed() to destination',
            onTap: () =>
                context.goNamed(RouteNames.navDestination, extra: 'goNamed()'),
          ),
          _Section(
            method: 'context.pushNamed()',
            color: Colors.teal,
            description:
                'Same as push() but uses the route name. '
                'Returns Future<T> just like push().',
            buttonLabel: 'pushNamed() to destination',
            onTap: () => context.pushNamed(
              RouteNames.navDestination,
              extra: 'pushNamed()',
            ),
          ),
          _Section(
            method: 'context.replaceNamed()',
            color: Colors.amber.shade700,
            description:
                'Same as replace() but uses the route name. '
                'Used in SearchScreen to update the URL query param '
                'without adding to history.',
            buttonLabel: 'replaceNamed() to destination',
            onTap: () => context.replaceNamed(
              RouteNames.navDestination,
              extra: 'replaceNamed()',
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String method;
  final Color color;
  final String description;
  final String buttonLabel;
  final VoidCallback onTap;

  const _Section({
    required this.method,
    required this.color,
    required this.description,
    required this.buttonLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            method,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4),
          Text(description, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonal(
              onPressed: onTap,
              style: FilledButton.styleFrom(
                backgroundColor: color.withValues(alpha: 0.15),
                foregroundColor: color,
              ),
              child: Text(buttonLabel),
            ),
          ),
        ],
      ),
    );
  }
}
