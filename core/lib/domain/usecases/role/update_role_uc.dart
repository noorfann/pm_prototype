import 'package:core/domain/entities/role.dart';
import 'package:core/domain/repositories/role_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateRoleUC {
  final RoleRepository repository;

  UpdateRoleUC(this.repository);

  Future<Either<String, bool>> call(String documentId, Role role) async {
    final result = await repository.updateRole(documentId, role);
    return result;
  }
}
