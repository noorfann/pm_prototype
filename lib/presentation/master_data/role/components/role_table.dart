import 'package:core/core.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pm_prototype/cubit/role/role_cubit.dart';
import 'package:pm_prototype/cubit/role/role_state.dart';
import 'package:pm_prototype/presentation/widgets/popup_helper.dart';
import 'package:pm_prototype/routes/routes.dart';

class RoleTable extends StatelessWidget {
  const RoleTable({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RoleCubit>().getRoles();
    return BlocListener<RoleCubit, RoleState>(
      listener: (context, state) {
        if (state.status == RoleStatus.failure &&
            state.operation == RoleOperation.delete) {
          PopupHelper.showGeneralPopup(context,
              title: 'Error',
              desc: 'Gagal menghapus data',
              type: PopupType.failed);
        }
        if (state.status == RoleStatus.success &&
            state.operation == RoleOperation.delete) {
          PopupHelper.showGeneralPopup(context,
              title: 'Success',
              desc: 'Role berhasil dihapus',
              type: PopupType.success);
        }
      },
      child: BlocBuilder<RoleCubit, RoleState>(builder: (context, state) {
        if (state.status == RoleStatus.loading &&
            state.operation == RoleOperation.fetch) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.roles.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const Text('Tidak ada data role')],
            ),
          );
        } else if (state.roles.isNotEmpty) {
          final List<Role> roles = state.roles;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: DataTable2(
                columnSpacing: 0,
                horizontalMargin: 0,
                minWidth: 600,
                border: TableBorder.all(
                  color: Theme.of(context).colorScheme.outline,
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
                          child: Text('Aksi',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                ],
                rows: roles
                    .map((role) => DataRow(cells: [
                          DataCell(Center(child: Text(role.id.toString()))),
                          DataCell(Center(child: Text(role.name))),
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // extra params [isEdit, role]
                                    context.go(roleFormScreen,
                                        extra: [true, role]);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    PopupHelper.showConfirmationPopup(context,
                                        title: 'Hapus Role',
                                        desc:
                                            'Apakah anda yakin ingin menghapus role ini?',
                                        onConfirm: () {
                                      context
                                          .read<RoleCubit>()
                                          .deleteRole(role.id);
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
          return const Center(child: Text('Gagal mengambil data role'));
        }
      }),
    );
  }
}
