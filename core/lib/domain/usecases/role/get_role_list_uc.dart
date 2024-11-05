import 'package:core/domain/entities/role.dart';
import 'package:core/domain/repositories/role_repository.dart';
import 'package:dartz/dartz.dart';

class GetRoleListUC {
  final RoleRepository _repository;

  GetRoleListUC(this._repository);

  Future<Either<String, List<Role>>> call() async {
    final result = await _repository.getRoles();
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
