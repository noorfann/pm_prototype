import 'package:core/common/enums.dart';
import 'package:core/domain/entities/employee.dart';

class DummyDatasource {
  Future<List<Employee>> getEmployees() {
    return Future.delayed(
        const Duration(seconds: 1),
        () => [
              const Employee(
                id: 1,
                name: 'John Doe',
                gender: Gender.male,
                email: 't5b9a@example.com',
              ),
              const Employee(
                id: 2,
                name: 'Abdul Doe',
                gender: Gender.male,
                email: 't5b9a@example.com',
              ),
              const Employee(
                id: 3,
                name: 'Andika Doe',
                gender: Gender.male,
                email: 't5b9a@example.com',
              )
            ]);
  }

  Future<Employee> getEmployeeById(int id) {
    return Future.delayed(
        const Duration(seconds: 1),
        () => getEmployees().then(
              (value) => value.firstWhere((element) => element.id == id),
            ));
  }

  Future<bool> addEmployee(Employee employee) async {
    return Future.delayed(const Duration(seconds: 1), () => true);
  }

  Future<bool> updateEmployee(Employee employee) async {
    return Future.delayed(const Duration(seconds: 1), () => true);
  }

  Future<bool> deleteEmployee(int id) async {
    return Future.delayed(const Duration(seconds: 1), () => true);
  }
}
