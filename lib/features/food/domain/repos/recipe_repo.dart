import 'package:carea_app/core/errors/failure.dart';
import 'package:carea_app/features/food/domain/entities/recipe.dart';
import 'package:dartz/dartz.dart';

abstract class RecipeRepo {
  Future<Either<Failure, List<Recipe>>> getRecipes();
  Future<Either<Failure, Recipe>> getRecipe(int id);
}
