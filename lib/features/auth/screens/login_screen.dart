import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/auth_notifier.dart';

/// Login screen.
///
/// Demonstrates:
/// - Feature 5: Redirect destination (auth guard sends unauthenticated users here)
/// - Feature 5: Redirect after login using the `from` query parameter
/// - The `from` query param is decoded and used as the post-login destination.
class LoginScreen extends StatefulWidget {
  final AuthNotifier authNotifier;

  /// Encoded URL to navigate to after successful login.
  final String? from;

  const LoginScreen({super.key, required this.authNotifier, this.from});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = TextEditingController(text: 'Alice');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _login() {
    widget.authNotifier.login(_controller.text.trim());
    // After login, GoRouter's refreshListenable fires → redirect re-evaluates
    // and sends us to `from` (if present) or '/'.
    // We can also navigate explicitly as a fallback:
    final destination = widget.from != null
        ? Uri.decodeComponent(widget.from!)
        : '/';
    context.go(destination);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '🔐',
                    style: TextStyle(fontSize: 56),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Sign In',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Required to access protected routes.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (widget.from != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Redirect from: ${Uri.decodeComponent(widget.from!)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _login(),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Password (any)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _login(),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _login,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
