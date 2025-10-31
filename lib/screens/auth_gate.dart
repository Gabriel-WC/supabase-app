import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/loading.dart';
import 'homepage.dart';
import 'sign_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        }

        if (session != null) {
          return const HomePage();
        }

        return const SignPage();
      },
    );
  }
}
