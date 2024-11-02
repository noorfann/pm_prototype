import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/employee.dart';
import 'package:core/domain/usecases/employee/get_employee_by_id_uc.dart';
import 'package:equatable/equatable.dart';

part 'update_employee_state.dart';

class UpdateEmployeeCubit extends Cubit<UpdateEmployeeState> {
  final GetEmployeeByIdUC _getEmployeeByIdUC;
  UpdateEmployeeCubit(this._getEmployeeByIdUC) : super(UpdateEmployeeInitial());

  Future<void> getEmployeeById(int id) async {
    emit(UpdateEmployeeLoading());
    final result = await _getEmployeeByIdUC.call(id);
    result.fold(
      (l) => emit(UpdateEmployeeError(message: l)),
      (r) => emit(UpdateEmployeeLoaded(employee: r)),
    );
  }
}
