import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pm_prototype/presentation/master_data/projects/components/project_table.dart';
import 'package:pm_prototype/presentation/widgets/add_button.dart';
import 'package:pm_prototype/presentation/widgets/header_widget.dart';
import 'package:pm_prototype/routes/routes.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: HeaderWidget(
            title: 'Project',
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
                    title: 'Tambah Project',
                    onPressed: () {
                      context.go(projectsFormScreen);
                    },
                  ),
                ),
                Expanded(child: ProjectTable())
              ],
            ),
          ),
        ),
      ],
    );
  }
}
