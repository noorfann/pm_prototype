import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';

import 'components/projects_card.dart';

class ProjectsDashboardScreen extends StatelessWidget {
  const ProjectsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Projects',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: defaultPadding),
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: 5,
                itemBuilder: (context, index) => const ProjectCard()),
          ),
        ],
      ),
    );
  }
}
