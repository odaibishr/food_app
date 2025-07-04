import 'package:bloc/bloc.dart';
import 'package:carea_app/core/usecases/usecase.dart';
import 'package:carea_app/features/food/domain/entities/recipe.dart';
import 'package:carea_app/features/food/domain/usecases/get_recipe.dart';
import 'package:carea_app/features/food/domain/usecases/get_recipes.dart';
import 'package:meta/meta.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GetRecipe getRecipe;
  final GetRecipes getRecipes;

  RecipeBloc({required this.getRecipe, required this.getRecipes})
    : super(RecipeInitial()) {
    on<RecipeEvent>((event, emit) {
      
    });

    on<GetRecipesEvent>((event, emit) async {
      emit(RecipeLoading());
      final failureOrRecipes = await getRecipes(NoParams());
      failureOrRecipes.fold(
        (failure) => emit(RecipeError(message: failure.errorMessage)),
        (recipes) => emit(RecipeLoaded(recipes: recipes)),
      );
    });

    on<GetRecipeEvent>((event, emit) async {
      emit(RecipeDetailsLoading());
      final failureOrRecipe = await getRecipe(event.id);
      failureOrRecipe.fold(
        (failure) => emit(RecipeError(message: failure.errorMessage)),
        (recipe) => emit(RecipeLoaded(recipes: [recipe])),
      );
    });
  }
}
