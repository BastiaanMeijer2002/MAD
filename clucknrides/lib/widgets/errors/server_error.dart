import 'package:flutter/material.dart';

class ServerError extends StatelessWidget {
  const ServerError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        title: const Text('Error'),
        content: const Text("Server Error"),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Close the dialog with false value
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

}