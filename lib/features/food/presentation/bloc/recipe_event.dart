part of 'recipe_bloc.dart';

@immutable
sealed class RecipeEvent {}

class GetRecipesEvent extends RecipeEvent {}

class GetRecipeEvent extends RecipeEvent {
  final int id;
  GetRecipeEvent({required this.id});
}

class GetRecipesByTagEvent extends RecipeEvent {
  final int tagId;
  GetRecipesByTagEvent({required this.tagId});
}

class GetTagsEvent extends RecipeEvent {}
