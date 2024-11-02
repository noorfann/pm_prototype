import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/employee.dart';
import 'package:core/domain/usecases/employee/get_employee_list_uc.dart';
import 'package:equatable/equatable.dart';

part 'get_employee_list_state.dart';

class GetEmployeeListCubit extends Cubit<GetEmployeeListState> {
  final GetEmployeeListUC _getEmployeeListUC;
  GetEmployeeListCubit(this._getEmployeeListUC)
      : super(GetEmployeeListInitial());

  Future<void> getEmployeeList() async {
    emit(GetEmployeeListLoading());
    final result = await _getEmployeeListUC();
    result.fold(
      (l) => emit(GetEmployeeListError(message: l)),
      (r) => emit(GetEmployeeListLoaded(employees: r)),
    );
  }
}
