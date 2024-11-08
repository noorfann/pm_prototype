// profile_matching_state.dart
import 'package:core/core.dart';

abstract class ProfileMatchingState {}

class ProfileMatchingInitial extends ProfileMatchingState {}

class ProfileMatchingLoading extends ProfileMatchingState {}

class ProfileMatchingSuccess extends ProfileMatchingState {
  final List<EmployeeResult> results;
  ProfileMatchingSuccess(this.results);
}

class ProfileMatchingError extends ProfileMatchingState {
  final String message;
  ProfileMatchingError(this.message);
}

class EmployeeResult {
  final Employee employee;
  final double totalScore;
  final Map<String, double> gapValues;
  final double coreFactor;
  final double secondaryFactor;

  EmployeeResult({
    required this.employee,
    required this.totalScore,
    required this.gapValues,
    required this.coreFactor,
    required this.secondaryFactor,
  });
}
