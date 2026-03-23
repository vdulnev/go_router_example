import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/auth_notifier.dart';
import '../../../core/navigation/route_names.dart';
import '../../../core/widgets/feature_card.dart';

/// Tab 0 — Home.
///
/// Hub screen that links to every GoRouter feature demonstrated in this app.
class HomeScreen extends StatelessWidget {
  final AuthNotifier authNotifier;

  const HomeScreen({super.key, required this.authNotifier});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoRouter Features'),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primaryContainer,
        foregroundColor: theme.colorScheme.onPrimaryContainer,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionHeader('Core Routing'),
          FeatureCard(
            title: 'Named Routes',
            description:
                'Navigate using GoRoute(name:) and context.goNamed(). '
                'See the Catalog tab.',
            icon: Icons.label_outline,
            color: Colors.indigo,
            badge: '#1',
            onTap: () => context.go('/catalog'),
          ),
          FeatureCard(
            title: 'Path Parameters  (:id)',
            description:
                'Access state.pathParameters["id"] for dynamic segments. '
                'Navigate to an article.',
            icon: Icons.route,
            color: Colors.blue,
            badge: '#2',
            onTap: () => context.goNamed(
              RouteNames.article,
              pathParameters: {'id': '42'},
            ),
          ),
          FeatureCard(
            title: 'Query Parameters (?q=)',
            description:
                'Read state.uri.queryParameters["q"]. '
                'Updates the URL without a full navigation.',
            icon: Icons.search,
            color: Colors.teal,
            badge: '#3',
            onTap: () => context.goNamed(
              RouteNames.homeSearch,
              queryParameters: {'q': 'flutter'},
            ),
          ),
          FeatureCard(
            title: 'StatefulShellRoute (Bottom Nav)',
            description:
                'Preserves navigator state per tab. '
                'Switch tabs and scroll positions are kept.',
            icon: Icons.tab_outlined,
            color: Colors.deepPurple,
            badge: '#4',
            onTap: () => context.go('/catalog'),
          ),
          const SizedBox(height: 8),
          _SectionHeader('Auth & Redirects'),
          FeatureCard(
            title: 'Global Redirect (refreshListenable)',
            description:
                'Protected route → redirect to login. '
                'Logout triggers automatic re-evaluation.',
            icon: Icons.lock_outline,
            color: Colors.orange,
            badge: '#5',
            onTap: () => context.go('/profile'),
          ),
          FeatureCard(
            title: 'Route-Level Redirect',
            description:
                'Redirect inside GoRoute.redirect. '
                'Only allowed users reach /profile/edit.',
            icon: Icons.block,
            color: Colors.red,
            badge: '#6',
            onTap: () => context.go('/profile/edit'),
          ),
          const SizedBox(height: 8),
          _SectionHeader('Error Handling'),
          FeatureCard(
            title: 'Custom Error Page (errorBuilder)',
            description:
                'Navigates to a non-existent URL to trigger the 404 screen.',
            icon: Icons.error_outline,
            color: Colors.redAccent,
            badge: '#7',
            onTap: () => context.go('/this-route-does-not-exist'),
          ),
          const SizedBox(height: 8),
          _SectionHeader('Advanced Features'),
          FeatureCard(
            title: 'Navigation Extras',
            description:
                'Pass typed objects via state.extra. '
                'Tap a Catalog item to see it in action.',
            icon: Icons.inventory_2_outlined,
            color: Colors.green,
            badge: '#8',
            onTap: () => context.go('/catalog'),
          ),
          FeatureCard(
            title: 'Custom Transitions',
            description:
                'CustomTransitionPage with slide-from-bottom animation. '
                'Lab → Transitions.',
            icon: Icons.animation,
            color: Colors.pink,
            badge: '#9',
            onTap: () => context.goNamed(RouteNames.transitions),
          ),
          FeatureCard(
            title: 'Nested Routes (3 levels)',
            description:
                'Home → Article → Comments. '
                'Path params inherited across nesting levels.',
            icon: Icons.account_tree_outlined,
            color: Colors.cyan,
            badge: '#10',
            onTap: () => context.goNamed(
              RouteNames.article,
              pathParameters: {'id': '1'},
            ),
          ),
          FeatureCard(
            title: 'go / push / replace / pop',
            description:
                'Different navigation methods and their stack effects. '
                'Lab → Navigation Methods.',
            icon: Icons.swap_horiz,
            color: Colors.amber,
            badge: '#11',
            onTap: () => context.goNamed(RouteNames.navigationMethods),
          ),
          FeatureCard(
            title: 'Pop with Result',
            description:
                'await context.push<T>() returns a value when the pushed '
                'screen calls context.pop(result).',
            icon: Icons.reply,
            color: Colors.lime,
            badge: '#12',
            onTap: () => context.goNamed(RouteNames.popResult),
          ),
          FeatureCard(
            title: 'Named Navigation (goNamed / pushNamed)',
            description:
                'Navigate by route name with typed path & query parameters.',
            icon: Icons.tag,
            color: Colors.purple,
            badge: '#13',
            onTap: () => context.goNamed(RouteNames.namedNav),
          ),
          FeatureCard(
            title: 'NavigatorObserver',
            description:
                'Observe every push/pop/replace event. '
                'Lab → Observer.',
            icon: Icons.visibility_outlined,
            color: Colors.brown,
            badge: '#14',
            onTap: () => context.goNamed(RouteNames.observer),
          ),
          FeatureCard(
            title: 'GoRouterState Inspector',
            description:
                'Inspect uri, path, pathParameters, extra, pageKey and more.',
            icon: Icons.info_outline,
            color: Colors.blueGrey,
            badge: '#15',
            onTap: () => context.goNamed(
              RouteNames.routerState,
              pathParameters: {},
              queryParameters: {'demo': 'true', 'tab': 'home'},
            ),
          ),
          FeatureCard(
            title: 'canPop() & GoRouter.of()',
            description:
                'Check whether the router can pop. Access the GoRouter '
                'instance from anywhere.',
            icon: Icons.undo,
            color: Colors.deepOrange,
            badge: '#16',
            onTap: () => context.goNamed(RouteNames.canPop),
          ),
          FeatureCard(
            title: 'ShellRoute (Simple)',
            description:
                'Unlike StatefulShellRoute, ShellRoute does NOT preserve '
                'child state when switching tabs.',
            icon: Icons.layers_outlined,
            color: Colors.teal,
            badge: '#17',
            onTap: () => context.goNamed(RouteNames.shellChildA),
          ),
          FeatureCard(
            title: 'onEnter (go_router v17)',
            description:
                'New v17 API — intercept navigation before routes are '
                'resolved. Check the Observer log.',
            icon: Icons.bolt,
            color: Colors.yellow.shade700,
            badge: '#18',
            onTap: () => context.goNamed(RouteNames.observer),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(4, 8, 4, 6),
    child: Text(
      title,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
