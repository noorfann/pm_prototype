import 'package:core/domain/entities/project.dart';
import 'package:core/domain/repositories/project_repository.dart';
import 'package:dartz/dartz.dart';

class GetProjectListUC {
  final ProjectRepository _repository;

  GetProjectListUC(this._repository);

  Future<Either<String, List<Project>>> call() async {
    final result = await _repository.getProjects();
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
