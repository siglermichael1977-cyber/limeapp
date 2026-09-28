import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:lime_app/screens/auth_screen.dart';

class AuthGate extends StatelessWidget {
  final Widget child;
  const AuthGate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = Supabase.instance.client.auth.currentSession;
        if (session == null) {
          return const AuthScreen();
        }
        return child;
      },
    );
  }
}
