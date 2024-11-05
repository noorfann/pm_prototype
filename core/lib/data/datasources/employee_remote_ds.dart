import 'package:appwrite/appwrite.dart';
import 'package:core/core.dart';
import 'package:core/utils/app_logger.dart';
import 'package:dartz/dartz.dart';

class EmployeeRemoteDS {
  final Databases _databases;
  final Account _account;
  EmployeeRemoteDS(this._databases, this._account) {
    createAnon();
  }

  createAnon() async {
    try {
      await _account.get();
    } catch (_) {
      await _account.createAnonymousSession();
    }
  }

  Future<Either<String, List<Employee>>> getEmployees() async {
    try {
      final response = await _databases.listDocuments(
          databaseId: databaseId,
          collectionId: employeeCollectionId,
          queries: []);
      final result = response.documents
          .map((e) => EmployeeMapper.fromJson(e.data))
          .toList();

      logger.logInfo(result.toString());
      return Right(result);
    } catch (e) {
      logger.logError('failed to get employees ${e.toString()}');
      return const Left('Failed to get employees');
    }
  }

  Future<Either<String, bool>> addEmployee(Employee employee) async {
    try {
      await _databases.createDocument(
        databaseId: databaseId,
        collectionId: employeeCollectionId,
        documentId: ID.unique(),
        data: EmployeeMapper.toJson(employee),
      );
      return const Right(true);
    } catch (e) {
      logger.logError('failed to add employees ${e.toString()}');
      return const Left('Failed to add employee');
    }
  }

  Future<Either<String, bool>> updateEmployee(
      String documentId, Employee employee) async {
    try {
      logger.logInfo(
          'updated employee $documentId, ${EmployeeMapper.toJson(employee)}');
      await _databases.updateDocument(
        databaseId: databaseId,
        collectionId: employeeCollectionId,
        documentId: documentId,
        data: EmployeeMapper.toJson(employee),
      );
      return const Right(true);
    } catch (e) {
      logger.logError('failed to update employees ${e.toString()}');
      return const Left('Failed to update employee');
    }
  }

  Future<Either<String, bool>> deleteEmployee(String documentId) async {
    try {
      await _databases.deleteDocument(
        databaseId: databaseId,
        collectionId: employeeCollectionId,
        documentId: documentId,
      );
      return const Right(true);
    } catch (e) {
      logger.logError('failed to delete employees ${e.toString()}');
      return const Left('Failed to delete employee');
    }
  }

  Future<Either<String, Employee>> getEmployeeById(String documentId) async {
    try {
      final result = await _databases.getDocument(
        databaseId: databaseId,
        collectionId: employeeCollectionId,
        documentId: documentId,
      );
      return Right(EmployeeMapper.fromJson(result.data));
    } catch (e) {
      return const Left('Failed to update employee');
    }
  }
}
