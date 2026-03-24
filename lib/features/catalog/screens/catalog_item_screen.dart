import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/catalog_item.dart';
import '../../../core/navigation/route_names.dart';

/// Demonstrates Feature 8: Navigation Extras.
/// The [CatalogItem] object was passed via `state.extra` when navigating here.
/// Refreshing the page (deep link) loses `extra` because it's in-memory only.
class CatalogItemScreen extends StatefulWidget {
  final CatalogItem item;

  const CatalogItemScreen({super.key, required this.item});

  @override
  State<CatalogItemScreen> createState() => _CatalogItemScreenState();
}

class _CatalogItemScreenState extends State<CatalogItemScreen> {
  String? _reviewResult;

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final extraPresent = state.extra != null;

    return Scaffold(
      appBar: AppBar(title: Text(widget.item.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(widget.item.emoji, style: const TextStyle(fontSize: 64)),
          const SizedBox(height: 12),
          Text(
            widget.item.name,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(widget.item.description),
          const SizedBox(height: 16),
          _InfoChip(
            label: 'Feature #8 — state.extra',
            value: extraPresent
                ? 'CatalogItem present ✅'
                : 'null ❌ (page refreshed or deep linked)',
            ok: extraPresent,
          ),
          _InfoChip(
            label: 'pathParameters[id]',
            value: state.pathParameters['id'] ?? '—',
            ok: true,
          ),
          _InfoChip(label: 'Full URI', value: state.uri.toString(), ok: true),
          const SizedBox(height: 16),
          if (_reviewResult != null)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Review result (from pop): "$_reviewResult"',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
              ),
            ),
          FilledButton.icon(
            onPressed: () async {
              // Feature 12: pop with result
              final result = await context.pushNamed<String>(
                RouteNames.catalogReviews,
                pathParameters: {'id': widget.item.id},
              );
              if (result != null && mounted) {
                setState(() => _reviewResult = result);
              }
            },
            icon: const Icon(Icons.star_outline),
            label: const Text('View Reviews  (pop with result demo)'),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  final bool ok;
  const _InfoChip({required this.label, required this.value, required this.ok});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = ok
        ? theme.colorScheme.surfaceContainerHighest
        : theme.colorScheme.errorContainer;
    final fg = ok
        ? theme.colorScheme.onSurfaceVariant
        : theme.colorScheme.onErrorContainer;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.labelSmall?.copyWith(color: fg)),
          Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              color: fg,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}
