import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:core/data/mapper/project_mapper.dart';
import 'package:core/domain/entities/project.dart';
import 'package:core/utils/app_logger.dart';
import 'package:core/utils/constants.dart';
import 'package:dartz/dartz.dart';

class ProjectRemoteDS {
  final appwrite.Databases _databases;
  final appwrite.Account _account;
  ProjectRemoteDS(this._databases, this._account) {
    createAnon();
  }

  createAnon() async {
    try {
      await _account.get();
    } catch (_) {
      await _account.createAnonymousSession();
    }
  }

  Future<Either<String, List<Project>>> getProjects() async {
    try {
      final response = await _databases.listDocuments(
          databaseId: databaseId, collectionId: projectCollectionId);
      final result = response.documents
          .map((e) => ProjectMapper.fromJson(e.data))
          .toList();

      logger.logInfo(result.toString());
      return Right(result);
    } catch (e) {
      logger.logError('failed to get Projects ${e.toString()}');
      return const Left('Failed to get Projects');
    }
  }

  Future<Either<String, bool>> addProject(Project project) async {
    try {
      await _databases.createDocument(
        databaseId: databaseId,
        collectionId: projectCollectionId,
        documentId: appwrite.ID.unique(),
        data: ProjectMapper.toJson(project),
      );
      return const Right(true);
    } catch (e) {
      logger.logError('failed to add Projects ${e.toString()}');
      return const Left('Failed to add Project');
    }
  }

  Future<Either<String, bool>> updateProject(
      String documentId, Project project) async {
    try {
      logger.logInfo(
          'updated Project $documentId, ${ProjectMapper.toJson(project)}');
      await _databases.updateDocument(
        databaseId: databaseId,
        collectionId: projectCollectionId,
        documentId: documentId,
        data: ProjectMapper.toJson(project),
      );
      return const Right(true);
    } catch (e) {
      logger.logError('failed to update Projects ${e.toString()}');
      return const Left('Failed to update Project');
    }
  }

  Future<Either<String, bool>> deleteProject(String documentId) async {
    try {
      await _databases.deleteDocument(
        databaseId: databaseId,
        collectionId: projectCollectionId,
        documentId: documentId,
      );
      return const Right(true);
    } catch (e) {
      logger.logError('failed to delete Projects ${e.toString()}');
      return const Left('Failed to delete Project');
    }
  }

  Future<Either<String, Project>> getProjectById(String documentId) async {
    try {
      final result = await _databases.getDocument(
        databaseId: databaseId,
        collectionId: projectCollectionId,
        documentId: documentId,
      );
      return Right(ProjectMapper.fromJson(result.data));
    } catch (e) {
      return const Left('Failed to update employee');
    }
  }
}
