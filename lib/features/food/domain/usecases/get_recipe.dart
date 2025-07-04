import 'package:carea_app/core/errors/failure.dart';
import 'package:carea_app/core/usecases/usecase.dart';
import 'package:carea_app/features/food/domain/entities/recipe.dart';
import 'package:carea_app/features/food/domain/repos/recipe_repo.dart';
import 'package:dartz/dartz.dart';

class GetRecipe extends UseCase<Recipe, int> {
  final RecipeRepo recipeRepo;

  GetRecipe(this.recipeRepo);
  @override
  Future<Either<Failure, Recipe>> call(int id) {
    return recipeRepo.getRecipe(id);
  }
}