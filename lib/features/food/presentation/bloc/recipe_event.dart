part of 'recipe_bloc.dart';

@immutable
sealed class RecipeEvent {}

class GetRecipesEvent extends RecipeEvent {}

class GetRecipeEvent extends RecipeEvent {
  final int id;
  GetRecipeEvent({required this.id});
}