import 'package:core/domain/entities/criteria.dart';
import 'package:core/domain/repositories/criteria_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateCriteriaUC {
  final CriteriaRepository repository;

  UpdateCriteriaUC(this.repository);

  Future<Either<String, bool>> call(
      String documentId, Criteria criteria) async {
    final result = await repository.updateCriteria(documentId, criteria);
    return result;
  }
}
