import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AssesmentDetailDialog {
  static void show(BuildContext context,
      {required Assessment assessment,
      required List<AssessmentDetail> assessmentDetail}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Column(
                children: [
                  Text(
                    'Detail Penilaian',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Divider(),
                  Text(
                    assessment.employee.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Divider(),
                  Text(
                    'Nilai',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  ...assessmentDetail.map(
                    (e) {
                      return Row(
                        children: [
                          Text(
                            e.criteria.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Spacer(),
                          Text(
                            '${e.score}',
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      );
                    },
                  )
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        )
      ])),
    );
  }
}
