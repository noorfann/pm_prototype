import 'package:core/domain/repositories/role_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteRoleUC {
  final RoleRepository _repository;

  DeleteRoleUC(this._repository);

  Future<Either<String, bool>> call(String documentId) async {
    final result = await _repository.deleteRole(documentId);
    return result;
  }
}
