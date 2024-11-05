import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pm_prototype/presentation/master_data/role/components/role_table.dart';
import 'package:pm_prototype/presentation/widgets/add_button.dart';
import 'package:pm_prototype/presentation/widgets/header_widget.dart';
import 'package:pm_prototype/routes/routes.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: HeaderWidget(
            title: 'Role',
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
                    title: 'Add Role',
                    onPressed: () {
                      context.go(roleFormScreen);
                    },
                  ),
                ),
                Expanded(child: RoleTable())
              ],
            ),
          ),
        ),
      ],
    );
  }
}
