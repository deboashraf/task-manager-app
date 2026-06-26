import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manger/core/network/dio_server.dart';
import 'package:task_manger/feature/auth/screens/widget/custom_button.dart';
import 'package:task_manger/feature/auth/screens/widget/custom_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../data_source/auth_remote_data_source.dart';
import '../repository/auth_repository.dart';

//  emilys
// emilyspass
class LoginScreen extends StatefulWidget {
  final DioService dioService;

  const LoginScreen({super.key, required this.dioService});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthBloc authBloc;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final remote = AuthRemoteDataSource(widget.dioService);
    final repo = AuthRepository(remote);
    authBloc = AuthBloc(repo);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => authBloc,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  context.go('/root');
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Login Success ")));
                }

                if (state is AuthFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back ",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Login to continue",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 40),

                    CustomTextField(
                      label: "Username",
                      controller: usernameController,
                    ),

                    SizedBox(height: 16),

                    CustomTextField(
                      label: "password",
                      controller: passwordController,
                    ),

                    SizedBox(height: 30),

                    state is AuthLoading
                        ? Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: CustomButton(
                              text: "Login",
                              loading: state is AuthLoading,
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                  LoginEvent(
                                    username: usernameController.text,
                                    password: passwordController.text,
                                  ),
                                );
                              },
                            ),
                          ),

                    TextButton(
                      onPressed: () {
                        context.go('/register');
                      },
                      child: Text(
                        "Don't have an account? Register",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
