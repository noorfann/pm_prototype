import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const DeleteButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.error,
          visualDensity: VisualDensity.standard,
        ),
        child: Text(text,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)));
  }
}
