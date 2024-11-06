import 'package:core/domain/entities/assessment.dart';
import 'package:core/domain/repositories/assessment_repository.dart';
import 'package:dartz/dartz.dart';

class GetAssessmentListUC {
  final AssessmentRepository _repository;

  GetAssessmentListUC(this._repository);

  Future<Either<String, List<Assessment>>> call() async {
    final result = await _repository.getAssessment();
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
