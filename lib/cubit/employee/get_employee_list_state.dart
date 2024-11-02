part of 'get_employee_list_cubit.dart';

sealed class GetEmployeeListState extends Equatable {
  const GetEmployeeListState();

  @override
  List<Object> get props => [];
}

final class GetEmployeeListInitial extends GetEmployeeListState {}

final class GetEmployeeListLoading extends GetEmployeeListState {}

final class GetEmployeeListLoaded extends GetEmployeeListState {
  final List<Employee> employees;
  const GetEmployeeListLoaded({required this.employees});
}

final class GetEmployeeListError extends GetEmployeeListState {
  final String message;
  const GetEmployeeListError({required this.message});
}
