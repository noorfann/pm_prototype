import 'package:core/core.dart';

enum AssessmentStatus { loading, success, failure }

enum AssessmentOperation { fetch, fetchDetail, add, delete, update }

enum AssessmentError { none, addError, deleteError, updateError }

class AssessmentState {
  final AssessmentStatus status;
  final List<Assessment> assessment;
  final List<AssessmentDetail> assessmentDetail;
  final AssessmentError error;
  final AssessmentOperation operation;

  AssessmentState({
    this.status = AssessmentStatus.loading,
    this.assessment = const [],
    this.assessmentDetail = const [],
    this.error = AssessmentError.none,
    this.operation = AssessmentOperation.add,
  });

  AssessmentState copyWith({
    AssessmentStatus? status,
    List<Assessment>? assessment,
    List<AssessmentDetail>? assessmentDetail,
    AssessmentError? error,
    AssessmentOperation? operation,
  }) {
    return AssessmentState(
      status: status ?? this.status,
      assessment: assessment ?? this.assessment,
      assessmentDetail: assessmentDetail ?? this.assessmentDetail,
      error: error ?? this.error,
      operation: operation ?? this.operation,
    );
  }
}
