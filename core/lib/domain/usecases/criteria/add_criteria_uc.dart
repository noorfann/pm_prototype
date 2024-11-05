import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class AddCriteriaUC {
  final CriteriaRepository repository;

  AddCriteriaUC(this.repository);

  Future<Either<String, bool>> call(Criteria criteria) async {
    final result = await repository.addCriteria(criteria);
    return result;
  }
}
