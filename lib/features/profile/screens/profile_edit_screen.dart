import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/route_names.dart';

/// Demonstrates Feature 6: Route-level redirect.
///
/// The GoRoute for /profile/edit has its own redirect callback that checks
/// AuthNotifier.allowProfileEdit. If false, the user is sent back to /profile.
/// This is distinct from the global redirect (Feature 5) because it is
/// evaluated per-route inside the GoRoute definition.
class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _nameController = TextEditingController(text: 'Alice');

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Feature #6 — Route-Level Redirect\n\n'
              'You reached this screen because the route-level redirect in '
              'GoRoute(path: "edit", redirect: ...) checked '
              'AuthNotifier.allowProfileEdit == true.\n\n'
              'Toggle the switch on /profile to block access.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Display Name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Saved: ${_nameController.text}')),
              );
              context.goNamed(RouteNames.profile);
            },
            child: const Text('Save'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () => context.goNamed(RouteNames.profile),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
