import 'package:core/domain/entities/assessment_detail.dart';
import 'package:dartz/dartz.dart';

abstract class AssessmentDetailRepository {
  Future<Either<String, List<AssessmentDetail>>> getAssessmentDetail(
      String assessmentId);
  Future<Either<String, AssessmentDetail>> getAssessmentDetailById(
      String documentId);

  Future<Either<String, bool>> addAssessmentDetail(
      AssessmentDetail assessmentDetail);
  Future<Either<String, bool>> updateAssessmentDetail(
      String documentId, AssessmentDetail assessmentDetail);
  Future<Either<String, bool>> deleteAssessmentDetail(String documentId);
}
