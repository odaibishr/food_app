import 'package:carea_app/core/errors/failure.dart';
import 'package:carea_app/features/food/domain/entities/recipe.dart';
import 'package:carea_app/features/food/domain/entities/tag.dart';
import 'package:dartz/dartz.dart';

abstract class RecipeRepo {
  Future<Either<Failure, List<Recipe>>> getRecipes();
  Future<Either<Failure, Recipe>> getRecipe(int id);
  Future<Either<Failure, List<Tag>>> getTags();
  Future<Either<Failure, List<Recipe>>> getRecipesByTag(int tagId);
}
