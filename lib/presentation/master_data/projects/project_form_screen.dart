import 'package:core/common/enums.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pm_prototype/cubit/project/project_cubit.dart';
import 'package:pm_prototype/cubit/project/project_state.dart';
import 'package:pm_prototype/presentation/widgets/cancel_button.dart';
import 'package:pm_prototype/presentation/widgets/header_widget.dart';
import 'package:pm_prototype/presentation/widgets/pm_textfield.dart';
import 'package:pm_prototype/presentation/widgets/popup_helper.dart';
import 'package:pm_prototype/presentation/widgets/submit_button.dart';

class ProjectFormScreen extends StatefulWidget {
  final bool isEdit;
  final Project? project;
  const ProjectFormScreen({super.key, this.isEdit = false, this.project});

  @override
  State<ProjectFormScreen> createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends State<ProjectFormScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    if (widget.isEdit && widget.project != null) {
      nameController.text = widget.project!.name;
      descriptionController.text = widget.project!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProjectCubit, ProjectState>(
          listener: (context, state) {
            if (state.error == ProjectError.addError) {
              PopupHelper.showGeneralPopup(context,
                  title: 'Error',
                  desc: 'Gagal membuat data Project',
                  type: PopupType.failed);
            }
            if (state.status == ProjectStatus.success &&
                state.operation == ProjectOperation.add) {
              nameController.clear();
              PopupHelper.showGeneralPopup(context,
                  title: 'Success',
                  desc: 'Project berhasil dibuat',
                  type: PopupType.success, onClose: () {
                context.pop();
              });
            }

            // update
            if (state.error == ProjectError.updateError) {
              PopupHelper.showGeneralPopup(context,
                  title: 'Error',
                  desc: 'Gagal mengubah data Project',
                  type: PopupType.failed);
            }
            if (state.status == ProjectStatus.success &&
                state.operation == ProjectOperation.update) {
              nameController.clear();
              PopupHelper.showGeneralPopup(context,
                  title: 'Success',
                  desc: 'Data Project berhasil diubah',
                  type: PopupType.success, onClose: () {
                context.pop();
              });
            }
          },
        ),
      ],
      child: BlocBuilder<ProjectCubit, ProjectState>(
        builder: (context, state) {
          return Column(
            children: [
              if (state.status == ProjectStatus.loading &&
                  (state.operation == ProjectOperation.add ||
                      state.operation == ProjectOperation.update))
                LinearProgressIndicator(
                  minHeight: 8,
                  color: Colors.deepPurpleAccent,
                  backgroundColor: Colors.deepPurple,
                ),
              HeaderWidget(
                title: 'Project',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 600,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.only(top: 24),
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PMTextfield(
                              label: 'Nama',
                              hint: 'ex: John Doe',
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama wajib diisi';
                                }
                                return null;
                              },
                            ),
                            verticalSpacing(),
                            PMTextfield(
                                label: 'Deskripsi',
                                hint: 'ex: aaa@example.com',
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Deskripsi wajib diisi';
                                  }
                                  return null;
                                },
                                controller: descriptionController),
                            verticalSpacing(24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CancelButton(),
                                horizontalSpacing(8),
                                SubmitButton(
                                    text: 'Submit',
                                    onPressed: () {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }

                                      final project = Project(
                                          id: '',
                                          name: nameController.text,
                                          description:
                                              descriptionController.text);
                                      if (widget.isEdit) {
                                        context
                                            .read<ProjectCubit>()
                                            .updateProject(
                                                widget.project!.id,
                                                project.copyWith(
                                                    id: widget.project!.id));
                                      } else {
                                        context
                                            .read<ProjectCubit>()
                                            .addProject(project);
                                      }
                                    }),
                              ],
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
