import 'package:flutter/material.dart';

class InvalidCredentialsError extends StatelessWidget {
  const InvalidCredentialsError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        title: const Text('Error'),
        content: const Text("Invalid credentials"),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}