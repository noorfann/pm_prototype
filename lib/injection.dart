import 'package:appwrite/appwrite.dart';
import 'package:core/core.dart';
import 'package:core/data/datasources/assessment_detail_remote_ds.dart';
import 'package:get_it/get_it.dart';
import 'package:pm_prototype/cubit/assessment/assessment_cubit.dart';
import 'package:pm_prototype/cubit/criteria/criteria_cubit.dart';
import 'package:pm_prototype/cubit/employee/employee_cubit.dart';
import 'package:pm_prototype/cubit/menu/menu_cubit.dart';
import 'package:pm_prototype/cubit/profile_matching/profile_matching_cubit.dart';
import 'package:pm_prototype/cubit/project/project_cubit.dart';
import 'package:pm_prototype/cubit/role/role_cubit.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // Appwrite
  _appwrite();

  // Datasources
  _dataSource();

  // Repositories
  _repositories();

  // Usecases
  _usecases();

  // Cubit
  _cubit();
}

void _cubit() {
  // Menu Cubit
  locator.registerFactory<MenuCubit>(() => MenuCubit());
  // Employee Cubit
  locator.registerFactory<EmployeeCubit>(
      () => EmployeeCubit(repository: locator()));
  // Role cubit
  locator.registerFactory<RoleCubit>(() => RoleCubit(repository: locator()));
  // Criteria cubit
  locator.registerFactory<CriteriaCubit>(
      () => CriteriaCubit(repository: locator()));
  // Project cubit
  locator
      .registerFactory<ProjectCubit>(() => ProjectCubit(repository: locator()));
  // Assessment cubit
  locator.registerFactory<AssessmentCubit>(() => AssessmentCubit(
      repository: locator(),
      detailRepository: locator(),
      addAssessmentUC: locator(),
      getAssessmentUC: locator(),
      getAssessmentDetailUC: locator()));
  // Profile Matching cubit
  locator.registerFactory<ProfileMatchingCubit>(
      () => ProfileMatchingCubit(locator()));
}

void _usecases() {
  locator.registerLazySingleton<GetRoleListUC>(() => GetRoleListUC(locator()));
  locator.registerLazySingleton<GetRoleByIdUC>(() => GetRoleByIdUC(locator()));
  locator.registerLazySingleton<DeleteRoleUC>(() => DeleteRoleUC(locator()));
  locator.registerLazySingleton<AddRoleUC>(() => AddRoleUC(locator()));
  locator.registerLazySingleton<UpdateRoleUC>(() => UpdateRoleUC(locator()));
  // Usecase - Employee
  locator.registerLazySingleton<GetEmployeeListUC>(
      () => GetEmployeeListUC(locator()));
  locator.registerLazySingleton<GetEmployeeByIdUC>(
      () => GetEmployeeByIdUC(locator()));
  locator.registerLazySingleton<DeleteEmployeeUC>(
      () => DeleteEmployeeUC(locator()));
  locator.registerLazySingleton<AddEmployeeUC>(() => AddEmployeeUC(locator()));
  locator.registerLazySingleton<UpdateEmployeeUC>(
      () => UpdateEmployeeUC(locator()));
  // Usecase - Criteria
  locator.registerLazySingleton<GetCriteriaListUC>(
      () => GetCriteriaListUC(locator()));
  locator.registerLazySingleton<GetCriteriaByIdUC>(
      () => GetCriteriaByIdUC(locator()));
  locator.registerLazySingleton<DeleteCriteriaUC>(
      () => DeleteCriteriaUC(locator()));
  locator.registerLazySingleton<AddCriteriaUC>(() => AddCriteriaUC(locator()));
  locator.registerLazySingleton<UpdateCriteriaUC>(
      () => UpdateCriteriaUC(locator()));
  // Usecase - Project
  locator.registerLazySingleton<GetProjectListUC>(
      () => GetProjectListUC(locator()));
  locator.registerLazySingleton<GetProjectByIdUC>(
      () => GetProjectByIdUC(locator()));
  locator
      .registerLazySingleton<DeleteProjectUC>(() => DeleteProjectUC(locator()));
  locator.registerLazySingleton<AddProjectUC>(() => AddProjectUC(locator()));
  locator
      .registerLazySingleton<UpdateProjectUC>(() => UpdateProjectUC(locator()));
  // Usecase Assessment
  locator.registerLazySingleton<GetAssessmentListUC>(
      () => GetAssessmentListUC(locator()));
  locator.registerLazySingleton<GetAssessmentDetailUC>(
      () => GetAssessmentDetailUC(locator()));
  locator.registerLazySingleton<DeleteAssessmentUC>(
      () => DeleteAssessmentUC(locator()));
  locator.registerLazySingleton<AddAssessmentUC>(
      () => AddAssessmentUC(locator(), locator()));
  locator.registerLazySingleton<UpdateAssessmentUC>(
      () => UpdateAssessmentUC(locator()));
}

void _repositories() {
  locator.registerLazySingleton<RoleRepository>(
    () => RoleRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(locator()));
  locator.registerLazySingleton<CriteriaRepository>(
      () => CriteriaRepositoryImpl(locator()));
  locator.registerLazySingleton<ProjectRepository>(
      () => ProjectRepositoryImpl(locator()));
  locator.registerLazySingleton<AssessmentRepository>(
      () => AssessmentRepositoryImpl(locator()));
  locator.registerLazySingleton<AssessmentDetailRepository>(
      () => AssessmentDetailRepositoryImpl(locator()));
}

void _dataSource() {
  locator.registerLazySingleton<EmployeeRemoteDS>(
      () => EmployeeRemoteDS(locator(), locator()));
  locator.registerLazySingleton<RoleRemoteDS>(
      () => RoleRemoteDS(locator(), locator()));
  locator.registerLazySingleton<CriteriaRemoteDS>(
      () => CriteriaRemoteDS(locator(), locator()));
  locator.registerLazySingleton<ProjectRemoteDS>(
      () => ProjectRemoteDS(locator(), locator()));
  locator.registerLazySingleton<AssessmentRemoteDS>(
      () => AssessmentRemoteDS(locator(), locator()));
  locator.registerLazySingleton<AssessmentDetailRemoteDS>(
      () => AssessmentDetailRemoteDS(locator(), locator()));
}

void _appwrite() {
  locator.registerLazySingleton<Client>(() {
    Client client = Client()
        .setEndpoint("https://cloud.appwrite.io/v1")
        .setProject("6725d7da001cc42f909e");
    return client;
  });
  locator.registerLazySingleton<Account>(() {
    Account account = Account(locator());
    return account;
  });
  locator.registerLazySingleton<AppwriteAuth>(() => AppwriteAuth(locator()));

  locator.registerLazySingleton<Databases>(() {
    Databases databases = Databases(locator());
    return databases;
  });
}
