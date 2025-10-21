import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {

    final supabase = Supabase.instance.client;
    final initialSession = supabase.auth.currentSession;

    return StreamBuilder<AuthState>(
      initialData: initialSession != null,
        ? AuthState(AuthChangeEvent.signedIn, session)
        : AuthState(AuthChangeEvent.signedOut, session)
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot){
        final session = snapshot.data?;session;
        if (session == null) return SignPage();
        return Homepage();
      
      },
    );
  }
}