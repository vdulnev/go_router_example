import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/auth_notifier.dart';
import '../../../core/navigation/route_names.dart';

/// Tab 2 — Profile.
///
/// Demonstrates Feature 5: Global redirect with refreshListenable.
/// - This route is protected: unauthenticated users are redirected to /login.
/// - Calling logout() triggers AuthNotifier.notifyListeners() →
///   GoRouter.refreshListenable fires → redirect re-evaluates → redirect to /login.
class ProfileScreen extends StatelessWidget {
  final AuthNotifier authNotifier;

  const ProfileScreen({super.key, required this.authNotifier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Text(
                    authNotifier.username.isNotEmpty
                        ? authNotifier.username[0].toUpperCase()
                        : '?',
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  authNotifier.username,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _InfoTile(
            title: 'Feature #5 — Global Redirect',
            subtitle:
                'This screen is behind an auth guard.\n'
                'Logging out triggers refreshListenable → '
                'GoRouter re-evaluates the redirect → '
                'you are sent to /login.',
            icon: Icons.lock_outline,
            color: Colors.orange,
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            value: authNotifier.allowProfileEdit,
            onChanged: (_) => authNotifier.toggleProfileEdit(),
            title: const Text('Allow Profile Edit'),
            subtitle: const Text(
              'Feature #6 — Route-level redirect:\n'
              'OFF → /profile/edit redirects back here.',
            ),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: () => context.goNamed(RouteNames.profileEdit),
            icon: const Icon(Icons.edit),
            label: const Text('Edit Profile  (route-level redirect demo)'),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () {
              authNotifier.logout();
              // After logout, refreshListenable fires and GoRouter automatically
              // redirects to /login — no manual navigation needed.
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout  (triggers refreshListenable)'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  const _InfoTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ],
    ),
  );
}
