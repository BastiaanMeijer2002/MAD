import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  final String message;

  const LoadingWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.fourRotatingDots(
            size: 200,
            color: const Color(0xff0f110c),
          ),
          const SizedBox(height: 100),
          Text(
            message,
            style: const TextStyle(
              color: Color(0xff0f110c),
              fontWeight: FontWeight.w800,
              fontSize: 24
            ),
          )
        ],
      ),
      )
    );
  }
}