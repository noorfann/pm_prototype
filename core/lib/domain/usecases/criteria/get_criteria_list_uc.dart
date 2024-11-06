import 'package:core/domain/entities/criteria.dart';
import 'package:core/domain/repositories/criteria_repository.dart';
import 'package:dartz/dartz.dart';

class GetCriteriaListUC {
  final CriteriaRepository _repository;

  GetCriteriaListUC(this._repository);

  Future<Either<String, List<Criteria>>> call() async {
    final result = await _repository.getCriteria();
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
