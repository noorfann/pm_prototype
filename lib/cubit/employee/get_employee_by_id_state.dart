part of 'get_employee_by_id_cubit.dart';

sealed class GetEmployeeByIdState extends Equatable {
  const GetEmployeeByIdState();

  @override
  List<Object> get props => [];
}

final class GetEmployeeByIdInitial extends GetEmployeeByIdState {}

final class GetEmployeeByIdLoading extends GetEmployeeByIdState {}

final class GetEmployeeByIdLoaded extends GetEmployeeByIdState {
  final Employee employee;

  const GetEmployeeByIdLoaded({required this.employee});
}

final class GetEmployeeByIdError extends GetEmployeeByIdState {
  final String message;

  const GetEmployeeByIdError({required this.message});
}
