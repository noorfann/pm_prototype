import 'package:core/domain/repositories/criteria_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteCriteriaUC {
  final CriteriaRepository _repository;

  DeleteCriteriaUC(this._repository);

  Future<Either<String, bool>> call(String documentId) async {
    final result = await _repository.deleteCriteria(documentId);
    return result;
  }
}
