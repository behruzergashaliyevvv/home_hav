import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:uyishi/core/common/exceptions/custom_exception.dart';

import 'package:uyishi/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:uyishi/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl({required this.authRemoteDataSource});
  @override
  Future<bool> login({
    required String phoneNumber,
    required String password,
  }) async {
    log("data in repo impl: $phoneNumber, $password");

    return await authRemoteDataSource.login(
      phoneNumber: phoneNumber,
      password: password,
    );
  }

  @override
  Future<Either<dynamic, bool>> register({
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    try {
      final bool = await authRemoteDataSource.register(
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );
      return Right(bool!);
    } on ServerException catch (e) {
      return Left(e.errorMessage);
    }
  }
}
