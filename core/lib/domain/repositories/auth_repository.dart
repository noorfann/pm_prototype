import 'package:appwrite/models.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<String, User>> login(String email, String password);

  Future<Either<String, User>> register(
      String name, String email, String password);

  Future<Either<String, bool>> logout();
}
