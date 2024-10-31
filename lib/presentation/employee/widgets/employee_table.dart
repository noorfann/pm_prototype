import 'package:core/domain/entities/employee.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class EmployeeTable extends StatelessWidget {
  const EmployeeTable({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Employee> employees = List.generate(
      100,
      (index) => Employee(
        id: 1,
        name: 'John Doe',
        email: 't5b9a@example.com',
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DataTable2(
          columnSpacing: 0,
          horizontalMargin: 0,
          minWidth: 600,
          headingTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 16),
          dataTextStyle:
              TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          columns: [
            DataColumn(
              label: Container(
                color: Theme.of(context).colorScheme.primary,
                child: Center(
                    child: Text('ID', style: TextStyle(color: Colors.white))),
              ),
            ),
            DataColumn(
              label: Container(
                color: Theme.of(context).colorScheme.primary,
                child: Center(
                    child: Text('Name', style: TextStyle(color: Colors.white))),
              ),
            ),
            DataColumn(
              label: Container(
                color: Theme.of(context).colorScheme.primary,
                child: Center(
                    child: Text('Role', style: TextStyle(color: Colors.white))),
              ),
            ),
            DataColumn(
              label: Container(
                color: Theme.of(context).colorScheme.primary,
                child: Center(
                    child:
                        Text('Action', style: TextStyle(color: Colors.white))),
              ),
            ),
          ],
          rows: employees
              .map((employee) => DataRow(cells: [
                    DataCell(Center(child: Text(employee.id.toString()))),
                    DataCell(Center(child: Text(employee.name))),
                    DataCell(Center(child: Text(employee.email))),
                    DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ]))
              .toList()),
    );
  }
}
