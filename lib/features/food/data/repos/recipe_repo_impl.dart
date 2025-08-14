import 'package:carea_app/core/connection/network_info.dart';
import 'package:carea_app/core/errors/exceptions.dart';
import 'package:carea_app/core/errors/failure.dart';
import 'package:carea_app/features/food/data/datasources/recipes_remote_data_source.dart';
import 'package:carea_app/features/food/domain/entities/recipe.dart';
import 'package:carea_app/features/food/domain/entities/tag.dart';
import 'package:carea_app/features/food/domain/repos/recipe_repo.dart';
import 'package:dartz/dartz.dart';

class RecipeRepoImpl implements RecipeRepo {
  final RecipesRemoteDataSource recipesRemoteDataSource;
  final NetworkInfo networkInfo;

  RecipeRepoImpl(this.recipesRemoteDataSource, this.networkInfo);
  @override
  Future<Either<Failure, Recipe>> getRecipe(int id) async {
    if (!await networkInfo.isConnected!) {
      return Left(Failure(errorMessage: 'No internet connection'));
    }

    try {
      final recipe = await recipesRemoteDataSource.getRecipe(id);
      return Right(recipe);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> getRecipes() async {
    if (!await networkInfo.isConnected!) {
      return Left(Failure(errorMessage: 'No internet connection'));
    }

    try {
      final recipes = await recipesRemoteDataSource.getRecipes();
      return Right(recipes);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> getRecipesByTag(int tagId) async {
    if (!await networkInfo.isConnected!) {
      return Left(Failure(errorMessage: 'No internet connection'));
    }

    try {
      final recipes = await recipesRemoteDataSource.getRecipesByTag(tagId);
      return Right(recipes);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Tag>>> getTags() async {
    if (!await networkInfo.isConnected!) {
      return Left(Failure(errorMessage: 'No internet connection'));
    }

    try {
      final tags = await recipesRemoteDataSource.getTags();
      return Right(tags);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}
