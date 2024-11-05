import 'package:appwrite/appwrite.dart';
import 'package:core/core.dart';
import 'package:core/data/datasources/criteria_remote_ds.dart';
import 'package:core/data/datasources/project_remote_ds.dart';
import 'package:get_it/get_it.dart';
import 'package:pm_prototype/cubit/criteria/criteria_cubit.dart';
import 'package:pm_prototype/cubit/employee/employee_cubit.dart';
import 'package:pm_prototype/cubit/menu/menu_cubit.dart';
import 'package:pm_prototype/cubit/project/project_cubit.dart';
import 'package:pm_prototype/cubit/role/role_cubit.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // Appwrite
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

  // Datasources
  locator.registerLazySingleton<EmployeeRemoteDS>(
      () => EmployeeRemoteDS(locator(), locator()));
  locator.registerLazySingleton<RoleRemoteDS>(
      () => RoleRemoteDS(locator(), locator()));
  locator.registerLazySingleton<CriteriaRemoteDS>(
      () => CriteriaRemoteDS(locator(), locator()));
  locator.registerLazySingleton<ProjectRemoteDS>(
      () => ProjectRemoteDS(locator(), locator()));

  // Repositories
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

  // Usecase - Role
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
}
