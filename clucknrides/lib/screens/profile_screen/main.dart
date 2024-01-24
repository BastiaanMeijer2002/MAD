import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileWidget extends StatefulWidget {
  final FlutterSecureStorage storage;

  const ProfileWidget({super.key, required this.storage});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();

}

class _ProfileWidgetState extends State<ProfileWidget>{

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0f110c),
        title: const Text(
          "Cluck'N'Rides",
          style: TextStyle(
            color: Color(0xfffcf7f7),
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Expanded(child: Text("test")),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.04),
              child: ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(screenWidth * 0.84, screenHeight * 0.05)),
                  backgroundColor: const MaterialStatePropertyAll(Colors.red),
                ),
                onPressed: () async{
                  await widget.storage.delete(key: "jwt");
                  if (context.mounted) Navigator.of(context).pushReplacementNamed('start');
                },
                child: const Text(
                  "Sign out",
                  style: TextStyle(
                    fontFamily: "inter",
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                )),
            ),
          )
        ],
      ),
    );
  }
}