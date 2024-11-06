import 'package:core/domain/entities/project.dart';
import 'package:core/domain/repositories/project_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateProjectUC {
  final ProjectRepository repository;

  UpdateProjectUC(this.repository);

  Future<Either<String, bool>> call(String documentId, Project project) async {
    final result = await repository.updateProject(documentId, project);
    return result;
  }
}
