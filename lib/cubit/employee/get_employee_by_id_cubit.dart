import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/employee.dart';
import 'package:core/domain/usecases/employee/get_employee_by_id_uc.dart';
import 'package:equatable/equatable.dart';

part 'get_employee_by_id_state.dart';

class GetEmployeeByIdCubit extends Cubit<GetEmployeeByIdState> {
  final GetEmployeeByIdUC _getEmployeeByIdUC;
  GetEmployeeByIdCubit(this._getEmployeeByIdUC)
      : super(GetEmployeeByIdInitial());

  Future<void> getEmployeeById(int id) async {
    emit(GetEmployeeByIdLoading());
    final result = await _getEmployeeByIdUC.call(id);
    result.fold(
      (l) => emit(GetEmployeeByIdError(message: l)),
      (r) => emit(GetEmployeeByIdLoaded(employee: r)),
    );
  }
}
