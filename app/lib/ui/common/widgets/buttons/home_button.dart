import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red[400],
        ),
        constraints: const BoxConstraints.tightFor(width: 40.0, height: 40.0),
        child: Material(
          // <-- Add this
          color:
              Colors
                  .transparent, // <-- Add this to maintain the original design
          child: IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () => context.go('/'),
          ),
        ),
      ),
    );
  }
}
