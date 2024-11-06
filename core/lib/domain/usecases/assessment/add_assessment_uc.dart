import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class AddAssessmentUC {
  final AssessmentRepository repository;
  final AssessmentDetailRepository detailRepository;

  AddAssessmentUC(this.repository, this.detailRepository);

  Future<Either<String, bool>> call(
      Assessment assesment, List<AssessmentDetail> assessmentDetail) async {
    final result = await repository.addAssessment(assesment);
    return result.fold(
      (l) {
        // return false when failed to add assessment
        return result.fold((l) => Left(l), (r) => const Right(false));
      },
      (r) async {
        // add assessment detail
        for (var detail in assessmentDetail) {
          // assign master assessment id
          detail = detail.copyWith(assesmentId: r.id);
          await detailRepository.addAssessmentDetail(detail);
        }

        return result.fold((l) => Left(l), (r) => const Right(true));
      },
    );
  }
}
