import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:core/data/mapper/role_mapper.dart';
import 'package:core/domain/entities/role.dart';
import 'package:core/utils/app_logger.dart';
import 'package:core/utils/constants.dart';
import 'package:dartz/dartz.dart';

class RoleRemoteDS {
  final appwrite.Databases _databases;
  final appwrite.Account _account;
  RoleRemoteDS(this._databases, this._account) {
    createAnon();
  }

  createAnon() async {
    try {
      await _account.get();
    } catch (_) {
      await _account.createAnonymousSession();
    }
  }

  Future<Either<String, List<Role>>> getRoles() async {
    try {
      final response = await _databases.listDocuments(
          databaseId: databaseId, collectionId: roleCollectionId);
      final result =
          response.documents.map((e) => RoleMapper.fromJson(e.data)).toList();

      logger.logInfo(result.toString());
      return Right(result);
    } catch (e) {
      logger.logError('failed to get Roles ${e.toString()}');
      return const Left('Failed to get Roles');
    }
  }

  Future<Either<String, bool>> addRole(Role role) async {
    try {
      await _databases.createDocument(
        databaseId: databaseId,
        collectionId: roleCollectionId,
        documentId: appwrite.ID.unique(),
        data: RoleMapper.toJson(role),
      );
      return const Right(true);
    } catch (e) {
      logger.logError('failed to add Roles ${e.toString()}');
      return const Left('Failed to add Role');
    }
  }

  Future<Either<String, bool>> updateRole(String documentId, Role role) async {
    try {
      logger.logInfo('updated Role $documentId, ${RoleMapper.toJson(role)}');
      await _databases.updateDocument(
        databaseId: databaseId,
        collectionId: roleCollectionId,
        documentId: documentId,
        data: RoleMapper.toJson(role),
      );
      return const Right(true);
    } catch (e) {
      logger.logError('failed to update Roles ${e.toString()}');
      return const Left('Failed to update Role');
    }
  }

  Future<Either<String, bool>> deleteRole(String documentId) async {
    try {
      await _databases.deleteDocument(
        databaseId: databaseId,
        collectionId: roleCollectionId,
        documentId: documentId,
      );
      return const Right(true);
    } catch (e) {
      logger.logError('failed to delete Roles ${e.toString()}');
      return const Left('Failed to delete Role');
    }
  }

  Future<Either<String, Role>> getRoleById(String documentId) async {
    try {
      final result = await _databases.getDocument(
        databaseId: databaseId,
        collectionId: roleCollectionId,
        documentId: documentId,
      );
      return Right(RoleMapper.fromJson(result.data));
    } catch (e) {
      return const Left('Failed to update employee');
    }
  }
}
