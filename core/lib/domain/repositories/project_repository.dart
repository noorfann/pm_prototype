import 'package:core/domain/entities/project.dart';
import 'package:dartz/dartz.dart';

abstract class ProjectRepository {
  Future<Either<String, List<Project>>> getProjects();
  Future<Either<String, Project>> getProjectById(String documentId);

  Future<Either<String, bool>> addProject(Project project);
  Future<Either<String, bool>> updateProject(
      String documentId, Project project);
  Future<Either<String, bool>> deleteProject(String documentId);
}
