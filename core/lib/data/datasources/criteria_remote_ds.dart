import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:core/data/mapper/criteria_mapper.dart';
import 'package:core/domain/entities/criteria.dart';
import 'package:core/utils/app_logger.dart';
import 'package:core/utils/constants.dart';
import 'package:dartz/dartz.dart';

class CriteriaRemoteDS {
  final appwrite.Databases _databases;
  final appwrite.Account _account;
  CriteriaRemoteDS(this._databases, this._account) {
    createAnon();
  }

  createAnon() async {
    try {
      await _account.get();
    } catch (_) {
      await _account.createAnonymousSession();
    }
  }

  Future<Either<String, List<Criteria>>> getCriterias() async {
    try {
      final response = await _databases.listDocuments(
          databaseId: databaseId, collectionId: criteriaCollectionId);
      final result = response.documents
          .map((e) => CriteriaMapper.fromJson(e.data))
          .toList();

      logger.logInfo(result.toString());
      return Right(result);
    } catch (e) {
      logger.logError('failed to get Criterias ${e.toString()}');
      return const Left('Failed to get Criterias');
    }
  }

  Future<Either<String, bool>> addCriteria(Criteria criteria) async {
    try {
      logger.logInfo("added Criteria ${CriteriaMapper.toJson(criteria)}");
      await _databases.createDocument(
        databaseId: databaseId,
        collectionId: criteriaCollectionId,
        documentId: appwrite.ID.unique(),
        data: CriteriaMapper.toJson(criteria),
      );
      logger
          .logInfo("added Criteria success${CriteriaMapper.toJson(criteria)}");
      return const Right(true);
    } catch (e) {
      logger.logError('failed to add Criterias ${e.toString()}');
      return const Left('Failed to add Criteria');
    }
  }

  Future<Either<String, bool>> updateCriteria(
      String documentId, Criteria criteria) async {
    try {
      logger.logInfo(
          'updated Criteria $documentId, ${CriteriaMapper.toJson(criteria)}');
      await _databases.updateDocument(
        databaseId: databaseId,
        collectionId: criteriaCollectionId,
        documentId: documentId,
        data: CriteriaMapper.toJson(criteria),
      );
      return const Right(true);
    } catch (e) {
      logger.logError('failed to update Criterias ${e.toString()}');
      return const Left('Failed to update Criteria');
    }
  }

  Future<Either<String, bool>> deleteCriteria(String documentId) async {
    try {
      await _databases.deleteDocument(
        databaseId: databaseId,
        collectionId: criteriaCollectionId,
        documentId: documentId,
      );
      return const Right(true);
    } catch (e) {
      logger.logError('failed to delete Criterias ${e.toString()}');
      return const Left('Failed to delete Criteria');
    }
  }

  Future<Either<String, Criteria>> getCriteriaById(String documentId) async {
    try {
      final result = await _databases.getDocument(
        databaseId: databaseId,
        collectionId: criteriaCollectionId,
        documentId: documentId,
      );
      return Right(CriteriaMapper.fromJson(result.data));
    } catch (e) {
      return const Left('Failed to update employee');
    }
  }
}
