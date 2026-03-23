import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/route_names.dart';
import '../widgets/lab_list_tile.dart';

/// Tab 3 — Lab.
///
/// Hub screen for advanced GoRouter features. Each tile navigates to a
/// dedicated demo screen. Also demonstrates Feature 17: GoRouter.of(context).
class LabScreen extends StatelessWidget {
  const LabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Feature 17: GoRouter.of(context)
    final router = GoRouter.of(context);
    final currentUri = router.routerDelegate.currentConfiguration.uri;

    return Scaffold(
      appBar: AppBar(title: const Text('Feature Lab')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Feature #17 — GoRouter.of(context)',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'router.routerDelegate.currentConfiguration.uri\n→ $currentUri',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
          LabListTile(
            featureNumber: 9,
            title: 'Custom Page Transitions',
            description:
                'pageBuilder returning CustomTransitionPage with '
                'a slide-from-bottom animation.',
            onTap: () => context.goNamed(RouteNames.transitions),
          ),
          LabListTile(
            featureNumber: 11,
            title: 'go / push / replace / pop',
            description:
                'Understand the stack difference between each navigation method.',
            onTap: () => context.goNamed(RouteNames.navigationMethods),
          ),
          LabListTile(
            featureNumber: 12,
            title: 'Pop with Result',
            description:
                'await context.push<T>() returns a value from context.pop(result).',
            onTap: () => context.goNamed(RouteNames.popResult),
          ),
          LabListTile(
            featureNumber: 13,
            title: 'Named Navigation',
            description:
                'context.goNamed / pushNamed / replaceNamed with '
                'pathParameters and queryParameters.',
            onTap: () => context.goNamed(RouteNames.namedNav),
          ),
          LabListTile(
            featureNumber: 15,
            title: 'GoRouterState Inspector',
            description:
                'Inspect all GoRouterState fields: uri, path, '
                'pathParameters, extra, pageKey…',
            onTap: () => context.goNamed(
              RouteNames.routerState,
              queryParameters: {'demo': 'true', 'tab': 'lab'},
            ),
          ),
          LabListTile(
            featureNumber: 16,
            title: 'canPop() & GoRouter.of()',
            description:
                'Programmatically check pop availability. '
                'Access the raw GoRouter instance.',
            onTap: () => context.goNamed(RouteNames.canPop),
          ),
          LabListTile(
            featureNumber: 17,
            title: 'ShellRoute (Simple)',
            description:
                'Unlike StatefulShellRoute, ShellRoute does NOT preserve '
                'child navigator state between tab switches.',
            onTap: () => context.goNamed(RouteNames.shellChildA),
          ),
          LabListTile(
            featureNumber: 14,
            title: 'NavigatorObserver',
            description:
                'Live log of every push/pop/replace/remove event '
                'captured by AppNavigatorObserver.',
            onTap: () => context.goNamed(RouteNames.observer),
          ),
          LabListTile(
            featureNumber: 18,
            title: 'onEnter (go_router v17)',
            description:
                'New v17 API. Intercept navigation before route resolution. '
                'Events appear in the Observer log.',
            onTap: () => context.goNamed(RouteNames.observer),
          ),
        ],
      ),
    );
  }
}
