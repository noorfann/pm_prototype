import 'package:core/domain/entities/employee.dart';
import 'package:core/domain/repositories/employee_repository.dart';
import 'package:dartz/dartz.dart';

class GetEmployeeListUC {
  final EmployeeRepository _repository;

  GetEmployeeListUC(this._repository);

  Future<Either<String, List<Employee>>> call() async {
    final result = await _repository.getEmployees();
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
