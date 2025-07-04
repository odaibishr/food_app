import 'package:carea_app/core/entities/user.dart';
import 'package:carea_app/core/errors/exceptions.dart';
import 'package:carea_app/core/errors/failure.dart';
import 'package:carea_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:carea_app/features/auth/data/models/user_model.dart';
import 'package:carea_app/features/auth/domain/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/connection/network_info.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo connectionInfo;

  AuthRepoImpl(this.authRemoteDataSource, this.connectionInfo);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionInfo.isConnected!)) {
        final session = authRemoteDataSource.currentUserSession;

        if (session == null) {
          return left(Failure(errorMessage: 'User not logged in!'));
        }

        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? '',
            name: '',
          ),
        );
      }
      final user = await authRemoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure(errorMessage: 'User not logged in!'));
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      if (!await connectionInfo.isConnected!) {
        return left(Failure(errorMessage: 'No internet connection'));
      }
      final user = await authRemoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (!await connectionInfo.isConnected!) {
        return left(Failure(errorMessage: 'No internet connection'));
      }
      final user = await authRemoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }
}
