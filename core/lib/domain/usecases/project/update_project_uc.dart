import 'package:core/domain/entities/project.dart';
import 'package:core/domain/repositories/project_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateProjectUC {
  final ProjectRepository repository;

  UpdateProjectUC(this.repository);

  Future<Either<String, bool>> call(String documentId, Project Project) async {
    final result = await repository.updateProject(documentId, Project);
    return result;
  }
}
