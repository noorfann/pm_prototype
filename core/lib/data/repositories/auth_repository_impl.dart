import 'package:appwrite/models.dart';
import 'package:core/data/datasources/appwrite_auth.dart';
import 'package:core/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AppwriteAuth _appwriteAuth;

  AuthRepositoryImpl(this._appwriteAuth);

  @override
  Future<Either<String, User>> login(String email, String password) async {
    final result = await _appwriteAuth.login(email, password);

    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String, bool>> logout() {
    return _appwriteAuth.logout();
  }

  @override
  Future<Either<String, User>> register(
      String name, String email, String password) async {
    final result = await _appwriteAuth.register(
        email: email, password: password, name: name);

    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
