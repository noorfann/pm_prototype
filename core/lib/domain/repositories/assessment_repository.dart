import 'package:core/domain/entities/assessment.dart';
import 'package:dartz/dartz.dart';

abstract class AssessmentRepository {
  Future<Either<String, List<Assessment>>> getAssessment();
  Future<Either<String, Assessment>> getAssessmentById(String documentId);

  Future<Either<String, Assessment>> addAssessment(Assessment assessment);
  Future<Either<String, bool>> updateAssessment(
      String documentId, Assessment assessment);
  Future<Either<String, bool>> deleteAssessment(String documentId);
}
