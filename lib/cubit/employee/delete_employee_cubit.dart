import 'package:bloc/bloc.dart';
import 'package:core/domain/usecases/employee/delete_employee_uc.dart';
import 'package:equatable/equatable.dart';

part 'delete_employee_state.dart';

class DeleteEmployeeCubit extends Cubit<DeleteEmployeeState> {
  final DeleteEmployeeUC _deleteEmployeeUC;

  DeleteEmployeeCubit(this._deleteEmployeeUC) : super(DeleteEmployeeInitial());

  void deleteEmployee(int employeeId) async {
    emit(DeleteEmployeeLoading());
    final result = await _deleteEmployeeUC(employeeId);
    result.fold((l) => emit(DeleteEmployeeError(l)),
        (r) => emit(DeleteEmployeeSuccess()));
  }
}
