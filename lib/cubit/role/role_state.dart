import 'package:core/core.dart';

enum RoleStatus { loading, success, failure }

enum RoleOperation { fetch, add, delete, update }

enum RoleError { none, addError, deleteError, updateError }

class RoleState {
  final RoleStatus status;
  final List<Role> roles;
  final RoleError error;
  final RoleOperation operation;

  RoleState({
    this.status = RoleStatus.loading,
    this.roles = const [],
    this.error = RoleError.none,
    this.operation = RoleOperation.add,
  });

  RoleState copyWith({
    RoleStatus? status,
    List<Role>? roles,
    RoleError? error,
    RoleOperation? operation,
  }) {
    return RoleState(
      status: status ?? this.status,
      roles: roles ?? this.roles,
      error: error ?? this.error,
      operation: operation ?? this.operation,
    );
  }
}
