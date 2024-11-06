import 'package:flutter/material.dart';

class PMDropdown<T> extends StatelessWidget {
  final String label;
  final List<DropdownMenuItem<T>> items;
  final Function(T?)? onChanged;
  final T? value;
  final bool withLabel;
  const PMDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    required this.value,
    this.withLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (withLabel)
              ? Text(label,
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface))
              : const SizedBox(),
          DropdownButton<T>(
            isExpanded: true,
            borderRadius: BorderRadius.circular(8),
            hint: Text("Pilih $label"),
            value: value,
            items: items,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
