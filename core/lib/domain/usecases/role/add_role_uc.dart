import 'package:core/domain/entities/role.dart';
import 'package:core/domain/repositories/role_repository.dart';
import 'package:dartz/dartz.dart';

class AddRoleUC {
  final RoleRepository repository;

  AddRoleUC(this.repository);

  Future<Either<String, bool>> call(Role role) async {
    final result = await repository.addRole(role);
    return result;
  }
}
