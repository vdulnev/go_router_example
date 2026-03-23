import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/route_names.dart';

/// Demonstrates Feature 12: push() with a typed return value.
///
/// Awaits `context.push<String>()` and displays the color string returned
/// when the picker screen calls context.pop('red').
class PopResultScreen extends StatefulWidget {
  const PopResultScreen({super.key});

  @override
  State<PopResultScreen> createState() => _PopResultScreenState();
}

class _PopResultScreenState extends State<PopResultScreen> {
  String? _pickedColor;
  int _pickCount = 0;

  Future<void> _pickColor() async {
    // Feature 12: push returns a Future<String?> resolved by context.pop(value)
    final color = await context.pushNamed<String>(RouteNames.popResultPicker);
    if (color != null && mounted) {
      setState(() {
        _pickedColor = color;
        _pickCount++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pop with Result')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Feature #12 — Pop with Result\n\n'
                'final color = await context.pushNamed<String>(\n'
                '  RouteNames.popResultPicker,\n'
                ');\n\n'
                '// In the picker:\n'
                'context.pop("red");  // resolves the Future',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(height: 32),
            if (_pickedColor != null) ...[
              _ColorResult(colorName: _pickedColor!, pickCount: _pickCount),
              const SizedBox(height: 24),
            ],
            FilledButton.icon(
              onPressed: _pickColor,
              icon: const Icon(Icons.color_lens_outlined),
              label: const Text('Pick a Color  (push & await)'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorResult extends StatelessWidget {
  final String colorName;
  final int pickCount;
  const _ColorResult({required this.colorName, required this.pickCount});

  static const _colorMap = {
    'Red': Color(0xFFE53935),
    'Green': Color(0xFF43A047),
    'Blue': Color(0xFF1E88E5),
    'Purple': Color(0xFF8E24AA),
    'Orange': Color(0xFFFF7043),
  };

  @override
  Widget build(BuildContext context) {
    final color = _colorMap[colorName] ?? Colors.grey;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color, radius: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Picked: $colorName',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  'Times picked: $pickCount',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
