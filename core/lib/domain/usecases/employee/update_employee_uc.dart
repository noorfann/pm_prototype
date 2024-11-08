import 'package:core/domain/entities/employee.dart';
import 'package:core/domain/repositories/employee_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateEmployeeUC {
  final EmployeeRepository repository;

  UpdateEmployeeUC(this.repository);

  Future<Either<String, bool>> call(
      String documentId, Employee employee) async {
    final result = await repository.updateEmployee(documentId, employee);
    return result;
  }
}
