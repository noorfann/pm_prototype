import 'package:core/domain/entities/employee.dart';
import 'package:core/domain/repositories/employee_repository.dart';
import 'package:dartz/dartz.dart';

class GetEmployeeByIdUC {
  final EmployeeRepository _repository;

  GetEmployeeByIdUC(this._repository);

  Future<Either<String, Employee>> call(int id) async {
    final result = await _repository.getEmployeeById(id);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
