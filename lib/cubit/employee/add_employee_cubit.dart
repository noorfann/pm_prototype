import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/employee.dart';
import 'package:core/domain/usecases/employee/add_employee_uc.dart';
import 'package:equatable/equatable.dart';

part 'add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  final AddEmployeeUC _addEmployeeUC;
  AddEmployeeCubit(this._addEmployeeUC) : super(AddEmployeeInitial());

  Future<void> addEmployee(Employee employee) async {
    emit(AddEmployeeLoading());
    final result = await _addEmployeeUC.call(employee);
    result.fold(
      (l) => emit(AddEmployeeFailed(l)),
      (r) => emit(AddEmployeeSuccess()),
    );
  }
}
