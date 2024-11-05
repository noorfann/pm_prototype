import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:pm_prototype/cubit/project/project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  final ProjectRepository repository;

  ProjectCubit({required this.repository}) : super(ProjectState());

  // Get Projects
  Future<void> getProjects() async {
    _resetState();
    try {
      emit(state.copyWith(
          status: ProjectStatus.loading,
          error: ProjectError.none,
          operation: ProjectOperation.fetch));
      final result = await repository.getProjects();
      result.fold(
        (l) => emit(state.copyWith(
          operation: ProjectOperation.fetch,
          status: ProjectStatus.failure,
          error: ProjectError.none,
        )),
        (r) => emit(state.copyWith(
          operation: ProjectOperation.fetch,
          status: ProjectStatus.success,
          projects: r,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
        operation: ProjectOperation.fetch,
        status: ProjectStatus.failure,
        error: ProjectError.none,
      ));
    }
  }

  // Add Projects
  Future<void> addProject(Project project) async {
    _resetState();
    try {
      emit(state.copyWith(
        status: ProjectStatus.loading,
        error: ProjectError.none,
        operation: ProjectOperation.add,
      ));
      await repository.addProject(project);
      emit(state.copyWith(
        status: ProjectStatus.success,
        operation: ProjectOperation.add,
      ));
      getProjects();
    } catch (e) {
      emit(state.copyWith(
        status: ProjectStatus.failure,
        error: ProjectError.addError,
        operation: ProjectOperation.add,
      ));
    }
  }

  // Delete Projects
  Future<void> deleteProject(String id) async {
    _resetState();
    try {
      emit(state.copyWith(
        status: ProjectStatus.loading,
        error: ProjectError.none,
        operation: ProjectOperation.delete,
      ));
      await repository.deleteProject(id);
      final updatedProjects = state.projects.where((e) => e.id != id).toList();
      emit(state.copyWith(
        status: ProjectStatus.success,
        projects: updatedProjects,
        operation: ProjectOperation.delete,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProjectStatus.failure,
        error: ProjectError.deleteError,
        operation: ProjectOperation.delete,
      ));
    }
  }

  // Update Project
  Future<void> updateProject(String id, Project project) async {
    _resetState();
    try {
      emit(state.copyWith(
        status: ProjectStatus.loading,
        error: ProjectError.none,
        operation: ProjectOperation.update,
      ));
      await repository.updateProject(id, project);
      final updatedProjects = state.projects.map((e) {
        if (e.id == id) {
          return project;
        }
        return e;
      }).toList();
      emit(state.copyWith(
        status: ProjectStatus.success,
        operation: ProjectOperation.update,
        projects: updatedProjects,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProjectStatus.failure,
        error: ProjectError.updateError,
        operation: ProjectOperation.update,
      ));
    }
  }

  void _resetState() {
    emit(state.copyWith(
      status: ProjectStatus.initial,
      error: ProjectError.none,
      operation: ProjectOperation.fetch,
    ));
  }
}
