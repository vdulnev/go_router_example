import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/catalog/screens/catalog_item_screen.dart';
import '../../features/catalog/screens/catalog_reviews_screen.dart';
import '../../features/catalog/screens/catalog_screen.dart';
import '../../features/error/screens/error_screen.dart';
import '../../features/home/screens/article_screen.dart';
import '../../features/home/screens/comments_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/home/screens/search_screen.dart';
import '../../features/lab/screens/can_pop_screen.dart';
import '../../features/lab/screens/lab_screen.dart';
import '../../features/lab/screens/nav_destination_screen.dart';
import '../../features/lab/screens/named_nav_screen.dart';
import '../../features/lab/screens/navigation_methods_screen.dart';
import '../../features/lab/screens/observer_screen.dart';
import '../../features/lab/screens/pop_color_picker_screen.dart';
import '../../features/lab/screens/pop_result_screen.dart';
import '../../features/lab/screens/router_state_screen.dart';
import '../../features/lab/screens/shell_child_screen.dart';
import '../../features/lab/screens/shell_demo_screen.dart';
import '../../features/lab/screens/transitions_screen.dart';
import '../../features/profile/screens/profile_edit_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../auth/auth_notifier.dart';
import '../models/catalog_item.dart';
import '../widgets/main_scaffold.dart';
import 'app_navigator_observer.dart';
import 'route_names.dart';

/// Routes that require the user to be authenticated.
const _protectedPaths = {'/profile', '/profile/edit'};

/// Creates and configures the [GoRouter] for the demo app.
///
/// Features demonstrated in this file:
///  #1  Named routes       — GoRoute(name: RouteNames.xxx)
///  #2  Path parameters    — path: 'article/:id'
///  #3  Query parameters   — builder reads state.uri.queryParameters
///  #4  StatefulShellRoute — indexedStack with 4 branches
///  #5  Global redirect    — redirect + refreshListenable: authNotifier
///  #6  Route-level redir  — redirect inside GoRoute(path: 'edit')
///  #7  Custom error page  — errorBuilder
///  #8  Navigation extras  — builder casts state.extra as CatalogItem
///  #9  Custom transition  — pageBuilder → CustomTransitionPage
/// #10  Nested routes      — 3-level nesting (/ → article/:id → comments)
/// #14  NavigatorObserver  — observers: [AppNavigatorObserver()]
/// #17  ShellRoute (simple)— ShellRoute inside the lab branch
/// #18  onEnter (v17)      — intercepts navigation before resolution
GoRouter createRouter(AuthNotifier authNotifier) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,

    // Feature #14: NavigatorObserver
    observers: [AppNavigatorObserver()],

    // Feature #5 (part 1): refreshListenable — when authNotifier changes
    // (login/logout), GoRouter re-evaluates the redirect callback.
    refreshListenable: authNotifier,

    // Feature #18: onEnter (go_router v17)
    // Intercepts every navigation attempt BEFORE route resolution.
    // Returning Allow() lets navigation proceed.
    // Here we just log the event; you can also return Block.then(callback)
    // to guard routes or perform async checks.
    onEnter:
        (
          BuildContext context,
          GoRouterState current,
          GoRouterState next,
          GoRouter router,
        ) {
          AppNavigatorObserver.addOnEnterEvent('${current.uri} → ${next.uri}');
          return const Allow();
        },

    // Feature #5 (part 2): Global redirect — auth guard
    redirect: (BuildContext context, GoRouterState state) {
      final isLoggedIn = authNotifier.isLoggedIn;
      final location = state.matchedLocation;
      final isLoginRoute = location == '/login';
      final isProtected = _protectedPaths.any(location.startsWith);

      if (!isLoggedIn && isProtected) {
        // Encode the intended destination so login can redirect back.
        final from = Uri.encodeComponent(state.uri.toString());
        return '/login?from=$from';
      }

      if (isLoggedIn && isLoginRoute) {
        // After login, redirect to the original destination (if any).
        final from = state.uri.queryParameters['from'];
        if (from != null && from.isNotEmpty) {
          return Uri.decodeComponent(from);
        }
        return '/';
      }

      return null; // No redirect — allow navigation
    },

    // Feature #7: Custom error page
    errorBuilder: (BuildContext context, GoRouterState state) =>
        ErrorScreen(error: state.error),

    routes: [
      // ── Login ──────────────────────────────────────────────────────────
      // Feature #1: Named route
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        builder: (context, state) => LoginScreen(
          authNotifier: authNotifier,
          from: state.uri.queryParameters['from'],
        ),
      ),

      // ── Main Shell (4 tabs) ────────────────────────────────────────────
      // Feature #4: StatefulShellRoute.indexedStack
      // Each branch has its own Navigator — switching tabs preserves state.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainScaffold(navigationShell: navigationShell),
        branches: [
          // ── Branch 0: Home ─────────────────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                name: RouteNames.home,
                builder: (context, state) =>
                    HomeScreen(authNotifier: authNotifier),
                routes: [
                  // Feature #3: Query parameters
                  GoRoute(
                    path: 'search',
                    name: RouteNames.homeSearch,
                    builder: (context, state) => SearchScreen(
                      initialQuery: state.uri.queryParameters['q'] ?? '',
                    ),
                  ),
                  // Feature #2 & #10: Path parameters + nested routes (lvl 2)
                  GoRoute(
                    path: 'article/:id',
                    name: RouteNames.article,
                    builder: (context, state) =>
                        ArticleScreen(articleId: state.pathParameters['id']!),
                    routes: [
                      // Feature #10: Level 3 nesting
                      GoRoute(
                        path: 'comments',
                        name: RouteNames.articleComments,
                        builder: (context, state) => CommentsScreen(
                          // :id is inherited from the parent route's params
                          articleId: state.pathParameters['id']!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // ── Branch 1: Catalog ──────────────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/catalog',
                name: RouteNames.catalog,
                builder: (context, state) => const CatalogScreen(),
                routes: [
                  // Feature #2 & #8: Path params + navigation extras
                  GoRoute(
                    path: ':id',
                    name: RouteNames.catalogItem,
                    builder: (context, state) => CatalogItemScreen(
                      itemId: state.pathParameters['id']!,
                      // Feature #8: Cast state.extra to the expected type.
                      // extra is null when navigating via direct URL (deep link).
                      item: state.extra as CatalogItem?,
                    ),
                    routes: [
                      // Feature #10 & #12: Nested route + pop with result
                      GoRoute(
                        path: 'reviews',
                        name: RouteNames.catalogReviews,
                        builder: (context, state) => CatalogReviewsScreen(
                          itemId: state.pathParameters['id']!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // ── Branch 2: Profile ──────────────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                name: RouteNames.profile,
                builder: (context, state) =>
                    ProfileScreen(authNotifier: authNotifier),
                routes: [
                  // Feature #6: Route-level redirect
                  GoRoute(
                    path: 'edit',
                    name: RouteNames.profileEdit,
                    redirect: (context, state) {
                      // Route-level redirect — evaluated after the global
                      // redirect has already allowed the user through.
                      // Guards this specific sub-route independently.
                      if (!authNotifier.allowProfileEdit) {
                        return '/profile';
                      }
                      return null;
                    },
                    builder: (context, state) => const ProfileEditScreen(),
                  ),
                ],
              ),
            ],
          ),

          // ── Branch 3: Lab ──────────────────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/lab',
                name: RouteNames.lab,
                builder: (context, state) => const LabScreen(),
                routes: [
                  // Feature #9: Custom page transition
                  GoRoute(
                    path: 'transitions',
                    name: RouteNames.transitions,
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const TransitionsScreen(),
                      // Slide-from-bottom transition
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            final tween = Tween(
                              begin: const Offset(0.0, 1.0),
                              end: Offset.zero,
                            ).chain(CurveTween(curve: Curves.easeInOut));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                    ),
                  ),

                  // Feature #11: Navigation methods
                  GoRoute(
                    path: 'navigation-methods',
                    name: RouteNames.navigationMethods,
                    builder: (context, state) =>
                        const NavigationMethodsScreen(),
                    routes: [
                      GoRoute(
                        path: 'destination',
                        name: RouteNames.navDestination,
                        builder: (context, state) => NavDestinationScreen(
                          method: state.extra as String?,
                        ),
                      ),
                    ],
                  ),

                  // Feature #12: Pop with result
                  GoRoute(
                    path: 'pop-result',
                    name: RouteNames.popResult,
                    builder: (context, state) => const PopResultScreen(),
                    routes: [
                      GoRoute(
                        path: 'picker',
                        name: RouteNames.popResultPicker,
                        builder: (context, state) =>
                            const PopColorPickerScreen(),
                      ),
                    ],
                  ),

                  // Feature #13: Named navigation
                  GoRoute(
                    path: 'named-nav',
                    name: RouteNames.namedNav,
                    builder: (context, state) => const NamedNavScreen(),
                  ),

                  // Feature #15: GoRouterState inspector
                  GoRoute(
                    path: 'router-state',
                    name: RouteNames.routerState,
                    builder: (context, state) => const RouterStateScreen(),
                  ),

                  // Feature #17: ShellRoute (simple)
                  // A plain ShellRoute shares one Navigator for all children.
                  // Unlike StatefulShellRoute it does NOT preserve child state.
                  ShellRoute(
                    builder: (context, state, child) =>
                        ShellDemoScreen(child: child),
                    routes: [
                      GoRoute(
                        path: 'shell-demo/child-a',
                        name: RouteNames.shellChildA,
                        builder: (context, state) =>
                            const ShellChildScreen(label: 'Child A'),
                      ),
                      GoRoute(
                        path: 'shell-demo/child-b',
                        name: RouteNames.shellChildB,
                        builder: (context, state) =>
                            const ShellChildScreen(label: 'Child B'),
                      ),
                    ],
                  ),

                  // Feature #16: canPop() & GoRouter.of()
                  GoRoute(
                    path: 'can-pop',
                    name: RouteNames.canPop,
                    builder: (context, state) => const CanPopScreen(),
                  ),

                  // Features #14 & #18: Observer log
                  GoRoute(
                    path: 'observer',
                    name: RouteNames.observer,
                    builder: (context, state) => const ObserverScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
