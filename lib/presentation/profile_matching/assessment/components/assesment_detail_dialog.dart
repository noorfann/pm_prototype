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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detail Penilaian',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Divider(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            assessment.employee.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            " (${assessment.employee.role?.name ?? '-'})",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const Divider(
                        height: 20,
                      ),
                      Text(
                        'Nilai',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      verticalSpacing(),
                      Table(
                          columnWidths: const {
                            0: FlexColumnWidth(),
                            1: FlexColumnWidth(),
                          },
                          border: TableBorder.all(
                              color: Theme.of(context).colorScheme.outline),
                          children: [
                            TableRow(children: [
                              Text(
                                'Kriteria',
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Nilai',
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                            ]),
                            ...assessmentDetail.map(
                              (e) {
                                return TableRow(
                                  children: [
                                    Text(
                                      e.criteria.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      '${e.score}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                );
                              },
                            )
                          ]),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
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
            )
          ])),
    );
  }
}
