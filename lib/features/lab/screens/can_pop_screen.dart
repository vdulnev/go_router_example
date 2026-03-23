import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/route_names.dart';

/// Demonstrates:
/// - Feature 16: context.canPop()
/// - Feature 17: GoRouter.of(context) — access the GoRouter instance
class CanPopScreen extends StatefulWidget {
  const CanPopScreen({super.key});

  @override
  State<CanPopScreen> createState() => _CanPopScreenState();
}

class _CanPopScreenState extends State<CanPopScreen> {
  @override
  Widget build(BuildContext context) {
    // Feature 16: canPop()
    final canPop = context.canPop();

    // Feature 17: GoRouter.of(context)
    final router = GoRouter.of(context);
    final currentUri = router.routerDelegate.currentConfiguration.uri;
    final routerState = router.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('canPop() & GoRouter.of()'),
        leading: canPop
            ? IconButton(
                tooltip: 'context.pop()',
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              )
            : null,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Card(
            title: 'Feature #16 — context.canPop()',
            items: [
              _Item(
                'canPop()',
                '$canPop',
                canPop ? Colors.green : Colors.orange,
              ),
              _Item(
                'Explanation',
                canPop
                    ? 'There is a route below — back button will pop.'
                    : 'No route below on the stack — cannot pop.',
                null,
              ),
            ],
          ),
          const SizedBox(height: 12),
          _Card(
            title: 'Feature #17 — GoRouter.of(context)',
            items: [
              _Item('router.runtimeType', router.runtimeType.toString(), null),
              _Item(
                'routerDelegate.currentConfiguration.uri',
                currentUri.toString(),
                null,
              ),
              _Item('router.state.uri', routerState.uri.toString(), null),
              _Item(
                'router.state.matchedLocation',
                routerState.matchedLocation,
                null,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Push this same screen again to make canPop() return true:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: () {
              context.pushNamed(RouteNames.canPop).then((_) {
                if (mounted) setState(() {});
              });
            },
            icon: const Icon(Icons.add),
            label: const Text('context.pushNamed(canPop)'),
          ),
          const SizedBox(height: 8),
          if (canPop)
            OutlinedButton.icon(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('context.pop()'),
            ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => context.goNamed(RouteNames.lab),
            icon: const Icon(Icons.home),
            label: const Text('context.goNamed(lab)'),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final List<_Item> items;
  const _Card({required this.title, required this.items});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        ...items,
      ],
    ),
  );
}

class _Item extends StatelessWidget {
  final String label;
  final String value;
  final Color? highlight;
  const _Item(this.label, this.value, this.highlight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: highlight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
