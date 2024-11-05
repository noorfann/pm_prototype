import 'package:core/core.dart';

enum ProjectStatus { initial, loading, success, failure }

enum ProjectOperation { fetch, add, delete, update }

enum ProjectError { none, addError, deleteError, updateError }

class ProjectState {
  final ProjectStatus status;
  final List<Project> projects;
  final ProjectError error;
  final ProjectOperation operation;

  ProjectState({
    this.status = ProjectStatus.initial,
    this.projects = const [],
    this.error = ProjectError.none,
    this.operation = ProjectOperation.add,
  });

  ProjectState copyWith({
    ProjectStatus? status,
    List<Project>? projects,
    ProjectError? error,
    ProjectOperation? operation,
  }) {
    return ProjectState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
      error: error ?? this.error,
      operation: operation ?? this.operation,
    );
  }
}
