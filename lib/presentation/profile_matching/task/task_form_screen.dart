import 'package:core/utils/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pm_prototype/cubit/criteria/criteria_cubit.dart';
import 'package:pm_prototype/cubit/criteria/criteria_state.dart';
import 'package:pm_prototype/cubit/employee/employee_cubit.dart';
import 'package:pm_prototype/cubit/employee/employee_state.dart';
import 'package:pm_prototype/cubit/profile_matching/profile_matching_cubit.dart';
import 'package:pm_prototype/cubit/role/role_cubit.dart';
import 'package:pm_prototype/cubit/role/role_state.dart';
import 'package:pm_prototype/presentation/widgets/header_widget.dart';
import 'package:pm_prototype/presentation/widgets/pm_dropdown.dart';
import 'package:pm_prototype/presentation/widgets/pm_textfield.dart';
import 'package:pm_prototype/presentation/widgets/popup_helper.dart';
import 'package:pm_prototype/presentation/widgets/submit_button.dart';
import 'package:core/core.dart';
import 'package:pm_prototype/routes/routes.dart';

import 'profile_matching_result_screen.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({
    super.key,
  });

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final List<Weight> weights = [
    Weight('Sangat kurang', 0),
    Weight('Kurang', 1),
    Weight('Cukup', 2),
    Weight('Baik', 3),
    Weight('Sangat Baik', 4),
  ];
  List<CriteriaDetailForm> criteriaDetailForm = [];
  final TextEditingController taskController = TextEditingController();
  Role? role;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    if (context.read<RoleCubit>().state.roles.isEmpty) {
      await context.read<RoleCubit>().getRoles();
    }
    await context.read<CriteriaCubit>().getCriterias();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<EmployeeCubit, EmployeeState>(
          listener: (context, state) {
            if (state.error == EmployeeError.addError) {
              PopupHelper.showGeneralPopup(context,
                  title: 'Error',
                  desc: 'Gagal membuat data karyawan',
                  type: PopupType.failed);
            }
            if (state.status == EmployeeStatus.success &&
                state.operation == EmployeeOperation.add) {
              taskController.clear();
              PopupHelper.showGeneralPopup(context,
                  title: 'Success',
                  desc: 'Karyawan berhasil dibuat',
                  type: PopupType.success, onClose: () {
                context.pop();
              });
            }

            // update
            if (state.error == EmployeeError.updateError) {
              PopupHelper.showGeneralPopup(context,
                  title: 'Error',
                  desc: 'Gagal mengubah data karyawan',
                  type: PopupType.failed);
            }
            if (state.status == EmployeeStatus.success &&
                state.operation == EmployeeOperation.update) {
              taskController.clear();
              PopupHelper.showGeneralPopup(context,
                  title: 'Success',
                  desc: 'Data karyawan berhasil diubah',
                  type: PopupType.success, onClose: () {
                context.pop();
              });
            }
          },
        ),
        BlocListener<CriteriaCubit, CriteriaState>(
          listener: (context, state) {
            if (state.status == CriteriaStatus.success) {
              _setCriteriaDetailForm(state.criterias);
            }
          },
        )
      ],
      child: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: HeaderWidget(
                  title: 'Pembagian Tugas',
                  withCloseButton: false,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
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
                              controller: taskController,
                              label: 'Judul Tugas',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tugas tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                            verticalSpacing(),
                            BlocBuilder<RoleCubit, RoleState>(
                              builder: (context, state) {
                                if (state.status == RoleStatus.loading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state.status == RoleStatus.success) {
                                  final roles = state.roles;
                                  logger.logInfo(
                                      "roles data ${roles.toString()}");
                                  return PMDropdown(
                                    label: 'Role',
                                    items: roles.map((Role value) {
                                      return DropdownMenuItem<Role>(
                                        value: value,
                                        child: Text(value.name),
                                      );
                                    }).toList(),
                                    value: role,
                                    onChanged: (value) {
                                      setState(() {
                                        role = roles.firstWhere(
                                            (element) => element == value);
                                      });
                                    },
                                  );
                                } else {
                                  return Text("Gagal mendapatkan data role");
                                }
                              },
                            ),
                            Divider(),
                            verticalSpacing(),
                            Text(
                              "Target Penilaian",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            verticalSpacing(),
                            BlocBuilder<CriteriaCubit, CriteriaState>(
                              builder: (context, state) {
                                logger.logInfo(
                                    "criteria state status ${state.status}");

                                if (state.status == CriteriaStatus.loading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state.status ==
                                        CriteriaStatus.success &&
                                    state.operation ==
                                        CriteriaOperation.fetch) {
                                  final criterias = state.criterias;
                                  logger.logInfo(
                                      "criterias length ${criterias.length}");
                                  return Column(
                                    children: [
                                      for (int i = 0;
                                          i < criterias.length;
                                          i++) ...[
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(criterias[i].name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                            ),
                                            horizontalSpacing(),
                                            Expanded(
                                              flex: 2,
                                              child: PMDropdown(
                                                label: 'Nilai',
                                                withLabel: false,
                                                items:
                                                    weights.map((Weight value) {
                                                  return DropdownMenuItem<
                                                      Weight>(
                                                    value: value,
                                                    child: Text(
                                                        "${value.name} - ${value.value}"),
                                                  );
                                                }).toList(),
                                                value: criteriaDetailForm[i]
                                                    .weight,
                                                onChanged: (value) {
                                                  setState(() {
                                                    criteriaDetailForm[i]
                                                            .weight =
                                                        weights.firstWhere(
                                                            (element) =>
                                                                element ==
                                                                value);
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      ]
                                    ],
                                  );
                                } else {
                                  return Text(
                                      "Gagal mendapatkan data kriteria");
                                }
                              },
                            ),
                            verticalSpacing(),
                            verticalSpacing(24),
                            SizedBox(
                              width: double.infinity,
                              child: SubmitButton(
                                  text: 'Proses',
                                  onPressed: () {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }
                                    if (role == null) {
                                      PopupHelper.showGeneralPopup(context,
                                          title: 'Error',
                                          desc:
                                              'Harap isi semua data terlebih dahulu',
                                          type: PopupType.failed);
                                    } else {
                                      context
                                          .read<ProfileMatchingCubit>()
                                          .calculateProfileMatching(
                                            taskTitle: taskController.text,
                                            roleId: role!.id,
                                            targetValues: criteriaDetailForm,
                                            criteria: context
                                                .read<CriteriaCubit>()
                                                .state
                                                .criterias,
                                          );
                                      context.go(profileMatchingScreen);
                                    }
                                  }),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _setCriteriaDetailForm(List<Criteria> criterias) {
    for (var i = 0; i < criterias.length; i++) {
      criteriaDetailForm.add(
        CriteriaDetailForm(
          criterias[i],
          null,
        ),
      );
    }
  }
}
