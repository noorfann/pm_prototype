import 'package:core/data/datasources/dummy_datasource.dart';
import 'package:core/domain/entities/employee.dart';
import 'package:core/domain/repositories/employee_repository.dart';
import 'package:dartz/dartz.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final DummyDatasource _datasource;

  EmployeeRepositoryImpl(this._datasource);
  @override
  Future<Either<String, bool>> addEmployee(Employee employee) async {
    final result = await _datasource.addEmployee(employee);
    return Right(result);
  }

  @override
  Future<Either<String, bool>> deleteEmployee(int id) async {
    final result = await _datasource.deleteEmployee(id);
    return Right(result);
  }

  @override
  Future<Either<String, Employee>> getEmployeeById(int id) async {
    final result = await _datasource.getEmployeeById(id);
    return Right(result);
  }

  @override
  Future<Either<String, List<Employee>>> getEmployees() async {
    final result = await _datasource.getEmployees();
    return Right(result);
  }

  @override
  Future<Either<String, bool>> updateEmployee(Employee employee) async {
    final result = await _datasource.updateEmployee(employee);
    return Right(result);
  }
}
