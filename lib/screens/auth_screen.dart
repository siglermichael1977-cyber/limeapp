import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:lime_app/constants/colors.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _displayName = TextEditingController();
  final _username = TextEditingController();
  final _island = TextEditingController();
  final _location = TextEditingController();

  bool _signUpMode = false;
  bool _busy = false;
  String? _message;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _displayName.dispose();
    _username.dispose();
    _island.dispose();
    _location.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final client = Supabase.instance.client;
    final email = _email.text.trim();
    final password = _password.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => _message = 'Email and password are required.');
      return;
    }
    if (_signUpMode &&
        (_displayName.text.trim().isEmpty ||
            _username.text.trim().isEmpty ||
            _island.text.trim().isEmpty)) {
      setState(() => _message = 'Name, username and island are required.');
      return;
    }

    setState(() {
      _busy = true;
      _message = null;
    });

    try {
      if (_signUpMode) {
        final res = await client.auth.signUp(email: email, password: password);
        final user = res.user;
        if (user == null) {
          setState(() => _message = 'Check your email to confirm your account.');
          return;
        }
        if (client.auth.currentSession == null) {
          setState(() => _message =
              'Account created. Confirm your email, then sign in.');
          return;
        }
        await client.from('profiles').insert({
          'id': user.id,
          'username': _username.text.trim(),
          'display_name': _displayName.text.trim(),
          'island': _island.text.trim(),
          'current_location': _location.text.trim().isEmpty
              ? 'Home'
              : _location.text.trim(),
        });
      } else {
        await client.auth
            .signInWithPassword(email: email, password: password);
      }
    } catch (e) {
      setState(() => _message = e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Widget _field(TextEditingController c, String label,
      {bool obscure = false, TextInputType? type}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        obscureText: obscure,
        keyboardType: type,
        autocorrect: false,
        enableSuggestions: false,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LimeColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: LimeColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Lime',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'De Whole Caribbean, One Yard',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 28),
                _field(_email, 'Email', type: TextInputType.emailAddress),
                _field(_password, 'Password', obscure: true),
                if (_signUpMode) ...[
                  _field(_displayName, 'Display name'),
                  _field(_username, 'Username'),
                  _field(_island, 'Island of origin'),
                  _field(_location, 'Where you living now (optional)'),
                ],
                if (_message != null) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      _message!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ],
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _busy ? null : _submit,
                    child: _busy
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child:
                                CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(_signUpMode ? 'Create account' : 'Sign in'),
                  ),
                ),
                TextButton(
                  onPressed: _busy
                      ? null
                      : () => setState(() {
                            _signUpMode = !_signUpMode;
                            _message = null;
                          }),
                  child: Text(_signUpMode
                      ? 'Already have an account? Sign in'
                      : 'New here? Create an account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
