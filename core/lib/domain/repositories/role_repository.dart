import 'package:core/domain/entities/role.dart';
import 'package:dartz/dartz.dart';

abstract class RoleRepository {
  Future<Either<String, List<Role>>> getRoles();
  Future<Either<String, Role>> getRoleById(String documentId);

  Future<Either<String, bool>> addRole(Role role);
  Future<Either<String, bool>> updateRole(String documentId, Role role);
  Future<Either<String, bool>> deleteRole(String documentId);
}
