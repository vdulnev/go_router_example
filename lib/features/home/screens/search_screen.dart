import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/route_names.dart';

/// Search screen driven entirely by URL query parameters.
///
/// Demonstrates Feature 3: Query Parameters.
/// The search query is stored in the URL as `?q=term`.
/// When the user types, the URL is updated via [BuildContext.replaceNamed]
/// without adding a new history entry.
class SearchScreen extends StatefulWidget {
  final String initialQuery;

  const SearchScreen({super.key, required this.initialQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _controller;
  static const _allItems = [
    'Flutter Animations',
    'Flutter State Management',
    'GoRouter Navigation',
    'Dart Async / Await',
    'Material You Design',
    'Firebase Integration',
    'Riverpod Providers',
    'Widget Testing',
    'Deep Linking',
    'Custom Painters',
    'Isolates & Concurrency',
    'Platform Channels',
  ];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<String> get _results {
    final q = _controller.text.toLowerCase();
    if (q.isEmpty) return _allItems;
    return _allItems.where((s) => s.toLowerCase().contains(q)).toList();
  }

  void _onChanged(String value) {
    setState(() {});
    // Update URL query param without pushing a new history entry.
    // URL becomes: /search?q=<value>
    context.replaceNamed(
      RouteNames.homeSearch,
      queryParameters: value.isNotEmpty ? {'q': value} : {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Query Parameters')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoBox('Current URL', state.uri.toString(), icon: Icons.link),
                const SizedBox(height: 8),
                _InfoBox(
                  'Query params',
                  state.uri.queryParameters.toString(),
                  icon: Icons.query_stats,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Search (?q=)',
                    hintText: 'Type to update the URL…',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _controller.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _controller.clear();
                              _onChanged('');
                            },
                          )
                        : null,
                  ),
                  onChanged: _onChanged,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: _results.isEmpty
                ? const Center(child: Text('No results'))
                : ListView.builder(
                    itemCount: _results.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: const Icon(Icons.article_outlined),
                      title: Text(_results[index]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _InfoBox(this.label, this.value, {required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  value,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
