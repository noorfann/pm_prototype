import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:pm_prototype/presentation/criteria/widgets/criteria_table.dart';
import 'package:pm_prototype/presentation/widgets/add_button.dart';

class CriteriaScreen extends StatelessWidget {
  const CriteriaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Criteria',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: defaultPadding),
          Align(
            alignment: Alignment.centerRight,
            child: AddButton(
              title: 'Add Criteria',
            ),
          ),
          Expanded(child: CriteriaTable())
        ],
      ),
    );
  }
}
