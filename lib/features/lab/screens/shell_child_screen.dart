import 'package:flutter/material.dart';

/// Reused for both Child A and Child B inside the ShellRoute demo.
///
/// Contains a long list so scroll position loss is visible when switching tabs.
class ShellChildScreen extends StatelessWidget {
  final String label;

  const ShellChildScreen({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) => ListTile(
        leading: Text(
          label == 'Child A' ? '🔴' : '🔵',
          style: const TextStyle(fontSize: 18),
        ),
        title: Text('$label — Item ${index + 1}'),
        subtitle: index == 0
            ? const Text(
                'Scroll down, then switch tabs — scroll resets!',
                style: TextStyle(fontStyle: FontStyle.italic),
              )
            : null,
      ),
    );
  }
}
