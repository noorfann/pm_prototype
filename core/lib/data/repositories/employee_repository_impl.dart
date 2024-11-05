import 'package:core/data/datasources/employee_remote_ds.dart';
import 'package:core/domain/entities/employee.dart';
import 'package:core/domain/repositories/employee_repository.dart';
import 'package:dartz/dartz.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDS _datasource;

  EmployeeRepositoryImpl(this._datasource);
  @override
  Future<Either<String, bool>> addEmployee(Employee employee) async {
    final result = await _datasource.addEmployee(employee);

    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, bool>> deleteEmployee(String documentId) async {
    final result = await _datasource.deleteEmployee(documentId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, Employee>> getEmployeeById(String documentId) async {
    final result = await _datasource.getEmployeeById(documentId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, List<Employee>>> getEmployees() async {
    final result = await _datasource.getEmployees();
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, bool>> updateEmployee(
      String documentId, Employee employee) async {
    final result = await _datasource.updateEmployee(documentId, employee);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
