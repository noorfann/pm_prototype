import 'package:core/common/enums.dart';
import 'package:core/utils/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pm_prototype/cubit/criteria/criteria_cubit.dart';
import 'package:pm_prototype/cubit/criteria/criteria_state.dart';
import 'package:pm_prototype/presentation/widgets/cancel_button.dart';
import 'package:pm_prototype/presentation/widgets/header_widget.dart';
import 'package:pm_prototype/presentation/widgets/pm_dropdown.dart';
import 'package:pm_prototype/presentation/widgets/pm_textfield.dart';
import 'package:pm_prototype/presentation/widgets/popup_helper.dart';
import 'package:pm_prototype/presentation/widgets/submit_button.dart';
import 'package:core/core.dart';

class CriteriaFormScreen extends StatefulWidget {
  final bool isEdit;
  final Criteria? criteria;
  const CriteriaFormScreen({super.key, this.isEdit = false, this.criteria});

  @override
  State<CriteriaFormScreen> createState() => _CriteriaFormScreenState();
}

class _CriteriaFormScreenState extends State<CriteriaFormScreen> {
  final TextEditingController nameController = TextEditingController();
  CriteriaType? criteriaType;
  int? score;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.criteria != null) {
      nameController.text = widget.criteria!.name;
      criteriaType = widget.criteria!.criteriaType;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CriteriaCubit, CriteriaState>(
          listener: (context, state) {
            if (state.error == CriteriaError.addError) {
              PopupHelper.showGeneralPopup(context,
                  title: 'Error',
                  desc: 'Failed to create Criteria',
                  type: PopupType.failed);
            }
            if (state.status == CriteriaStatus.success &&
                state.operation == CriteriaOperation.add) {
              nameController.clear();
              PopupHelper.showGeneralPopup(context,
                  title: 'Success',
                  desc: 'Criteria has been created',
                  type: PopupType.success, onClose: () {
                context.pop();
              });
            }

            // update
            if (state.error == CriteriaError.updateError) {
              PopupHelper.showGeneralPopup(context,
                  title: 'Error',
                  desc: 'Failed to update Criteria',
                  type: PopupType.failed);
            }
            if (state.status == CriteriaStatus.success &&
                state.operation == CriteriaOperation.update) {
              nameController.clear();
              PopupHelper.showGeneralPopup(context,
                  title: 'Success',
                  desc: 'Criteria has been updated',
                  type: PopupType.success, onClose: () {
                context.pop();
              });
            }
          },
        ),
      ],
      child: BlocBuilder<CriteriaCubit, CriteriaState>(
        builder: (context, state) {
          return Column(
            children: [
              if (state.status == CriteriaStatus.loading &&
                  (state.operation == CriteriaOperation.add ||
                      state.operation == CriteriaOperation.update))
                LinearProgressIndicator(
                  minHeight: 8,
                  color: Colors.deepPurpleAccent,
                  backgroundColor: Colors.deepPurple,
                ),
              HeaderWidget(
                title: 'Criteria',
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
                              hint: 'ex: Kualitas Kode',
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama wajib diisi';
                                }
                                return null;
                              },
                            ),
                            verticalSpacing(),
                            PMDropdown(
                                label: 'Tipe Kriteria',
                                items: CriteriaType.values
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e.name),
                                        ))
                                    .toList(),
                                onChanged: (value) => setState(() {
                                      criteriaType = value as CriteriaType;
                                    }),
                                value: criteriaType),
                            verticalSpacing(),
                            PMDropdown(
                                label: 'Nilai',
                                items: <int>[1, 2, 3, 4, 5]
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e.toString()),
                                        ))
                                    .toList(),
                                onChanged: (value) => setState(() {
                                      score = value;
                                    }),
                                value: score),
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
                                      if (criteriaType == null ||
                                          score == null) {
                                        PopupHelper.showGeneralPopup(context,
                                            title: 'Error',
                                            desc:
                                                'Harap isi semua data untuk lanjut',
                                            type: PopupType.failed);
                                        return;
                                      }
                                      final criteria = Criteria(
                                        id: '',
                                        name: nameController.text,
                                        criteriaType: criteriaType!,
                                        score: score!,
                                      );
                                      logger.logInfo(
                                          "criteria type ${criteria.criteriaType.name})}");
                                      if (widget.isEdit) {
                                        context
                                            .read<CriteriaCubit>()
                                            .updateCriteria(
                                                widget.criteria!.id,
                                                criteria.copyWith(
                                                    id: widget.criteria!.id));
                                      } else {
                                        context
                                            .read<CriteriaCubit>()
                                            .addCriteria(criteria);
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
