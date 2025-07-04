import 'package:carea_app/features/auth/domain/usecases/crrunt_user.dart';
import 'package:carea_app/features/auth/domain/usecases/user_login.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/entities/user.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserLogIn _userLogin;
  final CurrentUser _currentUser;
  AuthBloc({
    required UserSignup userSignUp,
    required UserLogIn userLogin,
    required CurrentUser currentUser,
  }) : _userSignup = userSignUp,
       _userLogin = userLogin,
       _currentUser = currentUser,
       super(AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onSignUp);
    on<AuthLogin>(_onLogin);
    on<AuthIsUserLoggedIn>(_onIsUserLoggedIn);
  }

  void _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final result = await _userSignup(
      UserSignupParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.errorMessage)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final result = await _userLogin(
      UserLogInParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.errorMessage)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onIsUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _currentUser(NoParams());
    result.fold(
      (failure) => emit(AuthFailure(failure.errorMessage)),
      (user) => emit(AuthSuccess(user)),
    );
  }
}
