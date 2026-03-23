import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Demonstrates Feature 15: GoRouterState.
///
/// Displays every field available on the GoRouterState for this route.
/// Navigate here with pathParameters and queryParameters to see them populated.
class RouterStateScreen extends StatelessWidget {
  const RouterStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the current route's state — available anywhere in the widget tree
    // below a GoRoute. No need to pass it down manually.
    final state = GoRouterState.of(context);

    final entries = <(String, String, String)>[
      (
        'uri',
        state.uri.toString(),
        'Full URI including scheme, path and query',
      ),
      (
        'matchedLocation',
        state.matchedLocation,
        'The portion of the URL matched by this route',
      ),
      (
        'fullPath',
        state.fullPath ?? '—',
        'Full path template including parent segments',
      ),
      ('path', state.path ?? '—', 'This route\'s own path segment'),
      ('name', state.name ?? '—', 'The route\'s name (from GoRoute.name)'),
      (
        'pathParameters',
        state.pathParameters.isEmpty ? '{}' : state.pathParameters.toString(),
        'Extracted :param values from the URL path',
      ),
      (
        'queryParameters',
        state.uri.queryParameters.isEmpty
            ? '{}'
            : state.uri.queryParameters.toString(),
        'Values after the ? in the URL',
      ),
      (
        'extra',
        state.extra?.toString() ?? 'null',
        'Object passed via context.go(extra:). null on deep link.',
      ),
      (
        'pageKey',
        state.pageKey.value,
        'Unique ValueKey for this page instance',
      ),
      (
        'error',
        state.error?.toString() ?? 'null',
        'GoException if this is an error route',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('GoRouterState Inspector')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Feature #15 — GoRouterState.of(context)\n\n'
              'Every field below is read from GoRouterState.of(context). '
              'Navigate here with ?demo=true&tab=lab to see query parameters '
              'populated.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          ...entries.map(
            (e) => _StateRow(field: e.$1, value: e.$2, desc: e.$3),
          ),
        ],
      ),
    );
  }
}

class _StateRow extends StatelessWidget {
  final String field;
  final String value;
  final String desc;
  const _StateRow({
    required this.field,
    required this.value,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEmpty = value == '—' || value == '{}' || value == 'null';
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isEmpty
            ? theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
            : theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                field,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: isEmpty
                      ? theme.colorScheme.onSurfaceVariant
                      : theme.colorScheme.primary,
                ),
              ),
              if (isEmpty) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outline.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    'empty',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            desc,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
