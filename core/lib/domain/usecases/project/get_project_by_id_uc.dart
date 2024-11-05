import 'package:core/domain/entities/project.dart';
import 'package:core/domain/repositories/project_repository.dart';
import 'package:dartz/dartz.dart';

class GetProjectByIdUC {
  final ProjectRepository _repository;

  GetProjectByIdUC(this._repository);

  Future<Either<String, Project>> call(String documentId) async {
    final result = await _repository.getProjectById(documentId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
