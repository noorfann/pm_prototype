import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:pm_prototype/cubit/role/role_state.dart';

class RoleCubit extends Cubit<RoleState> {
  final RoleRepository repository;

  RoleCubit({required this.repository}) : super(RoleState());

  // Get roles
  Future<void> getRoles() async {
    _resetState();
    try {
      emit(state.copyWith(
          status: RoleStatus.loading,
          error: RoleError.none,
          operation: RoleOperation.fetch));
      final roles = await repository.getRoles();
      roles.fold(
        (l) => emit(state.copyWith(
          operation: RoleOperation.fetch,
          status: RoleStatus.failure,
          error: RoleError.none,
        )),
        (r) => emit(state.copyWith(
          operation: RoleOperation.fetch,
          status: RoleStatus.success,
          roles: r,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
        operation: RoleOperation.fetch,
        status: RoleStatus.failure,
        error: RoleError.none,
      ));
    }
  }

  // Add roles
  Future<void> addRole(Role role) async {
    _resetState();
    try {
      emit(state.copyWith(
        status: RoleStatus.loading,
        error: RoleError.none,
        operation: RoleOperation.add,
      ));
      await repository.addRole(role);
      emit(state.copyWith(
        status: RoleStatus.success,
        operation: RoleOperation.add,
      ));
      getRoles();
    } catch (e) {
      emit(state.copyWith(
        status: RoleStatus.failure,
        error: RoleError.addError,
        operation: RoleOperation.add,
      ));
    }
  }

  // Delete roles
  Future<void> deleteRole(String id) async {
    _resetState();
    try {
      emit(state.copyWith(
        status: RoleStatus.loading,
        error: RoleError.none,
        operation: RoleOperation.delete,
      ));
      await repository.deleteRole(id);
      final updatedRoles = state.roles.where((e) => e.id != id).toList();
      emit(state.copyWith(
        status: RoleStatus.success,
        roles: updatedRoles,
        operation: RoleOperation.delete,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: RoleStatus.failure,
        error: RoleError.deleteError,
        operation: RoleOperation.delete,
      ));
    }
  }

  // Update role
  Future<void> updateRole(String id, Role role) async {
    _resetState();
    try {
      emit(state.copyWith(
        status: RoleStatus.loading,
        error: RoleError.none,
        operation: RoleOperation.update,
      ));
      await repository.updateRole(id, role);
      final updatedRoles = state.roles.map((e) {
        if (e.id == id) {
          return role;
        }
        return e;
      }).toList();
      emit(state.copyWith(
        status: RoleStatus.success,
        operation: RoleOperation.update,
        roles: updatedRoles,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: RoleStatus.failure,
        error: RoleError.updateError,
        operation: RoleOperation.update,
      ));
    }
  }

  void _resetState() {
    emit(state.copyWith(
      status: RoleStatus.initial,
      error: RoleError.none,
      operation: RoleOperation.fetch,
    ));
  }
}
