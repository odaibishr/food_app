import 'package:carea_app/core/errors/failure.dart';
import 'package:carea_app/core/usecases/usecase.dart';
import 'package:carea_app/features/food/domain/entities/tag.dart';
import 'package:carea_app/features/food/domain/repos/recipe_repo.dart';
import 'package:dartz/dartz.dart';

class GetTags extends UseCase<List<Tag>, NoParams> {
  final RecipeRepo recipeRepo;

  GetTags(this.recipeRepo); 

  @override
  Future<Either<Failure, List<Tag>>> call(NoParams params) {
    return recipeRepo.getTags();
  }
}
  