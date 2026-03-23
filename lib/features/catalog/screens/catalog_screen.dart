import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/catalog_item.dart';
import '../../../core/navigation/route_names.dart';

/// Tab 1 — Catalog.
///
/// Demonstrates:
/// - Feature 8: Navigation extras (passes [CatalogItem] via state.extra)
/// - Feature 1 & 13: Named routes — uses context.goNamed() to navigate
class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catalog')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Feature #8 — Navigation Extras\n'
                      'Tap an item to pass it as state.extra.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: CatalogItem.samples.length,
              itemBuilder: (context, index) {
                final item = CatalogItem.samples[index];
                return _ItemCard(item: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final CatalogItem item;
  const _ItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Navigate using goNamed() + pathParameters + extra
          // (Features #1, #13, #8)
          context.goNamed(
            RouteNames.catalogItem,
            pathParameters: {'id': item.id},
            extra: item, // Passed as state.extra in the destination
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(item.emoji, style: const TextStyle(fontSize: 40)),
              const SizedBox(height: 8),
              Text(
                item.name,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'ID: ${item.id}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
