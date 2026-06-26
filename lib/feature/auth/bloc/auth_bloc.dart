import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manger/feature/auth/bloc/auth_event.dart';
import 'package:task_manger/feature/auth/bloc/auth_state.dart';
import 'package:task_manger/feature/auth/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  final Logger _logger = Logger();

  AuthBloc(this.repository) : super(AuthInitial()) {

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final user = await repository.login(
          event.username.trim(),
          event.password.trim(),
        );

        await _saveUserData(
          token: user.accessToken,
          username: user.username,
          email: user.email,
        );

        emit(AuthSuccess(user: user));
      } catch (e) {
        _logger.e("Login Error: $e");
        emit( AuthFailure(message: "Login failed"));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final user = await repository.register(
          event.name.trim(),
          event.email.trim(),
          event.password.trim(),
        );

        await _saveUserData(
          token: user.accessToken,
          username: user.username,
          email: user.email,
        );

        emit(AuthSuccess(user: user));
      } catch (e) {
        _logger.e("Register Error: $e");
        emit( AuthFailure(message: "Registration failed"));
      }
    });
  }

  Future<void> _saveUserData({
    required String token,
    required String username,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('token', token);
    await prefs.setString('username', username);
    await prefs.setString('email', email);
  }
}