import 'package:carea_app/core/errors/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/error_model.dart';
import '../models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _supabase;

  AuthRemoteDataSourceImpl(this._supabase);

  @override
  Session? get currentUserSession => _supabase.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await _supabase
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);
        return UserModel.fromJson(
          userData.first,
        ).copyWith(email: currentUserSession!.user.email);
      }

      return null;
    } catch (e) {
      throw ServerException(
        ErrorModel(errorMessage: e.toString(), status: 500),
      );
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        password: password,
        email: email,
      );

      if (response.user == null) {
        throw ServerException(
          ErrorModel(errorMessage: "Something went wrong", status: 500),
        );
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(ErrorModel(errorMessage: e.message, status: 500));
    } catch (e) {
      throw ServerException(
        ErrorModel(errorMessage: e.toString(), status: 500),
      );
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );

      if (response.user == null) {
        throw ServerException(
          ErrorModel(errorMessage: "Something went wrong", status: 500),
        );
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(ErrorModel(errorMessage: e.message, status: 500));
    } catch (e) {
      throw ServerException(
        ErrorModel(errorMessage: e.toString(), status: 500),
      );
    }
  }
}
