import 'package:core/utils/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pm_prototype/cubit/assessment/assessment_cubit.dart';
import 'package:pm_prototype/cubit/assessment/assessment_state.dart';
import 'package:pm_prototype/cubit/criteria/criteria_cubit.dart';
import 'package:pm_prototype/cubit/criteria/criteria_state.dart';
import 'package:pm_prototype/cubit/employee/employee_cubit.dart';
import 'package:pm_prototype/cubit/employee/employee_state.dart';
import 'package:pm_prototype/presentation/widgets/cancel_button.dart';
import 'package:pm_prototype/presentation/widgets/header_widget.dart';
import 'package:pm_prototype/presentation/widgets/pm_dropdown.dart';
import 'package:pm_prototype/presentation/widgets/pm_textfield.dart';
import 'package:pm_prototype/presentation/widgets/popup_helper.dart';
import 'package:pm_prototype/presentation/widgets/submit_button.dart';
import 'package:core/core.dart';
import 'package:collection/collection.dart';

class AssessmentFormScreen extends StatefulWidget {
  final bool isEdit;
  final Employee? employee;
  final Assessment? assessment;
  const AssessmentFormScreen(
      {super.key, this.isEdit = false, this.employee, this.assessment});

  @override
  State<AssessmentFormScreen> createState() => _AssessmentFormScreenState();
}

class _AssessmentFormScreenState extends State<AssessmentFormScreen> {
  final List<Weight> weights = [
    Weight('Sangat kurang', 0),
    Weight('Kurang', 1),
    Weight('Cukup', 2),
    Weight('Baik', 3),
    Weight('Sangat Baik', 4),
  ];
  List<CriteriaDetailForm> criteriaDetailForm = [];
  TextEditingController assessorController = TextEditingController();
  Employee? selectedEmployee;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    if (widget.isEdit && widget.assessment != null) {
      if (mounted) {
        selectedEmployee = widget.assessment!.employee;
        assessorController.text = widget.assessment!.assessor;
      }
    }

    if (context.read<EmployeeCubit>().state.employees.isEmpty) {
      await context.read<EmployeeCubit>().getEmployees();
    }

    await context.read<CriteriaCubit>().getCriterias();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AssessmentCubit, AssessmentState>(
          listener: (context, state) {
            if (state.error == AssessmentError.addError) {
              PopupHelper.showGeneralPopup(context,
                  title: 'Error',
                  desc: 'Gagal membuat data Penilaian',
                  type: PopupType.failed);
            }
            if (state.status == AssessmentStatus.success &&
                state.operation == AssessmentOperation.add) {
              selectedEmployee = null;
              PopupHelper.showGeneralPopup(context,
                  title: 'Success',
                  desc: 'Penilaian berhasil dibuat',
                  type: PopupType.success, onClose: () {
                context.pop();
              });
            }

            // update
            if (state.error == AssessmentError.updateError) {
              PopupHelper.showGeneralPopup(context,
                  title: 'Error',
                  desc: 'Gagal mengubah data Penilaian',
                  type: PopupType.failed);
            }
            if (state.status == AssessmentStatus.success &&
                state.operation == AssessmentOperation.update) {
              selectedEmployee = null;
              PopupHelper.showGeneralPopup(context,
                  title: 'Success',
                  desc: 'Data Penilaian berhasil diubah',
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
      child: BlocBuilder<AssessmentCubit, AssessmentState>(
        builder: (context, state) {
          return Column(
            children: [
              if (state.status == AssessmentStatus.loading &&
                  (state.operation == AssessmentOperation.add ||
                      state.operation == AssessmentOperation.update))
                LinearProgressIndicator(
                  minHeight: 8,
                  color: Colors.deepPurpleAccent,
                  backgroundColor: Colors.deepPurple,
                ),
              HeaderWidget(
                title: 'Penilaian',
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 600,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.only(top: 24, bottom: 50),
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                BlocBuilder<EmployeeCubit, EmployeeState>(
                                  builder: (context, state) {
                                    if (state.status ==
                                        EmployeeStatus.loading) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state.status ==
                                        EmployeeStatus.success) {
                                      final employees = state.employees;
                                      // _setSelectedEmployee(employees);
                                      return PMDropdown(
                                        label: 'Karyawan',
                                        items: employees.map((Employee value) {
                                          return DropdownMenuItem<Employee>(
                                            value: value,
                                            child: Text(value.name),
                                          );
                                        }).toList(),
                                        value: selectedEmployee,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedEmployee = employees
                                                .firstWhere((element) =>
                                                    element == value);
                                          });
                                        },
                                      );
                                    } else {
                                      return Text(
                                          "Gagal mendapatkan data karyawan");
                                    }
                                  },
                                ),
                                BlocBuilder<CriteriaCubit, CriteriaState>(
                                  builder: (context, state) {
                                    logger.logInfo(
                                        "criteria state status ${state.status}");

                                    if (state.status ==
                                        CriteriaStatus.loading) {
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
                                                                  FontWeight
                                                                      .bold)),
                                                ),
                                                horizontalSpacing(),
                                                Expanded(
                                                  flex: 2,
                                                  child: PMDropdown(
                                                    label: 'Nilai',
                                                    withLabel: false,
                                                    items: weights
                                                        .map((Weight value) {
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
                                PMTextfield(
                                    label: 'Assessor',
                                    hint: 'ex: Lead Mobile Dev',
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Assessor wajib diisi';
                                      }
                                      return null;
                                    },
                                    controller: assessorController),
                                verticalSpacing(24),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CancelButton(),
                                    horizontalSpacing(8),
                                    SubmitButton(
                                        text: 'Submit',
                                        onPressed: () {
                                          if (!_formKey.currentState!
                                              .validate()) {
                                            return;
                                          }
                                          if (selectedEmployee == null ||
                                              !_isValidDetailForm()) {
                                            PopupHelper.showGeneralPopup(
                                                context,
                                                title: 'Error',
                                                desc:
                                                    'Harap isi semua data terlebih dahulu',
                                                type: PopupType.failed);
                                          } else {
                                            // create data to submit
                                            final assessment = Assessment(
                                              id: '',
                                              assessor: assessorController.text,
                                              employee: selectedEmployee!,
                                              details: [],
                                            );
                                            List<AssessmentDetail>
                                                assessmentDetail = [];
                                            for (var form
                                                in criteriaDetailForm) {
                                              assessmentDetail
                                                  .add(AssessmentDetail(
                                                id: '',
                                                assesmentId: assessment.id,
                                                criteria: form.criteria,
                                                score: form.weight!.value,
                                              ));
                                            }

                                            // add / update data
                                            if (widget.isEdit) {
                                              context
                                                  .read<AssessmentCubit>()
                                                  .updateAssessment(
                                                      widget.employee!.id,
                                                      assessment.copyWith(
                                                          id: widget
                                                              .employee!.id));
                                            } else {
                                              context
                                                  .read<AssessmentCubit>()
                                                  .addAssessment(assessment,
                                                      assessmentDetail);
                                            }
                                          }
                                        }),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _setSelectedEmployee(List<Employee> employees) {
    if (widget.isEdit && widget.employee != null) {
      selectedEmployee = employees.firstWhere(
        (element) => element == widget.employee,
      );
      logger.logInfo("selected employee ${selectedEmployee.toString()}");
    }
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

  bool _isValidDetailForm() {
    final checkEmptyWeight = criteriaDetailForm.firstWhereOrNull(
      (element) => element.weight == null,
    );
    if (checkEmptyWeight != null) {
      return false;
    } else {
      return true;
    }
  }
}
