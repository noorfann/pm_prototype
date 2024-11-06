import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pm_prototype/presentation/widgets/add_button.dart';
import 'package:pm_prototype/presentation/widgets/header_widget.dart';
import 'package:pm_prototype/routes/routes.dart';

import 'components/assessment_table.dart';

class AssessmentScreen extends StatelessWidget {
  const AssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: HeaderWidget(
            title: 'Penilaian',
            withCloseButton: false,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: AddButton(
                    title: 'Tambah Penilaian',
                    onPressed: () {
                      context.go(assessmentFormScreen);
                    },
                  ),
                ),
                Expanded(child: AssesmentTable())
              ],
            ),
          ),
        ),
      ],
    );
  }
}
