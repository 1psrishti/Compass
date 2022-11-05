import 'package:flutter/material.dart';

class NeuCircle extends StatelessWidget {
  final child;
  const NeuCircle({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      margin: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.purple[600],
        boxShadow: [
          BoxShadow(
              color: Colors.purple.shade800,
              offset: const Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0),
          BoxShadow(
              color: Colors.purple.shade500,
              offset: const Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.shade500,
            Colors.purple.shade600,
            Colors.purple.shade700,
            Colors.purple.shade800,
          ],
          stops: const [0.1, 0.3, 0.8, 1],
        ),
      ),
      child: child,
    );
  }
}