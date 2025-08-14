import 'package:carea_app/core/errors/failure.dart';
import 'package:carea_app/core/usecases/usecase.dart';
import 'package:carea_app/features/food/domain/entities/recipe.dart';
import 'package:carea_app/features/food/domain/repos/recipe_repo.dart';
import 'package:dartz/dartz.dart';

class GetRecipesByTag extends UseCase<List<Recipe>, int> {
  final RecipeRepo recipeRepo;

  GetRecipesByTag(this.recipeRepo); 

  @override
  Future<Either<Failure, List<Recipe>>> call(int params) {
    return recipeRepo.getRecipesByTag(params);
  }
}