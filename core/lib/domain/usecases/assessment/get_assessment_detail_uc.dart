import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetAssessmentDetailUC {
  final AssessmentDetailRepository _repository;

  GetAssessmentDetailUC(this._repository);

  Future<Either<String, List<AssessmentDetail>>> call(
      String assessmentId) async {
    final result = await _repository.getAssessmentDetail(assessmentId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
