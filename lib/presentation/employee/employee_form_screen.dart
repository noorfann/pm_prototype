import 'package:core/common/enums.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pm_prototype/presentation/widgets/pm_textfield.dart';
import 'package:pm_prototype/presentation/widgets/popup_helper.dart';
import 'package:pm_prototype/presentation/widgets/submit_button.dart';
import 'package:core/core.dart';

class EmployeeFormScreen extends StatefulWidget {
  const EmployeeFormScreen({super.key});

  @override
  State<EmployeeFormScreen> createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  Gender gender = Gender.male;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpacing(30),
        Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                child: ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: 16,
                        ),
                        horizontalSpacing(8),
                        Text(
                          'Back',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                      ],
                    )),
              ),
            ),
            const Text(
              'Employee Form',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
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
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  PMTextfield(
                      label: 'Name',
                      hint: 'ex: John Doe',
                      controller: nameController),
                  verticalSpacing(),
                  PMTextfield(
                      label: 'Email',
                      hint: 'ex: aaa@example.com',
                      controller: emailController),
                  verticalSpacing(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Gender',
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    Theme.of(context).colorScheme.onSurface)),
                        DropdownButton<String>(
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(8),
                          hint: Text("Select Gender"),
                          value: gender.name,
                          items: <String>[Gender.male.name, Gender.female.name]
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              gender = Gender.values.firstWhere(
                                  (element) => element.name == value);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  verticalSpacing(24),
                  SizedBox(
                    width: double.infinity,
                    child: SubmitButton(
                        text: 'Submit',
                        onPressed: () {
                          PopupHelper.showGeneralPopup(context,
                              title: 'Success',
                              desc: 'Employee has been created',
                              type: PopupType.success);
                        }),
                  ),
                ],
              )),
            ),
          ],
        ),
      ],
    );
  }
}
