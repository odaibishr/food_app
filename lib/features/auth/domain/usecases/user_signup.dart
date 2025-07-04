import 'package:carea_app/core/errors/failure.dart';
import 'package:carea_app/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/entities/user.dart';
import '../repos/auth_repo.dart';

class UserSignup extends UseCase<User, UserSignupParams> {
  final AuthRepo authRepo;
  UserSignup(this.authRepo);

  @override
  Future<Either<Failure, User>> call(UserSignupParams params) async {
    return await authRepo.signUpWithEmailPassword(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}

class UserSignupParams {
  final String email;
  final String password;
  final String name;

  UserSignupParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
