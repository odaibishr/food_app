import 'package:carea_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:carea_app/core/connection/network_info.dart';
import 'package:carea_app/core/database/api/api_consumer.dart';
import 'package:carea_app/core/database/api/dio_consumer.dart';
import 'package:carea_app/core/database/api/end_points.dart';
import 'package:carea_app/features/auth/domain/usecases/user_login.dart';
import 'package:carea_app/features/auth/domain/usecases/user_signup.dart';
import 'package:carea_app/features/food/data/datasources/recipes_remote_data_source.dart';
import 'package:carea_app/features/food/data/repos/recipe_repo_impl.dart';
import 'package:carea_app/features/food/domain/repos/recipe_repo.dart';
import 'package:carea_app/features/food/domain/usecases/get_recipe.dart';
import 'package:carea_app/features/food/domain/usecases/get_recipes.dart';
import 'package:carea_app/features/food/domain/usecases/get_recipes_by_tag.dart';
import 'package:carea_app/features/food/domain/usecases/get_tags.dart';
import 'package:carea_app/features/food/presentation/bloc/recipe_bloc.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repos/auth_repo_impl.dart';
import 'features/auth/domain/repos/auth_repo.dart';
import 'features/auth/domain/usecases/crrunt_user.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: EndPoints.supabaseUrl,
    anonKey: EndPoints.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);

  // connection
  serviceLocator.registerFactory<DataConnectionChecker>(
    () => DataConnectionChecker(),
  );

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory<NetworkInfo>(
    () => NetworkInfoImpl(serviceLocator<DataConnectionChecker>()),
  );

  _initAuth();
  _initRecipe();

  // dio
}

void _initRecipe() {
  // Bloc
  serviceLocator.registerLazySingleton(
    () => RecipeBloc(
      getRecipe: serviceLocator<GetRecipe>(),
      getRecipes: serviceLocator<GetRecipes>(),
      getRecipesByTag: serviceLocator<GetRecipesByTag>(),
      getTags: serviceLocator<GetTags>(),
    ),
  );

  // Repos
  serviceLocator.registerFactory<RecipeRepo>(
    () => RecipeRepoImpl(
      serviceLocator<RecipesRemoteDataSource>(),
      serviceLocator<NetworkInfo>(),
    ),
  );

  // Remote Data Source
  serviceLocator.registerLazySingleton(
    () => RecipesRemoteDataSource(api: serviceLocator<ApiConsumer>()),
  );

  // UseCases
  serviceLocator.registerFactory(() => GetRecipe(serviceLocator<RecipeRepo>()));
  serviceLocator.registerFactory(
    () => GetRecipes(serviceLocator<RecipeRepo>()),
  );

  serviceLocator.registerFactory(
    () => GetRecipesByTag(serviceLocator<RecipeRepo>()),
  );

  serviceLocator.registerFactory(() => GetTags(serviceLocator<RecipeRepo>()));

  // Api
  serviceLocator.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(dio: Dio()),
  );

  serviceLocator.registerLazySingleton<Dio>(() => Dio());
}

void _initAuth() {
  // Bloc
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator<UserSignup>(),
      userLogin: serviceLocator<UserLogIn>(),
      currentUser: serviceLocator<CurrentUser>(),
    ),
  );

  // UseCases
  serviceLocator.registerFactory(() => UserLogIn(serviceLocator<AuthRepo>()));
  serviceLocator.registerFactory(() => UserSignup(serviceLocator<AuthRepo>()));
  serviceLocator.registerFactory(() => CurrentUser(serviceLocator<AuthRepo>()));

  // Repos
  serviceLocator.registerFactory<AuthRepo>(
    () => AuthRepoImpl(
      serviceLocator<AuthRemoteDataSource>(),
      serviceLocator<NetworkInfo>(),
    ),
  );

  // Remote Data Source
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator<SupabaseClient>()),
  );
}
