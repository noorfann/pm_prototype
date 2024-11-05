import 'package:core/core.dart';

enum CriteriaStatus { initial, loading, success, failure }

enum CriteriaOperation { fetch, add, delete, update }

enum CriteriaError { none, addError, deleteError, updateError }

class CriteriaState {
  final CriteriaStatus status;
  final List<Criteria> criterias;
  final CriteriaError error;
  final CriteriaOperation operation;

  CriteriaState({
    this.status = CriteriaStatus.initial,
    this.criterias = const [],
    this.error = CriteriaError.none,
    this.operation = CriteriaOperation.add,
  });

  CriteriaState copyWith({
    CriteriaStatus? status,
    List<Criteria>? criterias,
    CriteriaError? error,
    CriteriaOperation? operation,
  }) {
    return CriteriaState(
      status: status ?? this.status,
      criterias: criterias ?? this.criterias,
      error: error ?? this.error,
      operation: operation ?? this.operation,
    );
  }
}
