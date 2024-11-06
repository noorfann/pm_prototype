import 'package:bloc/bloc.dart';
import 'package:core/core.dart';

import 'assessment_state.dart';

class AssessmentCubit extends Cubit<AssessmentState> {
  final AssessmentRepository repository;
  final AssessmentDetailRepository detailRepository;
  final AddAssessmentUC addAssessmentUC;
  final GetAssessmentListUC getAssessmentUC;
  final GetAssessmentDetailUC getAssessmentDetailUC;

  AssessmentCubit(
      {required this.repository,
      required this.detailRepository,
      required this.addAssessmentUC,
      required this.getAssessmentUC,
      required this.getAssessmentDetailUC})
      : super(AssessmentState());

  // Get Assessments
  Future<void> getAssessments() async {
    _resetState();
    try {
      emit(state.copyWith(
          status: AssessmentStatus.loading,
          error: AssessmentError.none,
          operation: AssessmentOperation.fetch));
      final result = await getAssessmentUC.call();
      result.fold(
        (l) => emit(state.copyWith(
          operation: AssessmentOperation.fetch,
          status: AssessmentStatus.failure,
          error: AssessmentError.none,
        )),
        (r) => emit(state.copyWith(
          operation: AssessmentOperation.fetch,
          status: AssessmentStatus.success,
          assessment: r,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
        operation: AssessmentOperation.fetch,
        status: AssessmentStatus.failure,
        error: AssessmentError.none,
      ));
    }
  }

  // Get Assessments Detail
  Future<void> getAssessmentsDetail(String assessmentId) async {
    _resetState();
    try {
      emit(state.copyWith(
          status: AssessmentStatus.loading,
          error: AssessmentError.none,
          operation: AssessmentOperation.fetchDetail));
      final result = await getAssessmentDetailUC.call(assessmentId);
      result.fold(
        (l) => emit(state.copyWith(
          operation: AssessmentOperation.fetchDetail,
          status: AssessmentStatus.failure,
          error: AssessmentError.none,
        )),
        (r) => emit(state.copyWith(
          operation: AssessmentOperation.fetchDetail,
          status: AssessmentStatus.success,
          assessmentDetail: r,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
        operation: AssessmentOperation.fetchDetail,
        status: AssessmentStatus.failure,
        error: AssessmentError.none,
      ));
    }
  }

  // Add Assessments
  Future<void> addAssessment(
      Assessment assessment, List<AssessmentDetail> assessmentDetail) async {
    _resetState();
    try {
      emit(state.copyWith(
        status: AssessmentStatus.loading,
        error: AssessmentError.none,
        operation: AssessmentOperation.add,
      ));
      final result = await addAssessmentUC.call(assessment, assessmentDetail);
      result.fold(
        (l) => emit(state.copyWith(
          status: AssessmentStatus.failure,
          error: AssessmentError.addError,
          operation: AssessmentOperation.add,
        )),
        (r) => emit(state.copyWith(
          status: AssessmentStatus.success,
          operation: AssessmentOperation.add,
        )),
      );
      getAssessments();
    } catch (e) {
      emit(state.copyWith(
        status: AssessmentStatus.failure,
        error: AssessmentError.addError,
        operation: AssessmentOperation.add,
      ));
    }
  }

  // Delete Assessments
  Future<void> deleteAssessment(String id) async {
    _resetState();
    try {
      emit(state.copyWith(
        status: AssessmentStatus.loading,
        error: AssessmentError.none,
        operation: AssessmentOperation.delete,
      ));
      await repository.deleteAssessment(id);
      final updatedAssessments =
          state.assessment.where((e) => e.id != id).toList();
      emit(state.copyWith(
        status: AssessmentStatus.success,
        assessment: updatedAssessments,
        operation: AssessmentOperation.delete,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AssessmentStatus.failure,
        error: AssessmentError.deleteError,
        operation: AssessmentOperation.delete,
      ));
    }
  }

  // Update Assessment
  Future<void> updateAssessment(String id, Assessment assessment) async {
    _resetState();
    try {
      emit(state.copyWith(
        status: AssessmentStatus.loading,
        error: AssessmentError.none,
        operation: AssessmentOperation.update,
      ));
      await repository.updateAssessment(id, assessment);
      final updatedAssessments = state.assessment.map((e) {
        if (e.id == id) {
          return assessment;
        }
        return e;
      }).toList();
      emit(state.copyWith(
        status: AssessmentStatus.success,
        operation: AssessmentOperation.update,
        assessment: updatedAssessments,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AssessmentStatus.failure,
        error: AssessmentError.updateError,
        operation: AssessmentOperation.update,
      ));
    }
  }

  void _resetState() {
    emit(state.copyWith(
      status: AssessmentStatus.initial,
      error: AssessmentError.none,
      operation: AssessmentOperation.fetch,
    ));
  }
}
