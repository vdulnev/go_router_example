import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/app_navigator_observer.dart';
import '../../../core/navigation/route_names.dart';

/// Demonstrates Features 14 & 18:
/// - Feature 14: NavigatorObserver — live log of every navigation event
/// - Feature 18: onEnter (go_router v17) — events prefixed with ⚡ in the log
class ObserverScreen extends StatelessWidget {
  const ObserverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Observer Log'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Clear log',
            onPressed: () {
              AppNavigatorObserver.eventLog.value = [];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Feature #14 — NavigatorObserver\n'
                'Events logged: didPush, didPop, didReplace, didRemove\n\n'
                'Feature #18 — onEnter (go_router v17)\n'
                '⚡ prefixed events are from the onEnter callback.\n'
                'onEnter fires before the route is resolved.\n\n'
                'Navigate around the app then return here to see the log.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Wrap(
              spacing: 8,
              children: [
                ActionChip(
                  label: const Text('Push screen'),
                  onPressed: () => context.pushNamed(RouteNames.canPop),
                ),
                ActionChip(
                  label: const Text('Go to Home'),
                  onPressed: () => context.go('/'),
                ),
                ActionChip(
                  label: const Text('Go to Catalog'),
                  onPressed: () => context.go('/catalog'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          Expanded(
            child: ValueListenableBuilder<List<String>>(
              valueListenable: AppNavigatorObserver.eventLog,
              builder: (context, events, _) {
                if (events.isEmpty) {
                  return const Center(
                    child: Text(
                      'No events yet.\nNavigate around the app.',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    final isOnEnter = event.contains('⚡');
                    return Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isOnEnter
                            ? Theme.of(context).colorScheme.tertiaryContainer
                                  .withValues(alpha: 0.5)
                            : Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        event,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                          color: isOnEnter
                              ? Theme.of(context).colorScheme.tertiary
                              : null,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
