import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final supabaseUrl = "https://jpfgzbjinpowomixcexh.supabase.co";
  final supabaseAnonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpwZmd6YmppbnBvd29taXhjZXhoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjEwNzc2MDUsImV4cCI6MjA3NjY1MzYwNX0.cT3b4EyBytkpPr9MeE6CmhNGlYCqQRHHYWeBqzY4IGo";

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Supabase Auth Demo"
      home: AuthGate(),
    );
  }
}
