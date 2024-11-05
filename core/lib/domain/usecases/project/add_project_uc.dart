import 'package:core/domain/entities/project.dart';
import 'package:core/domain/repositories/project_repository.dart';
import 'package:dartz/dartz.dart';

class AddProjectUC {
  final ProjectRepository repository;

  AddProjectUC(this.repository);

  Future<Either<String, bool>> call(Project project) async {
    final result = await repository.addProject(project);
    return result;
  }
}
