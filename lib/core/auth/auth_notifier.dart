import 'package:flutter/foundation.dart';

/// Manages authentication state for the GoRouter demo app.
/// Extends [ChangeNotifier] so it can be used as [GoRouter.refreshListenable].
class AuthNotifier extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _username = 'Guest';
  bool _allowProfileEdit = false;

  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;

  /// Controls route-level redirect demo on /profile/edit.
  bool get allowProfileEdit => _allowProfileEdit;

  void login(String username) {
    _isLoggedIn = true;
    _username = username.isEmpty ? 'User' : username;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _username = 'Guest';
    _allowProfileEdit = false;
    notifyListeners();
  }

  void toggleProfileEdit() {
    _allowProfileEdit = !_allowProfileEdit;
    notifyListeners();
  }
}
