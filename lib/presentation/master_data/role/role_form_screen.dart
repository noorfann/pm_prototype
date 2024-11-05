import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pm_prototype/cubit/role/role_cubit.dart';
import 'package:pm_prototype/cubit/role/role_state.dart';
import 'package:pm_prototype/presentation/widgets/cancel_button.dart';
import 'package:pm_prototype/presentation/widgets/header_widget.dart';
import 'package:pm_prototype/presentation/widgets/pm_textfield.dart';
import 'package:pm_prototype/presentation/widgets/popup_helper.dart';
import 'package:pm_prototype/presentation/widgets/submit_button.dart';
import 'package:core/core.dart';

class RoleFormScreen extends StatefulWidget {
  final bool isEdit;
  final Role? role;
  const RoleFormScreen({super.key, this.isEdit = false, this.role});

  @override
  State<RoleFormScreen> createState() => _RoleFormScreenState();
}

class _RoleFormScreenState extends State<RoleFormScreen> {
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.role != null) {
      nameController.text = widget.role!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RoleCubit, RoleState>(
          listener: (context, state) {
            if (state.error == RoleError.addError) {
              PopupHelper.showGeneralPopup(context,
                  title: 'Error',
                  desc: 'Failed to create role',
                  type: PopupType.failed);
            }
            if (state.status == RoleStatus.success &&
                state.operation == RoleOperation.add) {
              nameController.clear();
              PopupHelper.showGeneralPopup(context,
                  title: 'Success',
                  desc: 'Role has been created',
                  type: PopupType.success, onClose: () {
                context.pop();
              });
            }

            // update
            if (state.error == RoleError.updateError) {
              PopupHelper.showGeneralPopup(context,
                  title: 'Error',
                  desc: 'Failed to update role',
                  type: PopupType.failed);
            }
            if (state.status == RoleStatus.success &&
                state.operation == RoleOperation.update) {
              nameController.clear();
              PopupHelper.showGeneralPopup(context,
                  title: 'Success',
                  desc: 'Role has been updated',
                  type: PopupType.success, onClose: () {
                context.pop();
              });
            }
          },
        ),
      ],
      child: BlocBuilder<RoleCubit, RoleState>(
        builder: (context, state) {
          return Column(
            children: [
              if (state.status == RoleStatus.loading &&
                  (state.operation == RoleOperation.add ||
                      state.operation == RoleOperation.update))
                LinearProgressIndicator(
                  minHeight: 8,
                  color: Colors.deepPurpleAccent,
                  backgroundColor: Colors.deepPurple,
                ),
              HeaderWidget(
                title: 'Role',
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
                              label: 'Name',
                              hint: 'ex: Mobile Developer',
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Name is required';
                                }
                                return null;
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
                                      final role = Role(
                                        id: '',
                                        name: nameController.text,
                                      );
                                      if (widget.isEdit) {
                                        context.read<RoleCubit>().updateRole(
                                            widget.role!.id,
                                            role.copyWith(id: widget.role!.id));
                                      } else {
                                        context.read<RoleCubit>().addRole(role);
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
