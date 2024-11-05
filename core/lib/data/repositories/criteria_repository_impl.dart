import 'package:core/data/datasources/criteria_remote_ds.dart';
import 'package:core/domain/entities/criteria.dart';
import 'package:core/domain/repositories/criteria_repository.dart';

import 'package:dartz/dartz.dart';

class CriteriaRepositoryImpl implements CriteriaRepository {
  final CriteriaRemoteDS _datasource;

  CriteriaRepositoryImpl(this._datasource);

  @override
  Future<Either<String, bool>> addCriteria(Criteria criteria) async {
    final result = await _datasource.addCriteria(criteria);

    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, bool>> deleteCriteria(String documentId) async {
    final result = await _datasource.deleteCriteria(documentId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, Criteria>> getCriteriaById(String documentId) async {
    final result = await _datasource.getCriteriaById(documentId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, List<Criteria>>> getCriteria() async {
    final result = await _datasource.getCriterias();
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, bool>> updateCriteria(
      String documentId, Criteria criteria) async {
    final result = await _datasource.updateCriteria(documentId, criteria);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
