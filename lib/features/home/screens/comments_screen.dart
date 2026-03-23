import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Level 3 of the nested route: /article/:id/comments.
///
/// Demonstrates:
/// - Feature 10: Deeply nested routes (3 levels)
/// - Feature 16: canPop() — back button icon changes based on pop availability
/// - The :id path parameter is inherited from the parent route.
class CommentsScreen extends StatelessWidget {
  final String articleId;

  const CommentsScreen({super.key, required this.articleId});

  static const _comments = [
    ('Alice', 'Great article! Really helped me understand GoRouter nesting.'),
    ('Bob', 'The path parameter inheritance is a killer feature.'),
    ('Carol', 'I switched from Navigator 1.0 and never looked back.'),
    ('Dave', 'context.goNamed() with pathParameters is so clean.'),
    ('Eve', 'Love how the URL stays in sync with the widget tree.'),
  ];

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final canPop = context.canPop();

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments — Article #$articleId'),
        leading: canPop
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
                tooltip: 'context.pop() — canPop: true',
              )
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => context.go('/'),
                tooltip: 'canPop: false — go home instead',
              ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Feature #10 — Nested Routes (level 3)',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Full path: ${state.fullPath ?? '—'}\n'
                  'Inherited pathParameters[id]: ${state.pathParameters['id']}\n'
                  'canPop(): $canPop',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ..._comments.map(
            (c) => Card(
              child: ListTile(
                leading: CircleAvatar(child: Text(c.$1[0])),
                title: Text(c.$1),
                subtitle: Text(c.$2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.home),
            label: const Text('context.go("/") — back to root'),
          ),
        ],
      ),
    );
  }
}
