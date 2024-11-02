import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pm_prototype/presentation/employee/widgets/employee_table.dart';
import 'package:pm_prototype/presentation/widgets/add_button.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Employee',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: defaultPadding),
          Align(
            alignment: Alignment.centerRight,
            child: AddButton(
              title: 'Add Employee',
              onPressed: () {
                context.go('/employee/form');
              },
            ),
          ),
          Expanded(child: EmployeeTable())
        ],
      ),
    );
  }
}
