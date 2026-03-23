import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Demonstrates Feature 9: Custom Page Transitions.
///
/// This screen itself is reached via a [CustomTransitionPage] with a
/// slide-from-bottom animation defined in app_router.dart using pageBuilder.
/// From here you can push more screens with different custom transitions.
class TransitionsScreen extends StatelessWidget {
  const TransitionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Transitions')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _InfoCard(
            'Feature #9 — CustomTransitionPage',
            'This screen was pushed via pageBuilder → CustomTransitionPage '
                'with a slide-from-bottom animation.\n\n'
                'In app_router.dart:\n'
                'GoRoute(\n'
                '  path: "transitions",\n'
                '  pageBuilder: (ctx, state) => CustomTransitionPage(\n'
                '    child: TransitionsScreen(),\n'
                '    transitionsBuilder: (ctx, anim, _, child) {\n'
                '      return SlideTransition(\n'
                '        position: Tween(begin: Offset(0,1), end: Offset.zero)\n'
                '          .animate(anim),\n'
                '        child: child,\n'
                '      );\n'
                '    },\n'
                '  ),\n'
                ')',
          ),
          const SizedBox(height: 16),
          Text(
            'Push screens with different transitions:',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          _TransitionButton(
            label: 'Fade Transition',
            icon: Icons.blur_on,
            onTap: () => _pushWithTransition(
              context,
              'Fade',
              (ctx, anim, _, child) =>
                  FadeTransition(opacity: anim, child: child),
            ),
          ),
          _TransitionButton(
            label: 'Scale Transition',
            icon: Icons.zoom_in,
            onTap: () => _pushWithTransition(
              context,
              'Scale',
              (ctx, anim, _, child) => ScaleTransition(
                scale: CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
                child: child,
              ),
            ),
          ),
          _TransitionButton(
            label: 'Slide from Right',
            icon: Icons.arrow_forward,
            onTap: () => _pushWithTransition(
              context,
              'Slide from Right',
              (ctx, anim, _, child) => SlideTransition(
                position: Tween(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
                child: child,
              ),
            ),
          ),
          _TransitionButton(
            label: 'Rotation + Scale',
            icon: Icons.rotate_right,
            onTap: () => _pushWithTransition(
              context,
              'Rotation + Scale',
              (ctx, anim, _, child) => RotationTransition(
                turns: Tween(
                  begin: 0.8,
                  end: 1.0,
                ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
                child: ScaleTransition(scale: anim, child: child),
              ),
            ),
          ),
          _TransitionButton(
            label: 'No Transition (NoTransitionPage)',
            icon: Icons.block,
            onTap: () {
              Navigator.of(context).push(
                NoTransitionPage<void>(
                  child: _TransitionDetailScreen(
                    transitionName: 'No Transition',
                    description:
                        'NoTransitionPage renders the page immediately '
                        'without any animation. Useful for replacing '
                        'screens without visual noise.',
                  ),
                ).createRoute(context),
              );
            },
          ),
        ],
      ),
    );
  }

  void _pushWithTransition(
    BuildContext context,
    String name,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)
    builder,
  ) {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (_, _, _) => _TransitionDetailScreen(
          transitionName: name,
          description:
              'This screen was pushed using a custom $name transition '
              'via PageRouteBuilder (for demo). In production you would '
              'use GoRoute.pageBuilder → CustomTransitionPage.',
        ),
        transitionsBuilder: builder,
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }
}

class _TransitionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _TransitionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: FilledButton.tonalIcon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
    ),
  );
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String body;
  const _InfoCard(this.title, this.body);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          body,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

class _TransitionDetailScreen extends StatelessWidget {
  final String transitionName;
  final String description;
  const _TransitionDetailScreen({
    required this.transitionName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(transitionName)),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, size: 64),
            const SizedBox(height: 16),
            Text(
              transitionName,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go back'),
            ),
          ],
        ),
      ),
    ),
  );
}
