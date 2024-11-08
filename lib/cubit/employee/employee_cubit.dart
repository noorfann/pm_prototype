import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:pm_prototype/cubit/employee/employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeRepository repository;

  EmployeeCubit({required this.repository}) : super(EmployeeState());

  // Get employee
  Future<void> getEmployees() async {
    _resetState();
    try {
      emit(state.copyWith(
          status: EmployeeStatus.loading,
          error: EmployeeError.none,
          operation: EmployeeOperation.fetch));
      final employee = await repository.getEmployees();
      employee.fold(
        (l) => emit(state.copyWith(
          operation: EmployeeOperation.fetch,
          status: EmployeeStatus.failure,
          error: EmployeeError.none,
        )),
        (r) => emit(state.copyWith(
          operation: EmployeeOperation.fetch,
          status: EmployeeStatus.success,
          employees: r,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
        operation: EmployeeOperation.fetch,
        status: EmployeeStatus.failure,
        error: EmployeeError.none,
      ));
    }
  }

  // Add employee
  Future<void> addEmployee(Employee employee) async {
    _resetState();
    try {
      emit(state.copyWith(
        status: EmployeeStatus.loading,
        error: EmployeeError.none,
        operation: EmployeeOperation.add,
      ));
      await repository.addEmployee(employee);
      emit(state.copyWith(
        status: EmployeeStatus.success,
        operation: EmployeeOperation.add,
      ));
      getEmployees();
    } catch (e) {
      emit(state.copyWith(
        status: EmployeeStatus.failure,
        error: EmployeeError.addError,
        operation: EmployeeOperation.add,
      ));
    }
  }

  // Delete employee
  Future<void> deleteEmployee(String id) async {
    _resetState();
    try {
      emit(state.copyWith(
        status: EmployeeStatus.loading,
        error: EmployeeError.none,
        operation: EmployeeOperation.delete,
      ));
      await repository.deleteEmployee(id);
      final updatedEmployee = state.employees.where((e) => e.id != id).toList();
      emit(state.copyWith(
        status: EmployeeStatus.success,
        employees: updatedEmployee,
        operation: EmployeeOperation.delete,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: EmployeeStatus.failure,
        error: EmployeeError.deleteError,
        operation: EmployeeOperation.delete,
      ));
    }
  }

  // Update employee
  Future<void> updateEmployee(String id, Employee employee) async {
    _resetState();
    try {
      emit(state.copyWith(
        status: EmployeeStatus.loading,
        error: EmployeeError.none,
        operation: EmployeeOperation.update,
      ));
      await repository.updateEmployee(id, employee);
      final updatedEmployee = state.employees.map((e) {
        if (e.id == id) {
          return employee;
        }
        return e;
      }).toList();
      emit(state.copyWith(
        status: EmployeeStatus.success,
        operation: EmployeeOperation.update,
        employees: updatedEmployee,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: EmployeeStatus.failure,
        error: EmployeeError.updateError,
        operation: EmployeeOperation.update,
      ));
    }
  }

  void _resetState() {
    emit(state.copyWith(
      status: EmployeeStatus.loading,
      error: EmployeeError.none,
      operation: EmployeeOperation.fetch,
    ));
  }
}
