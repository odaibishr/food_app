import 'package:carea_app/core/errors/failure.dart';
import 'package:carea_app/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/entities/user.dart';
import '../repos/auth_repo.dart';

class CurrentUser extends UseCase<User, NoParams> {
  final AuthRepo authRepo;
  CurrentUser(this.authRepo);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepo.currentUser();
  }
}
