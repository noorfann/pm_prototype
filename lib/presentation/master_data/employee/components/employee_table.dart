import 'package:core/domain/entities/employee.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pm_prototype/cubit/employee/employee_cubit.dart';
import 'package:pm_prototype/cubit/employee/employee_state.dart';
import 'package:pm_prototype/presentation/widgets/popup_helper.dart';
import 'package:pm_prototype/routes/routes.dart';

class EmployeeTable extends StatelessWidget {
  const EmployeeTable({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<EmployeeCubit>().getEmployees();
    return BlocListener<EmployeeCubit, EmployeeState>(
      listener: (context, state) {
        if (state.status == EmployeeStatus.failure &&
            state.operation == EmployeeOperation.delete) {
          PopupHelper.showGeneralPopup(context,
              title: 'Error',
              desc: 'Gagal menghapus data',
              type: PopupType.failed);
        }
        if (state.status == EmployeeStatus.success &&
            state.operation == EmployeeOperation.delete) {
          PopupHelper.showGeneralPopup(context,
              title: 'Success',
              desc: 'Karyawan berhasil dihapus',
              type: PopupType.success);
        }
      },
      child:
          BlocBuilder<EmployeeCubit, EmployeeState>(builder: (context, state) {
        if (state.status == EmployeeStatus.loading &&
            state.operation == EmployeeOperation.fetch) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.employees.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const Text('Tidak ada data karyawan')],
            ),
          );
        } else if (state.employees.isNotEmpty) {
          final List<Employee> employees = state.employees;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: DataTable2(
                columnSpacing: 0,
                horizontalMargin: 0,
                minWidth: 600,
                border: TableBorder.all(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
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
                          child: Text('ID',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      color: Theme.of(context).colorScheme.primary,
                      child: Center(
                          child: Text('Nama',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      color: Theme.of(context).colorScheme.primary,
                      child: Center(
                          child: Text('Email',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      color: Theme.of(context).colorScheme.primary,
                      child: Center(
                          child: Text('Jenis Kelamin',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      color: Theme.of(context).colorScheme.primary,
                      child: Center(
                          child: Text('Role',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      color: Theme.of(context).colorScheme.primary,
                      child: Center(
                          child: Text('Aksi',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                ],
                rows: employees
                    .map((employee) => DataRow(cells: [
                          DataCell(Center(child: Text(employee.id.toString()))),
                          DataCell(Center(child: Text(employee.name))),
                          DataCell(Center(child: Text(employee.email))),
                          DataCell(Center(child: Text(employee.gender.name))),
                          DataCell(Center(child: Text(employee.role.name))),
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // extra params [isEdit, Employee]
                                    context.go(employeeFormScreen,
                                        extra: [true, employee]);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    PopupHelper.showConfirmationPopup(context,
                                        title: 'Hapus Karyawan',
                                        desc:
                                            'Apakah Anda yakin ingin menghapus karyawan ini?',
                                        onConfirm: () {
                                      context
                                          .read<EmployeeCubit>()
                                          .deleteEmployee(employee.id);
                                    });
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        ]))
                    .toList()),
          );
        } else {
          return const Center(child: Text('Gagal mengambil data karyawan'));
        }
      }),
    );
  }
}
