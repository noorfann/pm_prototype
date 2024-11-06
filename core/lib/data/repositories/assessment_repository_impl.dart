import 'package:core/data/datasources/assessment_remote_ds.dart';
import 'package:core/domain/entities/assessment.dart';
import 'package:core/domain/repositories/assessment_repository.dart';

import 'package:dartz/dartz.dart';

class AssessmentRepositoryImpl implements AssessmentRepository {
  final AssessmentRemoteDS _datasource;

  AssessmentRepositoryImpl(this._datasource);

  @override
  Future<Either<String, Assessment>> addAssessment(
      Assessment assessment) async {
    final result = await _datasource.addAssessment(assessment);

    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, bool>> deleteAssessment(String documentId) async {
    final result = await _datasource.deleteAssessment(documentId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, Assessment>> getAssessmentById(
      String documentId) async {
    final result = await _datasource.getAssessmentById(documentId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, List<Assessment>>> getAssessment() async {
    final result = await _datasource.getAssessments();
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, bool>> updateAssessment(
      String documentId, Assessment assessment) async {
    final result = await _datasource.updateAssessment(documentId, assessment);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
