import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({required this.onPressed, required this.icon, Key? key})
      : super(key: key);

  final IconData icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 6.0,
      shape: const CircleBorder(),
      constraints: const BoxConstraints.tightFor(height: 56.0, width: 56.0),
      fillColor: Colors.white.withOpacity(0.2),
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
