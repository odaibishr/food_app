import 'package:carea_app/core/database/api/api_consumer.dart';
import 'package:carea_app/core/database/api/end_points.dart';
import 'package:carea_app/features/food/data/models/recipe_model.dart';
import 'package:carea_app/features/food/data/models/tag_model.dart';

class RecipesRemoteDataSource {
  final ApiConsumer api;

  RecipesRemoteDataSource({required this.api});

  Future<List<RecipeModel>> getRecipes() async {
    final response = await api.get(EndPoints.recipes);
    if (response is List) {
      return response.map((e) => RecipeModel.fromJson(e)).toList();
    } else if (response is Map && response['recipes'] is List) {
      return (response['recipes'] as List)
          .map((e) => RecipeModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Unexpected API response format');
    }
  }

  Future<RecipeModel> getRecipe(int id) async {
    // EndPoints.recipes already ends with a trailing slash
    final response = await api.get('${EndPoints.recipes}$id');
    return RecipeModel.fromJson(response);
  }

  Future<List<RecipeModel>> getRecipesByTag(int tagId) async {
    // Avoid double slash: recipes/ + tag/$id
    final response = await api.get('${EndPoints.recipes}tag/$tagId');
    if (response is List) {
      // Ensure each element is a Map before parsing
      return response
          .whereType<Map<String, dynamic>>()
          .map<RecipeModel>((e) => RecipeModel.fromJson(e))
          .toList();
    } else if (response is Map && response['recipes'] is List) {
      return (response['recipes'] as List)
          .whereType<Map<String, dynamic>>()
          .map<RecipeModel>((e) => RecipeModel.fromJson(e))
          .toList();
    } else if (response is String) {
      throw Exception('Unexpected text response from API: $response');
    } else {
      throw Exception('Unexpected API response format');
    }
  }

  Future<List<TagModel>> getTags() async {
    final response = await api.get(EndPoints.allRecipesTags);
    if (response is List) {
      // Some APIs might return ["vegetarian","vegan",...] instead of list of objects
      if (response.isNotEmpty && response.first is String) {
        return List<TagModel>.generate(
          response.length,
          (i) => TagModel(id: i + 1, name: response[i] as String),
        );
      }
      return response
          .whereType<Map<String, dynamic>>()
          .map<TagModel>((e) => TagModel.fromJson(e))
          .toList();
    } else if (response is Map && response['tags'] is List) {
      return (response['tags'] as List)
          .whereType<Map<String, dynamic>>()
          .map<TagModel>((e) => TagModel.fromJson(e))
          .toList();
    } else if (response is String) {
      throw Exception('Unexpected text response from API: $response');
    } else {
      throw Exception('Unexpected API response format');
    }
  }
}
