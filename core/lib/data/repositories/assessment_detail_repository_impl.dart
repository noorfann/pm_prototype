import 'package:core/data/datasources/assessment_detail_remote_ds.dart';
import 'package:core/domain/entities/assessment_detail.dart';
import 'package:core/domain/repositories/assessment_detail_repository.dart';

import 'package:dartz/dartz.dart';

class AssessmentDetailRepositoryImpl implements AssessmentDetailRepository {
  final AssessmentDetailRemoteDS _datasource;

  AssessmentDetailRepositoryImpl(this._datasource);

  @override
  Future<Either<String, bool>> addAssessmentDetail(
      AssessmentDetail assessmentDetail) async {
    final result = await _datasource.addAssessmentDetail(assessmentDetail);

    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, bool>> deleteAssessmentDetail(String documentId) async {
    final result = await _datasource.deleteAssessmentDetail(documentId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, AssessmentDetail>> getAssessmentDetailById(
      String documentId) async {
    final result = await _datasource.getAssessmentDetailById(documentId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, List<AssessmentDetail>>> getAssessmentDetail(
      String assesmentId) async {
    final result = await _datasource.getAssessmentDetails(assesmentId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, bool>> updateAssessmentDetail(
      String documentId, AssessmentDetail assessmentDetail) async {
    final result =
        await _datasource.updateAssessmentDetail(documentId, assessmentDetail);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
