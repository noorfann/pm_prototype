import 'package:core/domain/entities/assessment.dart';
import 'package:core/domain/repositories/assessment_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateAssessmentUC {
  final AssessmentRepository repository;

  UpdateAssessmentUC(this.repository);

  Future<Either<String, bool>> call(
      String documentId, Assessment assessment) async {
    final result = await repository.updateAssessment(documentId, assessment);
    return result;
  }
}
