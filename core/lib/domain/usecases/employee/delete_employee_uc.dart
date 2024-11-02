import 'package:core/domain/repositories/employee_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteEmployeeUC {
  final EmployeeRepository _repository;

  DeleteEmployeeUC(this._repository);

  Future<Either<String, bool>> call(int id) async {
    final result = await _repository.deleteEmployee(id);
    return result;
  }
}
