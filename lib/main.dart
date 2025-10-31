import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/auth_gate.dart';
import 'widgets/loading.dart';

// Variáveis de ambiente Supabase - MUITO IMPORTANTE
// Você DEVE substituir estes valores pelos do seu projeto Supabase!
const String supabaseUrl = "https://jpfgzbjinpowomixcexh.supabase.co";
const String supabaseAnonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpwZmd6YmppbnBvd29tbXhjZXhoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjEwNzc2MDUsImV4cCI6MjA3NjY1MzYwNX0.cT3b4EyBytkpPr9MeE6CmhNGlYCqQRHHYWeBqzY4IGo";


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl, 
    anonKey: supabaseAnonKey,
  );
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Supabase Auth Demo",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}
