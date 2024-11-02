import 'package:core/domain/entities/employee.dart';
import 'package:dartz/dartz.dart';

abstract class EmployeeRepository {
  Future<Either<String, List<Employee>>> getEmployees();
  Future<Either<String, Employee>> getEmployeeById(int id);

  Future<Either<String, bool>> addEmployee(Employee employee);
  Future<Either<String, bool>> updateEmployee(Employee employee);
  Future<Either<String, bool>> deleteEmployee(int id);
}
