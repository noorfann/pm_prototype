part of 'delete_employee_cubit.dart';

sealed class DeleteEmployeeState extends Equatable {
  const DeleteEmployeeState();

  @override
  List<Object> get props => [];
}

final class DeleteEmployeeInitial extends DeleteEmployeeState {}

final class DeleteEmployeeLoading extends DeleteEmployeeState {}

final class DeleteEmployeeSuccess extends DeleteEmployeeState {}

final class DeleteEmployeeFailed extends DeleteEmployeeState {}

final class DeleteEmployeeError extends DeleteEmployeeState {
  final String message;

  const DeleteEmployeeError(this.message);
}
