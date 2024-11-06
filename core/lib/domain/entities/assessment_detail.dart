import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'assessment_detail.freezed.dart';

@freezed
class AssessmentDetail with _$AssessmentDetail {
  const factory AssessmentDetail({
    required String id,
    required double score,
    required String assesmentId,
    required Criteria criteria,
  }) = _AssessmentDetail;
}
