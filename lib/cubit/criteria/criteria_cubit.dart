import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:pm_prototype/cubit/criteria/criteria_state.dart';

class CriteriaCubit extends Cubit<CriteriaState> {
  final CriteriaRepository repository;

  CriteriaCubit({required this.repository}) : super(CriteriaState());

  // Get Criterias
  Future<void> getCriterias() async {
    _resetState();
    try {
      emit(state.copyWith(
          status: CriteriaStatus.loading,
          error: CriteriaError.none,
          operation: CriteriaOperation.fetch));
      final result = await repository.getCriteria();
      result.fold(
        (l) => emit(state.copyWith(
          operation: CriteriaOperation.fetch,
          status: CriteriaStatus.failure,
          error: CriteriaError.none,
        )),
        (r) => emit(state.copyWith(
          operation: CriteriaOperation.fetch,
          status: CriteriaStatus.success,
          criterias: r,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
        operation: CriteriaOperation.fetch,
        status: CriteriaStatus.failure,
        error: CriteriaError.none,
      ));
    }
  }

  // Add Criterias
  Future<void> addCriteria(Criteria criteria) async {
    _resetState();
    try {
      emit(state.copyWith(
        status: CriteriaStatus.loading,
        error: CriteriaError.none,
        operation: CriteriaOperation.add,
      ));
      final result = await repository.addCriteria(criteria);
      result.fold(
        (l) => emit(state.copyWith(
          status: CriteriaStatus.failure,
          error: CriteriaError.addError,
          operation: CriteriaOperation.add,
        )),
        (r) => emit(state.copyWith(
          status: CriteriaStatus.success,
          operation: CriteriaOperation.add,
        )),
      );
      getCriterias();
    } catch (e) {
      emit(state.copyWith(
        status: CriteriaStatus.failure,
        error: CriteriaError.addError,
        operation: CriteriaOperation.add,
      ));
    }
  }

  // Delete Criterias
  Future<void> deleteCriteria(String id) async {
    _resetState();
    try {
      emit(state.copyWith(
        status: CriteriaStatus.loading,
        error: CriteriaError.none,
        operation: CriteriaOperation.delete,
      ));
      await repository.deleteCriteria(id);
      final updatedCriterias =
          state.criterias.where((e) => e.id != id).toList();
      emit(state.copyWith(
        status: CriteriaStatus.success,
        criterias: updatedCriterias,
        operation: CriteriaOperation.delete,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CriteriaStatus.failure,
        error: CriteriaError.deleteError,
        operation: CriteriaOperation.delete,
      ));
    }
  }

  // Update Criteria
  Future<void> updateCriteria(String id, Criteria criteria) async {
    _resetState();
    try {
      emit(state.copyWith(
        status: CriteriaStatus.loading,
        error: CriteriaError.none,
        operation: CriteriaOperation.update,
      ));
      await repository.updateCriteria(id, criteria);
      final updatedCriterias = state.criterias.map((e) {
        if (e.id == id) {
          return criteria;
        }
        return e;
      }).toList();
      emit(state.copyWith(
        status: CriteriaStatus.success,
        operation: CriteriaOperation.update,
        criterias: updatedCriterias,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CriteriaStatus.failure,
        error: CriteriaError.updateError,
        operation: CriteriaOperation.update,
      ));
    }
  }

  void _resetState() {
    emit(state.copyWith(
      status: CriteriaStatus.loading,
      error: CriteriaError.none,
      operation: CriteriaOperation.fetch,
    ));
  }
}
