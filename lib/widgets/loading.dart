import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.indigo),
            SizedBox(height: 16),
            Text('Verificando sessão...', style: TextStyle(color: Colors.indigo)),
          ],
        ),
      ),
    );
  }
}
