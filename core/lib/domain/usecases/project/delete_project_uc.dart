import 'package:core/domain/repositories/project_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteProjectUC {
  final ProjectRepository _repository;

  DeleteProjectUC(this._repository);

  Future<Either<String, bool>> call(String documentId) async {
    final result = await _repository.deleteProject(documentId);
    return result;
  }
}
