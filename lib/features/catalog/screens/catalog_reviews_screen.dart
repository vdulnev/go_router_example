import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Level 3: /catalog/:id/reviews.
///
/// Demonstrates Feature 12: pop() with a result.
/// The caller awaits context.pushNamed(...) and receives the value
/// passed to context.pop(result) here.
class CatalogReviewsScreen extends StatelessWidget {
  final String itemId;

  const CatalogReviewsScreen({super.key, required this.itemId});

  static const _reviews = [
    (5, 'Alice', 'Absolutely essential for Flutter routing!'),
    (5, 'Bob', 'Clean API, great deep-link support.'),
    (4, 'Carol', 'StatefulShellRoute is a game changer.'),
    (4, 'Dave', 'Took a bit to learn, totally worth it.'),
    (3, 'Eve', 'Docs could be more comprehensive.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reviews — Item #$itemId')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Feature #12 — Pop with Result',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tap a star rating below to pop this screen and return '
                  'a result to the caller.\n\n'
                  'Caller: await context.pushNamed(catalogReviews)\n'
                  'Here: context.pop("★★★★★ — Great review!")',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ..._reviews.map(
            (r) => Card(
              child: ListTile(
                leading: CircleAvatar(child: Text(r.$2[0])),
                title: Text(r.$2),
                subtitle: Text(r.$3),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '★' * r.$1,
                      style: const TextStyle(color: Colors.amber),
                    ),
                    const SizedBox(width: 4),
                    Tooltip(
                      message: 'Pop with this rating',
                      child: IconButton(
                        icon: const Icon(Icons.check_circle_outline),
                        onPressed: () {
                          // Feature 12: pop with a typed result
                          context.pop(
                            '${'★' * r.$1} — ${r.$2} said: "${r.$3}"',
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => context.pop(null),
            child: const Text('Dismiss (pop null)'),
          ),
        ],
      ),
    );
  }
}
