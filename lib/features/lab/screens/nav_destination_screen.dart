import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/route_names.dart';

/// Destination screen for the navigation methods demo.
///
/// Receives the navigation method name via [GoRouterState.extra] and
/// displays whether the screen can be popped (Feature 16).
class NavDestinationScreen extends StatelessWidget {
  final String? method;

  const NavDestinationScreen({super.key, this.method});

  @override
  Widget build(BuildContext context) {
    final canPop = context.canPop();

    return Scaffold(
      appBar: AppBar(title: const Text('Destination')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '🏁',
              style: TextStyle(fontSize: 64),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (method != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Arrived via: $method',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontFamily: 'monospace',
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 16),
            _InfoRow(
              label: 'context.canPop()',
              value: '$canPop',
              description: canPop
                  ? 'Back button will pop this screen'
                  : 'No stack entry to pop — use go() to navigate away',
              ok: canPop,
            ),
            const SizedBox(height: 24),
            if (canPop)
              FilledButton.icon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
                label: const Text('context.pop()'),
              )
            else
              FilledButton.icon(
                onPressed: () => context.goNamed(RouteNames.navigationMethods),
                icon: const Icon(Icons.arrow_back),
                label: const Text('context.go() back to demo'),
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final String description;
  final bool ok;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.description,
    required this.ok,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = ok ? Colors.green : Colors.orange;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(ok ? Icons.check_circle : Icons.info_outline, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$label → $value',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(description, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
