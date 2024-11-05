import 'package:core/data/datasources/role_remote_ds.dart';
import 'package:core/domain/entities/role.dart';
import 'package:core/domain/repositories/role_repository.dart';
import 'package:dartz/dartz.dart';

class RoleRepositoryImpl implements RoleRepository {
  final RoleRemoteDS _datasource;

  RoleRepositoryImpl(this._datasource);

  @override
  Future<Either<String, bool>> addRole(Role role) async {
    final result = await _datasource.addRole(role);

    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, bool>> deleteRole(String documentId) async {
    final result = await _datasource.deleteRole(documentId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, Role>> getRoleById(String documentId) async {
    final result = await _datasource.getRoleById(documentId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, List<Role>>> getRoles() async {
    final result = await _datasource.getRoles();
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, bool>> updateRole(String documentId, Role role) async {
    final result = await _datasource.updateRole(documentId, role);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
