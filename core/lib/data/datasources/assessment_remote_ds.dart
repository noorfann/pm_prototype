import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:core/data/mapper/assessment_mapper.dart';
import 'package:core/domain/entities/assessment.dart';
import 'package:core/utils/app_logger.dart';
import 'package:core/utils/constants.dart';
import 'package:dartz/dartz.dart';

class AssessmentRemoteDS {
  final appwrite.Databases _databases;
  final appwrite.Account _account;
  AssessmentRemoteDS(this._databases, this._account) {
    createAnon();
  }

  createAnon() async {
    try {
      await _account.get();
    } catch (_) {
      await _account.createAnonymousSession();
    }
  }

  Future<Either<String, List<Assessment>>> getAssessments() async {
    try {
      final response = await _databases.listDocuments(
          databaseId: databaseId, collectionId: assessmentCollectionId);
      final result = response.documents
          .map((e) => AssessmentMapper.fromJson(e.data))
          .toList();

      logger.logInfo(result.toString());
      return Right(result);
    } catch (e) {
      logger.logError('failed to get Assessments ${e.toString()}');
      return const Left('Failed to get Assessments');
    }
  }

  Future<Either<String, Assessment>> addAssessment(
      Assessment assessment) async {
    try {
      logger.logInfo("added Assessment ${AssessmentMapper.toJson(assessment)}");
      final result = await _databases.createDocument(
        databaseId: databaseId,
        collectionId: assessmentCollectionId,
        documentId: appwrite.ID.unique(),
        data: AssessmentMapper.toJson(assessment),
      );
      logger.logInfo(
          "added Assessment success${AssessmentMapper.toJson(assessment)}");
      final assessmentResp = AssessmentMapper.fromJson(result.data);
      return Right(assessmentResp);
    } catch (e) {
      logger.logError('failed to add Assessments ${e.toString()}');
      return const Left('Failed to add Assessment');
    }
  }

  Future<Either<String, bool>> updateAssessment(
      String documentId, Assessment assessment) async {
    try {
      logger.logInfo(
          'updated Assessment $documentId, ${AssessmentMapper.toJson(assessment)}');
      await _databases.updateDocument(
        databaseId: databaseId,
        collectionId: assessmentCollectionId,
        documentId: documentId,
        data: AssessmentMapper.toJson(assessment),
      );
      return const Right(true);
    } catch (e) {
      logger.logError('failed to update Assessments ${e.toString()}');
      return const Left('Failed to update Assessment');
    }
  }

  Future<Either<String, bool>> deleteAssessment(String documentId) async {
    try {
      await _databases.deleteDocument(
        databaseId: databaseId,
        collectionId: assessmentCollectionId,
        documentId: documentId,
      );
      return const Right(true);
    } catch (e) {
      logger.logError('failed to delete Assessments ${e.toString()}');
      return const Left('Failed to delete Assessment');
    }
  }

  Future<Either<String, Assessment>> getAssessmentById(
      String documentId) async {
    try {
      final result = await _databases.getDocument(
        databaseId: databaseId,
        collectionId: assessmentCollectionId,
        documentId: documentId,
      );
      return Right(AssessmentMapper.fromJson(result.data));
    } catch (e) {
      return const Left('Failed to update assessment');
    }
  }
}
