import 'package:appwrite/appwrite.dart';
import 'package:core/data/datasources/appwrite_auth.dart';
import 'package:core/data/datasources/dummy_datasource.dart';
import 'package:core/data/repositories/auth_repository_impl.dart';
import 'package:core/data/repositories/employee_repository_impl.dart';
import 'package:core/domain/repositories/auth_repository.dart';
import 'package:core/domain/repositories/employee_repository.dart';
import 'package:core/domain/usecases/employee/add_employee_uc.dart';
import 'package:core/domain/usecases/employee/delete_employee_uc.dart';
import 'package:core/domain/usecases/employee/get_employee_by_id_uc.dart';
import 'package:core/domain/usecases/employee/get_employee_list_uc.dart';
import 'package:core/domain/usecases/employee/update_employee_uc.dart';
import 'package:get_it/get_it.dart';
import 'package:pm_prototype/cubit/employee/add_employee_cubit.dart';
import 'package:pm_prototype/cubit/employee/delete_employee_cubit.dart';
import 'package:pm_prototype/cubit/employee/get_employee_by_id_cubit.dart';
import 'package:pm_prototype/cubit/employee/get_employee_list_cubit.dart';
import 'package:pm_prototype/cubit/employee/update_employee_cubit.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // Appwrite
  locator.registerLazySingleton<Account>(() {
    Client client = Client()
        .setEndpoint("https://cloud.appwrite.io/v1")
        .setProject("6725d7da001cc42f909e");
    Account account = Account(client);
    return account;
  });
  locator.registerLazySingleton<AppwriteAuth>(() => AppwriteAuth(locator()));

  // Datasources
  locator.registerLazySingleton<DummyDatasource>(() => DummyDatasource());

  // Repositories
  locator.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(locator()));

  // Usecase
  locator.registerLazySingleton<GetEmployeeListUC>(
      () => GetEmployeeListUC(locator()));
  locator.registerLazySingleton<GetEmployeeByIdUC>(
      () => GetEmployeeByIdUC(locator()));
  locator.registerLazySingleton<DeleteEmployeeUC>(
      () => DeleteEmployeeUC(locator()));
  locator.registerLazySingleton<AddEmployeeUC>(() => AddEmployeeUC(locator()));
  locator.registerLazySingleton<UpdateEmployeeUC>(
      () => UpdateEmployeeUC(locator()));

  // Employee Cubit
  locator.registerFactory<AddEmployeeCubit>(() => AddEmployeeCubit(locator()));
  locator.registerFactory<DeleteEmployeeCubit>(
      () => DeleteEmployeeCubit(locator()));
  locator.registerFactory<GetEmployeeListCubit>(
      () => GetEmployeeListCubit(locator()));
  locator.registerFactory<GetEmployeeByIdCubit>(
      () => GetEmployeeByIdCubit(locator()));
  locator.registerFactory<UpdateEmployeeCubit>(
      () => UpdateEmployeeCubit(locator()));
}
