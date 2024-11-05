import 'package:core/common/enums.dart';
import 'package:core/utils/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pm_prototype/cubit/employee/employee_cubit.dart';
import 'package:pm_prototype/cubit/employee/employee_state.dart';
import 'package:pm_prototype/cubit/role/role_cubit.dart';
import 'package:pm_prototype/cubit/role/role_state.dart';
import 'package:pm_prototype/presentation/widgets/cancel_button.dart';
import 'package:pm_prototype/presentation/widgets/header_widget.dart';
import 'package:pm_prototype/presentation/widgets/pm_dropdown.dart';
import 'package:pm_prototype/presentation/widgets/pm_textfield.dart';
import 'package:pm_prototype/presentation/widgets/popup_helper.dart';
import 'package:pm_prototype/presentation/widgets/submit_button.dart';
import 'package:core/core.dart';

class EmployeeFormScreen extends StatefulWidget {
  final bool isEdit;
  final Employee? employee;
  const EmployeeFormScreen({super.key, this.isEdit = false, this.employee});

  @override
  State<EmployeeFormScreen> createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  Gender? gender;
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
    if (widget.isEdit && widget.employee != null) {
      if (mounted) {
        final roles = context.read<RoleCubit>().state.roles;
        nameController.text = widget.employee!.name;
        emailController.text = widget.employee!.email;
        gender = widget.employee!.gender;
        role = roles.firstWhere(
          (element) => element == widget.employee!.role,
        );
      }
    }
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
              nameController.clear();
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
              nameController.clear();
              PopupHelper.showGeneralPopup(context,
                  title: 'Success',
                  desc: 'Data karyawan berhasil diubah',
                  type: PopupType.success, onClose: () {
                context.pop();
              });
            }
          },
        ),
      ],
      child: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, state) {
          return Column(
            children: [
              if (state.status == EmployeeStatus.loading &&
                  (state.operation == EmployeeOperation.add ||
                      state.operation == EmployeeOperation.update))
                LinearProgressIndicator(
                  minHeight: 8,
                  color: Colors.deepPurpleAccent,
                  backgroundColor: Colors.deepPurple,
                ),
              HeaderWidget(
                title: 'Karyawan',
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
                                label: 'Email',
                                hint: 'ex: aaa@example.com',
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email wajib diisi';
                                  }
                                  if (!FormValidation.emailValid(value)) {
                                    return 'Email tidak valid';
                                  }
                                  return null;
                                },
                                controller: emailController),
                            verticalSpacing(),
                            PMDropdown(
                              label: 'Jenis Kelamin',
                              items: <Gender>[Gender.male, Gender.female]
                                  .map((Gender value) {
                                return DropdownMenuItem<Gender>(
                                  value: value,
                                  child: Text(value.name),
                                );
                              }).toList(),
                              value: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = Gender.values.firstWhere(
                                      (element) => element == value);
                                });
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
                                      if (gender == null || role == null) {
                                        PopupHelper.showGeneralPopup(context,
                                            title: 'Error',
                                            desc:
                                                'Harap isi semua data terlebih dahulu',
                                            type: PopupType.failed);
                                      } else {
                                        final employee = Employee(
                                            id: '',
                                            name: nameController.text,
                                            email: emailController.text,
                                            gender: gender!,
                                            role: role!);
                                        if (widget.isEdit) {
                                          context
                                              .read<EmployeeCubit>()
                                              .updateEmployee(
                                                  widget.employee!.id,
                                                  employee.copyWith(
                                                      id: widget.employee!.id));
                                        } else {
                                          context
                                              .read<EmployeeCubit>()
                                              .addEmployee(employee);
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
            ],
          );
        },
      ),
    );
  }
}
