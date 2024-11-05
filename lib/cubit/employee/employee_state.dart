import 'package:core/core.dart';

enum EmployeeStatus { initial, loading, success, failure }

enum EmployeeOperation { fetch, add, delete, update }

enum EmployeeError { none, addError, deleteError, updateError }

class EmployeeState {
  final EmployeeStatus status;
  final List<Employee> employees;
  final EmployeeError error;
  final EmployeeOperation operation;

  EmployeeState({
    this.status = EmployeeStatus.initial,
    this.employees = const [],
    this.error = EmployeeError.none,
    this.operation = EmployeeOperation.add,
  });

  EmployeeState copyWith({
    EmployeeStatus? status,
    List<Employee>? employees,
    EmployeeError? error,
    EmployeeOperation? operation,
  }) {
    return EmployeeState(
      status: status ?? this.status,
      employees: employees ?? this.employees,
      error: error ?? this.error,
      operation: operation ?? this.operation,
    );
  }
}
