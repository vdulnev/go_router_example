import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Shell widget for the [StatefulShellRoute.indexedStack] that holds the
/// bottom navigation bar.
///
/// Demonstrates Feature 4: StatefulShellRoute with state preservation.
/// Each tab maintains its own [Navigator] stack; switching tabs does NOT
/// reset their state (contrast with [ShellRoute] in the Lab).
class MainScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({super.key, required this.navigationShell});

  static const _destinations = <NavigationDestination>[
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.grid_view_outlined),
      selectedIcon: Icon(Icons.grid_view),
      label: 'Catalog',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_outline),
      selectedIcon: Icon(Icons.person),
      label: 'Profile',
    ),
    NavigationDestination(
      icon: Icon(Icons.science_outlined),
      selectedIcon: Icon(Icons.science),
      label: 'Lab',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          // Passing initialLocation: true when re-tapping the active tab
          // navigates back to the branch's initial location (pop-to-root).
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: _destinations,
      ),
    );
  }
}
