/// Simple data class passed via [GoRouterState.extra] to demonstrate
/// navigation extras (Feature 8).
class CatalogItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String emoji;

  const CatalogItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.emoji,
  });

  static const List<CatalogItem> samples = [
    CatalogItem(
      id: '1',
      name: 'Flutter Framework',
      description:
          'Build natively compiled apps for mobile, web, and desktop '
          'from a single codebase.',
      price: 0.0,
      emoji: '🐦',
    ),
    CatalogItem(
      id: '2',
      name: 'GoRouter Package',
      description:
          'Declarative routing for Flutter with deep linking, '
          'named routes, and URL synchronization.',
      price: 0.0,
      emoji: '🗺️',
    ),
    CatalogItem(
      id: '3',
      name: 'Material You',
      description:
          "Google's adaptive design system for beautiful, "
          'personalized Flutter UIs.',
      price: 0.0,
      emoji: '🎨',
    ),
    CatalogItem(
      id: '4',
      name: 'Dart Language',
      description:
          'Client-optimized language for fast apps on any platform. '
          'Null-safe, sound type system.',
      price: 0.0,
      emoji: '🎯',
    ),
    CatalogItem(
      id: '5',
      name: 'Firebase',
      description:
          'Backend-as-a-service: authentication, Firestore, '
          'Cloud Storage, hosting and more.',
      price: 0.0,
      emoji: '🔥',
    ),
    CatalogItem(
      id: '6',
      name: 'Riverpod',
      description:
          'Reactive caching and data-binding framework. '
          'A complete rewrite of Provider.',
      price: 0.0,
      emoji: '🏔️',
    ),
  ];
}
