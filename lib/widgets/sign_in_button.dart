import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final VoidCallback? onPressed;

  const SignInButton(
      {super.key,
      required this.color,
      required this.onPressed,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: color.withOpacity(0.8),
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        child: child);
  }
}
