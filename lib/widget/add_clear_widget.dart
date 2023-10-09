import 'package:flutter/material.dart';

class AddClearWidget extends StatelessWidget {
  const AddClearWidget(
      {super.key,
      required this.onPressed,
      required this.backgroundColor,
      required this.labelText});

  final void Function() onPressed;
  final String labelText;
  final MaterialStateProperty<Color> backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: backgroundColor,
      ),
      child: Text(
        labelText,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
