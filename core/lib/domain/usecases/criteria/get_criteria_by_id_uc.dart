import 'package:core/domain/entities/criteria.dart';
import 'package:core/domain/repositories/criteria_repository.dart';
import 'package:dartz/dartz.dart';

class GetCriteriaByIdUC {
  final CriteriaRepository _repository;

  GetCriteriaByIdUC(this._repository);

  Future<Either<String, Criteria>> call(String documentId) async {
    final result = await _repository.getCriteriaById(documentId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
