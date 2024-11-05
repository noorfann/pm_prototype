import 'package:core/domain/entities/project.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pm_prototype/cubit/project/project_cubit.dart';
import 'package:pm_prototype/cubit/project/project_state.dart';
import 'package:pm_prototype/presentation/widgets/popup_helper.dart';
import 'package:pm_prototype/routes/routes.dart';

class ProjectTable extends StatelessWidget {
  const ProjectTable({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProjectCubit>().getProjects();
    return BlocListener<ProjectCubit, ProjectState>(
      listener: (context, state) {
        if (state.status == ProjectStatus.failure &&
            state.operation == ProjectOperation.delete) {
          PopupHelper.showGeneralPopup(context,
              title: 'Error',
              desc: 'Gagal menghapus data',
              type: PopupType.failed);
        }
        if (state.status == ProjectStatus.success &&
            state.operation == ProjectOperation.delete) {
          PopupHelper.showGeneralPopup(context,
              title: 'Success',
              desc: 'Project berhasil dihapus',
              type: PopupType.success);
        }
      },
      child: BlocBuilder<ProjectCubit, ProjectState>(builder: (context, state) {
        if (state.status == ProjectStatus.loading &&
            state.operation == ProjectOperation.fetch) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.projects.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const Text('Tidak ada data project')],
            ),
          );
        } else if (state.projects.isNotEmpty) {
          final List<Project> projects = state.projects;

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
                          child: Text('Deskripsi',
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
                rows: projects
                    .map((project) => DataRow(cells: [
                          DataCell(Center(child: Text(project.id.toString()))),
                          DataCell(Center(child: Text(project.name))),
                          DataCell(Center(child: Text(project.description))),
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // extra params [isEdit, Project]
                                    context.go(projectsFormScreen,
                                        extra: [true, project]);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    PopupHelper.showConfirmationPopup(context,
                                        title: 'Hapus Project',
                                        desc:
                                            'Apakah Anda yakin ingin menghapus Project ini?',
                                        onConfirm: () {
                                      context
                                          .read<ProjectCubit>()
                                          .deleteProject(project.id);
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
          return const Center(child: Text('Gagal mengambil data Project'));
        }
      }),
    );
  }
}
