import 'package:flutter/material.dart';

class PMTextfield extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;

  const PMTextfield({super.key, this.label, this.hint, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label ?? ''),
        hintText: hint ?? '',
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSurface, width: 2.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSurface, width: 2.0),
        ),
      ),
    );
  }
}
