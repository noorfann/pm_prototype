import 'package:core/core.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pm_prototype/cubit/criteria/criteria_cubit.dart';
import 'package:pm_prototype/cubit/criteria/criteria_state.dart';
import 'package:pm_prototype/presentation/widgets/popup_helper.dart';
import 'package:pm_prototype/routes/routes.dart';

class CriteriaTable extends StatelessWidget {
  const CriteriaTable({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CriteriaCubit>().getCriterias();
    return BlocListener<CriteriaCubit, CriteriaState>(
      listener: (context, state) {
        if (state.status == CriteriaStatus.failure &&
            state.operation == CriteriaOperation.delete) {
          PopupHelper.showGeneralPopup(context,
              title: 'Error',
              desc: 'Gagal menghapus data',
              type: PopupType.failed);
        }
        if (state.status == CriteriaStatus.success &&
            state.operation == CriteriaOperation.delete) {
          PopupHelper.showGeneralPopup(context,
              title: 'Success',
              desc: 'Kriteria berhasil dihapus',
              type: PopupType.success);
        }
      },
      child:
          BlocBuilder<CriteriaCubit, CriteriaState>(builder: (context, state) {
        if (state.status == CriteriaStatus.loading &&
            state.operation == CriteriaOperation.fetch) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.criterias.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const Text('No Criterias found')],
            ),
          );
        } else if (state.criterias.isNotEmpty) {
          final List<Criteria> criterias = state.criterias;

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
                          child: Text('Tipe Kriteria',
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
                rows: criterias
                    .map((criteria) => DataRow(cells: [
                          DataCell(Center(child: Text(criteria.id.toString()))),
                          DataCell(Center(child: Text(criteria.name))),
                          DataCell(
                              Center(child: Text(criteria.criteriaType.name))),
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // extra params [isEdit, Criteria]
                                    context.go(criteriaFormScreen,
                                        extra: [true, criteria]);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    PopupHelper.showConfirmationPopup(context,
                                        title: 'Hapus Kriteria',
                                        desc:
                                            'Anda yakin ingin menghapus Kriteria ini?',
                                        onConfirm: () {
                                      context
                                          .read<CriteriaCubit>()
                                          .deleteCriteria(criteria.id);
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
          return const Center(child: Text('Gagal mendapatkan data'));
        }
      }),
    );
  }
}
