import 'package:core/core.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pm_prototype/cubit/assessment/assessment_cubit.dart';
import 'package:pm_prototype/cubit/assessment/assessment_state.dart';
import 'package:pm_prototype/presentation/profile_matching/assessment/components/assesment_detail_dialog.dart';
import 'package:pm_prototype/presentation/widgets/popup_helper.dart';
import 'package:pm_prototype/routes/routes.dart';

class AssesmentTable extends StatelessWidget {
  const AssesmentTable({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AssessmentCubit>().getAssessments();
    Assessment? selectedAssesment;
    return BlocListener<AssessmentCubit, AssessmentState>(
      listener: (context, state) {
        if (state.status == AssessmentStatus.failure &&
            state.operation == AssessmentOperation.delete) {
          PopupHelper.showGeneralPopup(context,
              title: 'Error',
              desc: 'Gagal menghapus data',
              type: PopupType.failed);
        }
        if (state.status == AssessmentStatus.success &&
            state.operation == AssessmentOperation.delete) {
          PopupHelper.showGeneralPopup(context,
              title: 'Success',
              desc: 'Penilaian berhasil dihapus',
              type: PopupType.success);
        }
        if (state.status == AssessmentStatus.success &&
            state.operation == AssessmentOperation.fetchDetail) {
          final assessmentDetail = state.assessmentDetail;
          AssesmentDetailDialog.show(context,
              assessment: selectedAssesment!,
              assessmentDetail: assessmentDetail);
        }
      },
      child: BlocBuilder<AssessmentCubit, AssessmentState>(
          builder: (context, state) {
        if (state.status == AssessmentStatus.loading &&
            state.operation == AssessmentOperation.fetch) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.assessment.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const Text('Tidak ada data penilaian')],
            ),
          );
        } else if (state.assessment.isNotEmpty) {
          final List<Assessment> assessment = state.assessment;

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
                          child: Text('Nama Karyawan',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      color: Theme.of(context).colorScheme.primary,
                      child: Center(
                          child: Text('Role Karyawan',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      color: Theme.of(context).colorScheme.primary,
                      child: Center(
                          child: Text('Assessor',
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
                rows: assessment
                    .map((data) => DataRow(cells: [
                          DataCell(Center(child: Text(data.id.toString()))),
                          DataCell(Center(child: Text(data.employee.name))),
                          DataCell(
                              Center(child: Text(data.employee.role.name))),
                          DataCell(Center(child: Text(data.assessor))),
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    // extra params [isEdit, Assessment]
                                    await context
                                        .read<AssessmentCubit>()
                                        .getAssessmentsDetail(data.id);
                                  },
                                  icon: const Icon(Icons.remove_red_eye),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // extra params [isEdit, Assessment]
                                    selectedAssesment = data;
                                    context.go(assessmentFormScreen,
                                        extra: [true, Assessment]);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    PopupHelper.showConfirmationPopup(context,
                                        title: 'Hapus Penilaian',
                                        desc:
                                            'Anda yakin ingin menghapus Penilaian ini?',
                                        onConfirm: () {
                                      context
                                          .read<AssessmentCubit>()
                                          .deleteAssessment(data.id);
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
