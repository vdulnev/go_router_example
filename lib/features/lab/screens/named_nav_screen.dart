import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/route_names.dart';

/// Demonstrates Feature 13: Named Navigation.
///
/// Shows goNamed(), pushNamed(), and replaceNamed() with pathParameters
/// and queryParameters maps.
class NamedNavScreen extends StatelessWidget {
  const NamedNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Named Navigation')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _InfoCard(
            'Feature #13 — Named Navigation\n\n'
            'Route names are defined in RouteNames as const strings.\n'
            'Named navigation avoids hard-coded URL paths — if a path '
            'changes, only the router needs updating.',
          ),
          const SizedBox(height: 16),
          _NamedNavSection(
            method: 'context.goNamed()',
            description:
                'Navigate by name. Equivalent to context.go() but '
                'path is looked up from the route name.',
            code:
                'context.goNamed(\n'
                '  RouteNames.article,\n'
                '  pathParameters: {"id": "1"},\n'
                ')',
            onTap: () => context.goNamed(
              RouteNames.article,
              pathParameters: {'id': '1'},
              extra: 'Arrived via goNamed()',
            ),
          ),
          _NamedNavSection(
            method: 'context.pushNamed()',
            description:
                'Push by name. Adds to the navigator stack. '
                'Back button returns here.',
            code:
                'context.pushNamed(\n'
                '  RouteNames.article,\n'
                '  pathParameters: {"id": "2"},\n'
                ')',
            onTap: () => context.pushNamed(
              RouteNames.article,
              pathParameters: {'id': '2'},
              extra: 'Arrived via pushNamed()',
            ),
          ),
          _NamedNavSection(
            method: 'context.replaceNamed()',
            description:
                'Replace top of stack by name. This screen is removed '
                'from history.',
            code:
                'context.replaceNamed(\n'
                '  RouteNames.article,\n'
                '  pathParameters: {"id": "3"},\n'
                ')',
            onTap: () => context.replaceNamed(
              RouteNames.article,
              pathParameters: {'id': '3'},
              extra: 'Arrived via replaceNamed()',
            ),
          ),
          _NamedNavSection(
            method: 'goNamed() + queryParameters',
            description:
                'Pass query parameters as a map. They appear in the URL '
                'and are accessible via state.uri.queryParameters.',
            code:
                'context.goNamed(\n'
                '  RouteNames.homeSearch,\n'
                '  queryParameters: {"q": "GoRouter"},\n'
                ')',
            onTap: () => context.goNamed(
              RouteNames.homeSearch,
              queryParameters: {'q': 'GoRouter named nav'},
            ),
          ),
          _NamedNavSection(
            method: 'GoRouterState.namedLocation()',
            description:
                'Build a URL string from a named route without navigating. '
                'Useful for clipboard or sharing.',
            code:
                'GoRouterState.of(context).namedLocation(\n'
                '  RouteNames.article,\n'
                '  pathParameters: {"id": "42"},\n'
                ')',
            onTap: () {
              final url = GoRouterState.of(
                context,
              ).namedLocation(RouteNames.article, pathParameters: {'id': '42'});
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('URL: $url')));
            },
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String text;
  const _InfoCard(this.text);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    ),
  );
}

class _NamedNavSection extends StatelessWidget {
  final String method;
  final String description;
  final String code;
  final VoidCallback onTap;

  const _NamedNavSection({
    required this.method,
    required this.description,
    required this.code,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            method,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(description, style: theme.textTheme.bodySmall),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              code,
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonal(
              onPressed: onTap,
              child: Text('Run $method'),
            ),
          ),
        ],
      ),
    );
  }
}
