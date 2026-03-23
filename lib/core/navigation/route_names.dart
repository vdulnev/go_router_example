/// Centralised route name constants used with [GoRoute.name] and
/// [BuildContext.goNamed] / [BuildContext.pushNamed] / [BuildContext.replaceNamed].
///
/// Using constants prevents typos and enables rename-refactoring.
abstract final class RouteNames {
  // Auth
  static const String login = 'login';

  // Home branch
  static const String home = 'home';
  static const String homeSearch = 'home-search';
  static const String article = 'article';
  static const String articleComments = 'article-comments';

  // Catalog branch
  static const String catalog = 'catalog';
  static const String catalogItem = 'catalog-item';
  static const String catalogReviews = 'catalog-reviews';

  // Profile branch
  static const String profile = 'profile';
  static const String profileEdit = 'profile-edit';

  // Lab branch
  static const String lab = 'lab';
  static const String transitions = 'transitions';
  static const String navigationMethods = 'navigation-methods';
  static const String navDestination = 'nav-destination';
  static const String popResult = 'pop-result';
  static const String popResultPicker = 'pop-result-picker';
  static const String namedNav = 'named-nav';
  static const String routerState = 'router-state';
  static const String shellChildA = 'shell-child-a';
  static const String shellChildB = 'shell-child-b';
  static const String canPop = 'can-pop';
  static const String observer = 'observer';
}
