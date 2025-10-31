import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  bool _isSigningUp = true;
  bool _isLoading = false;
  String? _errorMessage;

  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> _handleAuth() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (_isSigningUp) {
        await _supabase.auth.signUp(
          email: _emailController.text,
          password: _passwordController.text,
        );
        _showSnackbar('Verifique seu e-mail para confirmar o cadastro!');

      } else {
        await _supabase.auth.signInWithPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      }
    } on AuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Ocorreu um erro inesperado: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSigningUp ? 'Crie sua conta' : 'Acesse sua conta'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isSigningUp ? 'Cadastro' : 'Login',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value!.isEmpty || !value.contains('@') ? 'Insira um e-mail válido' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  obscureText: true,
                  validator: (value) => value!.length < 6 ? 'A senha deve ter no mínimo 6 caracteres' : null,
                ),
                const SizedBox(height: 32),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleAuth,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading 
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
                      : Text(_isSigningUp ? 'REGISTRAR' : 'ENTRAR'),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isSigningUp = !_isSigningUp;
                      _errorMessage = null;
                    });
                  },
                  child: Text(
                    _isSigningUp
                        ? 'Já tem uma conta? Clique para Logar'
                        : 'Não tem uma conta? Clique para Registrar',
                    style: TextStyle(color: Colors.indigo.shade400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
