import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:core/data/mapper/assessment_detail_mapper.dart';
import 'package:core/domain/entities/assessment_detail.dart';
import 'package:core/utils/app_logger.dart';
import 'package:core/utils/constants.dart';
import 'package:dartz/dartz.dart';

class AssessmentDetailRemoteDS {
  final appwrite.Databases _databases;
  final appwrite.Account _account;
  AssessmentDetailRemoteDS(this._databases, this._account) {
    createAnon();
  }

  createAnon() async {
    try {
      await _account.get();
    } catch (_) {
      await _account.createAnonymousSession();
    }
  }

  Future<Either<String, List<AssessmentDetail>>> getAssessmentDetails(
      String assessmentId) async {
    try {
      final response = await _databases.listDocuments(
          databaseId: databaseId,
          collectionId: assessmentDetailCollectionId,
          queries: [
            appwrite.Query.equal('assessment', assessmentId),
          ]);
      final result = response.documents
          .map((e) => AssessmentDetailMapper.fromJson(e.data))
          .toList();

      logger.logInfo("AssessmentDetails ${result.toString()}");
      return Right(result);
    } catch (e) {
      logger.logError('failed to get AssessmentDetails ${e.toString()}');
      return const Left('Failed to get AssessmentDetails');
    }
  }

  Future<Either<String, bool>> addAssessmentDetail(
      AssessmentDetail assessmentDetail) async {
    try {
      logger.logInfo(
          "added AssessmentDetail ${AssessmentDetailMapper.toJson(assessmentDetail)}");
      await _databases.createDocument(
        databaseId: databaseId,
        collectionId: assessmentDetailCollectionId,
        documentId: appwrite.ID.unique(),
        data: AssessmentDetailMapper.toJson(assessmentDetail),
      );
      logger.logInfo(
          "added AssessmentDetail success${AssessmentDetailMapper.toJson(assessmentDetail)}");
      return const Right(true);
    } catch (e) {
      logger.logError('failed to add AssessmentDetails ${e.toString()}');
      return const Left('Failed to add AssessmentDetail');
    }
  }

  Future<Either<String, bool>> updateAssessmentDetail(
      String documentId, AssessmentDetail assessmentDetail) async {
    try {
      logger.logInfo(
          'updated AssessmentDetail $documentId, ${AssessmentDetailMapper.toJson(assessmentDetail)}');
      await _databases.updateDocument(
        databaseId: databaseId,
        collectionId: assessmentDetailCollectionId,
        documentId: documentId,
        data: AssessmentDetailMapper.toJson(assessmentDetail),
      );
      return const Right(true);
    } catch (e) {
      logger.logError('failed to update AssessmentDetails ${e.toString()}');
      return const Left('Failed to update AssessmentDetail');
    }
  }

  Future<Either<String, bool>> deleteAssessmentDetail(String documentId) async {
    try {
      await _databases.deleteDocument(
        databaseId: databaseId,
        collectionId: assessmentDetailCollectionId,
        documentId: documentId,
      );
      return const Right(true);
    } catch (e) {
      logger.logError('failed to delete AssessmentDetails ${e.toString()}');
      return const Left('Failed to delete AssessmentDetail');
    }
  }

  Future<Either<String, AssessmentDetail>> getAssessmentDetailById(
      String documentId) async {
    try {
      final result = await _databases.getDocument(
        databaseId: databaseId,
        collectionId: assessmentDetailCollectionId,
        documentId: documentId,
      );
      return Right(AssessmentDetailMapper.fromJson(result.data));
    } catch (e) {
      return const Left('Failed to update AssessmentDetail');
    }
  }
}
