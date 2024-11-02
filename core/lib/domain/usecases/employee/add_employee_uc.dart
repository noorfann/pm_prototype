import 'package:core/domain/entities/employee.dart';
import 'package:core/domain/repositories/employee_repository.dart';
import 'package:dartz/dartz.dart';

class AddEmployeeUC {
  final EmployeeRepository repository;

  AddEmployeeUC(this.repository);

  Future<Either<String, bool>> call(Employee employee) async {
    final result = await repository.addEmployee(employee);
    return result;
  }
}
