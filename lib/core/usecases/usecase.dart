import 'package:carea_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}