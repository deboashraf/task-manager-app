import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manger/core/network/dio_server.dart';
import 'package:task_manger/feature/auth/bloc/auth_bloc.dart';
import 'package:task_manger/feature/auth/data_source/auth_remote_data_source.dart';
import 'package:task_manger/feature/auth/repository/auth_repository.dart';
import 'package:task_manger/feature/auth/screens/login_screen.dart';
import 'package:task_manger/feature/auth/screens/register_screen.dart';
import 'package:task_manger/feature/auth/screens/splash_screen.dart';
import 'package:task_manger/feature/projects/model/project_model.dart';
import 'package:task_manger/feature/projects_details/screens/project_details.dart';
import 'package:task_manger/feature/root_screen.dart';

class AppRouter {
  static GoRouter router(DioService dioService) {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => SplashScreen(dioService: dioService),
        ),

        GoRoute(
          path: '/root',
          builder: (context, state) => RootScreen(dioService: dioService),
        ),

        GoRoute(
          path: '/projectDetails',
          builder: (context, state) {
            final project = state.extra as ProjectModel;
            return ProjectDetailsScreen(project: project);
          },
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) {
            return BlocProvider(
              create: (_) =>
                  AuthBloc(AuthRepository(AuthRemoteDataSource(dioService))),
              child: LoginScreen(dioService: dioService),
            );
          },
        ),

        GoRoute(
          path: '/register',
          builder: (context, state) {
            return BlocProvider(
              create: (_) =>
                  AuthBloc(AuthRepository(AuthRemoteDataSource(dioService))),
              child:  RegisterScreen(dioService: DioService(),),
            );
          },
        ),
      ],
    );
  }
}
