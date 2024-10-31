import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;

  const AddButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            visualDensity: VisualDensity.standard),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ],
        ));
  }
}
