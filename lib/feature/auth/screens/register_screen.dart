import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manger/core/network/dio_server.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../data_source/auth_remote_data_source.dart';
import '../repository/auth_repository.dart';

class RegisterScreen extends StatefulWidget {
  final DioService dioService;

  const RegisterScreen({super.key, required this.dioService});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late AuthBloc authBloc;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
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
            padding:  EdgeInsets.symmetric(horizontal: 24),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  context.go('/root');
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text("Account Created ")),
                  );
                }

                if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                     Text(
                      "Create New Account",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                     SizedBox(height: 8),

                     Text(
                      "Register to get started",
                      style: TextStyle(color: Colors.grey),
                    ),

                     SizedBox(height: 40),

                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                     SizedBox(height: 16),

                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                     SizedBox(height: 16),

                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                     SizedBox(height: 30),

                    state is AuthLoading
                        ?  Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.greenAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                  RegisterEvent(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                              },
                              child:  Text(
                                "Create Account",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),

                    TextButton(
                      onPressed: () {
                        context.go('/login');
                      },
                      child:  Text("Already have an account? Login",
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