import 'package:core/domain/repositories/assessment_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteAssessmentUC {
  final AssessmentRepository _repository;

  DeleteAssessmentUC(this._repository);

  Future<Either<String, bool>> call(String documentId) async {
    final result = await _repository.deleteAssessment(documentId);
    return result;
  }
}
