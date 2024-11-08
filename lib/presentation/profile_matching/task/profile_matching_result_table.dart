import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:pm_prototype/cubit/profile_matching/profile_matching_state.dart';

class ProfileMatchingResultTable extends StatelessWidget {
  final List<EmployeeResult> results;

  const ProfileMatchingResultTable({
    Key? key,
    required this.results,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      showCheckboxColumn: false, // Jika tidak perlu checkbox
      columns: const [
        DataColumn2(
          label: Text('Rank'),
          size: ColumnSize.S,
          numeric: true,
        ),
        DataColumn2(
          label: Text('Employee Name'),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text('Total Score'),
          size: ColumnSize.M,
          numeric: true,
        ),
        DataColumn2(
          label: Text('Core Factor'),
          size: ColumnSize.M,
          numeric: true,
        ),
        DataColumn2(
          label: Text('Secondary Factor'),
          size: ColumnSize.M,
          numeric: true,
        ),
      ],
      rows: List<DataRow>.generate(
        results.length,
        (index) => DataRow(
          color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (index == 0) return Colors.yellow.withOpacity(0.1);
            if (index == 1) return Colors.grey.withOpacity(0.1);
            if (index == 2) return Colors.brown.withOpacity(0.1);
            return null;
          }),
          cells: [
            DataCell(Text('${index + 1}')),
            DataCell(Text(results[index].employee.name)),
            DataCell(Text(results[index].totalScore.toStringAsFixed(2))),
            DataCell(Text(results[index].coreFactor.toStringAsFixed(2))),
            DataCell(Text(results[index].secondaryFactor.toStringAsFixed(2))),
          ],
        ),
      ),
    );
  }
}
