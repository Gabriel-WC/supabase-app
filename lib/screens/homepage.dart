import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _signOut(BuildContext context) async {
    try {
      await Supabase.instance.client.auth.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao fazer logout: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = Supabase.instance.client.auth.currentUser?.id ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem-vindo!'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.security_outlined,
                color: Colors.green,
                size: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                'Autenticação Persistente OK!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Sua sessão foi carregada com sucesso da nuvem do Supabase.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SelectableText(
                  'ID do Usuário (UID):\n$userId',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontFamily: 'monospace', color: Colors.indigo.shade900),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => _signOut(context),
                icon: const Icon(Icons.exit_to_app, color: Colors.white),
                label: const Text('Sair da Conta (Logout)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
