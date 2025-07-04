import 'package:carea_app/core/errors/failure.dart';
import 'package:carea_app/core/usecases/usecase.dart';
import 'package:carea_app/features/food/domain/entities/recipe.dart';
import 'package:carea_app/features/food/domain/repos/recipe_repo.dart';
import 'package:dartz/dartz.dart';

class GetRecipes extends UseCase<List<Recipe>, NoParams>{
  final RecipeRepo recipeRepo;

  GetRecipes(this.recipeRepo);
  @override
  Future<Either<Failure, List<Recipe>>> call(NoParams params) {
    return recipeRepo.getRecipes();
  }
}

