import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'assessment.freezed.dart';

@freezed
class Assessment with _$Assessment {
  const factory Assessment(
      {required String id,
      required String assessor,
      required Employee employee,
      required List<AssessmentDetail> details}) = _Assessment;
}
