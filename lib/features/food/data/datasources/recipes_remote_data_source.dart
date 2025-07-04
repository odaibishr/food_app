import 'package:carea_app/core/database/api/api_consumer.dart';
import 'package:carea_app/core/database/api/end_points.dart';
import 'package:carea_app/features/food/data/models/recipe_model.dart';

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
    final response = await api.get('${EndPoints.recipes}/$id');
    return RecipeModel.fromJson(response);
  }
}
