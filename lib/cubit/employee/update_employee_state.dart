part of 'update_employee_cubit.dart';

sealed class UpdateEmployeeState extends Equatable {
  const UpdateEmployeeState();

  @override
  List<Object> get props => [];
}

final class UpdateEmployeeInitial extends UpdateEmployeeState {}

final class UpdateEmployeeLoading extends UpdateEmployeeState {}

final class UpdateEmployeeLoaded extends UpdateEmployeeState {
  final Employee employee;
  const UpdateEmployeeLoaded({required this.employee});
}

final class UpdateEmployeeError extends UpdateEmployeeState {
  final String message;
  const UpdateEmployeeError({required this.message});
}
