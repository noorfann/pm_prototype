import 'package:core/domain/entities/criteria.dart';
import 'package:dartz/dartz.dart';

abstract class CriteriaRepository {
  Future<Either<String, List<Criteria>>> getCriteria();
  Future<Either<String, Criteria>> getCriteriaById(String documentId);

  Future<Either<String, bool>> addCriteria(Criteria criteria);
  Future<Either<String, bool>> updateCriteria(
      String documentId, Criteria criteria);
  Future<Either<String, bool>> deleteCriteria(String documentId);
}
