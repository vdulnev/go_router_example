import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Color picker — the pushed screen in the pop-with-result demo.
///
/// Calls context.pop(colorName) to resolve the Future in PopResultScreen.
class PopColorPickerScreen extends StatelessWidget {
  const PopColorPickerScreen({super.key});

  static const _colors = [
    ('Red', Color(0xFFE53935)),
    ('Green', Color(0xFF43A047)),
    ('Blue', Color(0xFF1E88E5)),
    ('Purple', Color(0xFF8E24AA)),
    ('Orange', Color(0xFFFF7043)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick a Color')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Tap a color to call context.pop(colorName) and return '
              'the result to the caller.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: _colors
                  .map(
                    (c) => _ColorTile(
                      name: c.$1,
                      color: c.$2,
                      onTap: () => context.pop(c.$1),
                    ),
                  )
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: OutlinedButton(
              onPressed: () => context.pop(null),
              child: const Text('Cancel  (pop null)'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorTile extends StatelessWidget {
  final String name;
  final Color color;
  final VoidCallback onTap;
  const _ColorTile({
    required this.name,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    ),
  );
}
