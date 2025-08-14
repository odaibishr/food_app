part of 'recipe_bloc.dart';

@immutable
sealed class RecipeState {}

final class RecipeInitial extends RecipeState {}

final class RecipeLoading extends RecipeState {}

final class RecipeLoaded extends RecipeState {
  final List<Recipe> recipes;
  RecipeLoaded({required this.recipes});
}

final class RecipeError extends RecipeState {
  final String message;
  RecipeError({required this.message});
}

final class RecipeDetailsLoaded extends RecipeState {
  final Recipe recipe;
  RecipeDetailsLoaded({required this.recipe});
}

final class RecipeDetailsError extends RecipeState {
  final String message;
  RecipeDetailsError({required this.message});
}

final class RecipeDetailsLoading extends RecipeState {}

final class TagsLoaded extends RecipeState {
  final List<Tag> tags;
  TagsLoaded({required this.tags});
}

final class TagsError extends RecipeState {
  final String message;
  TagsError({required this.message});
}

final class TagsLoading extends RecipeState {}

