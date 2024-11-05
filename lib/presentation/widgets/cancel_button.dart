import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surface,
        visualDensity: VisualDensity.standard,
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
      ),
      onPressed: () {
        context.pop();
      },
      child: Text(
        'Cancel',
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }
}
