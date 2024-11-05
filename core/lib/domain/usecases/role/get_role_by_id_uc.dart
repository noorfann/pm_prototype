import 'package:core/domain/entities/role.dart';
import 'package:core/domain/repositories/role_repository.dart';
import 'package:dartz/dartz.dart';

class GetRoleByIdUC {
  final RoleRepository _repository;

  GetRoleByIdUC(this._repository);

  Future<Either<String, Role>> call(String documentId) async {
    final result = await _repository.getRoleById(documentId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
