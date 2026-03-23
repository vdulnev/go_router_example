import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/route_names.dart';

/// Demonstrates Feature 2: Path Parameters.
/// The article id comes from [GoRouterState.pathParameters]['id'].
///
/// This is level 2 of the 3-level nested route:
/// / → /article/:id → /article/:id/comments
class ArticleScreen extends StatelessWidget {
  final String articleId;

  const ArticleScreen({super.key, required this.articleId});

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Article #$articleId')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _FeatureBadge('Feature #2 — Path Parameters'),
          const SizedBox(height: 16),
          _StateTable({
            'Route path template': state.fullPath ?? '—',
            'Matched location': state.matchedLocation,
            'pathParameters[id]': state.pathParameters['id'] ?? '—',
            'Full URI': state.uri.toString(),
          }),
          const SizedBox(height: 24),
          Text(
            'Article $articleId',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'This is the content of article #$articleId. The id was extracted '
            'from the URL path segment using '
            'GoRouterState.pathParameters["id"].\n\n'
            'Navigate to Comments to see the third level of nesting, where '
            'the same :id parameter is still accessible.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => context.goNamed(
              RouteNames.articleComments,
              pathParameters: {'id': articleId},
            ),
            icon: const Icon(Icons.comment_outlined),
            label: const Text('View Comments  (level 3 →)'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => context.pushNamed(
              RouteNames.articleComments,
              pathParameters: {'id': articleId},
            ),
            icon: const Icon(Icons.add),
            label: const Text('push() to Comments'),
          ),
        ],
      ),
    );
  }
}

class _FeatureBadge extends StatelessWidget {
  final String text;
  const _FeatureBadge(this.text);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      text,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

class _StateTable extends StatelessWidget {
  final Map<String, String> entries;
  const _StateTable(this.entries);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: entries.entries.indexed
            .map(
              (e) => _Row(
                label: e.$2.key,
                value: e.$2.value,
                isLast: e.$1 == entries.length - 1,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;
  const _Row({required this.label, required this.value, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast) const Divider(height: 1, indent: 12, endIndent: 12),
      ],
    );
  }
}
