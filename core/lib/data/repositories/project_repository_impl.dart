import 'package:core/data/datasources/project_remote_ds.dart';
import 'package:core/domain/entities/project.dart';
import 'package:core/domain/repositories/project_repository.dart';

import 'package:dartz/dartz.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDS _datasource;

  ProjectRepositoryImpl(this._datasource);

  @override
  Future<Either<String, bool>> addProject(Project project) async {
    final result = await _datasource.addProject(project);

    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, bool>> deleteProject(String documentId) async {
    final result = await _datasource.deleteProject(documentId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, Project>> getProjectById(String documentId) async {
    final result = await _datasource.getProjectById(documentId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, List<Project>>> getProjects() async {
    final result = await _datasource.getProjects();
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, bool>> updateProject(
      String documentId, Project project) async {
    final result = await _datasource.updateProject(documentId, project);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
