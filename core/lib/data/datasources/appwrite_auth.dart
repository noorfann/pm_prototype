import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:dartz/dartz.dart';

class AppwriteAuth {
  final Account account;

  AppwriteAuth(this.account);
  Future<Either<String, User>> login(String email, String password) async {
    try {
      await account.createEmailPasswordSession(
          email: email, password: password);
      final user = await account.get();
      return Right(user);
    } catch (e) {
      return const Left('Problem occurred, failed to login');
    }
  }

  Future<Either<String, User>> register(
      {required String email,
      required String password,
      required String name}) async {
    try {
      await account.create(
          userId: ID.unique(), email: email, password: password, name: name);
      final loginResult = await login(email, password);
      return loginResult;
    } catch (e) {
      return const Left('Problem occurred, failed to register');
    }
  }

  Future<Either<String, bool>> logout() async {
    try {
      await account.deleteSession(sessionId: 'current');
      return const Right(true);
    } catch (e) {
      return const Left('Failed to logout');
    }
  }
}
