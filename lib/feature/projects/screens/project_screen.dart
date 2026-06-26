import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manger/core/network/dio_server.dart';
import 'package:task_manger/feature/projects/bloc/bloc/project_bloc.dart';
import 'package:task_manger/feature/projects/bloc/bloc/project_event.dart';
import 'package:task_manger/feature/projects/bloc/bloc/project_state.dart';
import 'package:task_manger/feature/projects/data_source/project_remote_data_source.dart';
import 'package:task_manger/feature/projects/repository/project_repository.dart';
import 'package:task_manger/feature/projects/screens/widget/project_card.dart';

class ProjectsScreen extends StatelessWidget {
  final DioService dioService;

  const ProjectsScreen({super.key, required this.dioService});

  @override
  Widget build(BuildContext context) {
    final remote = ProjectRemoteDataSource(dioService);
    final repo = ProjectRepository(remote);

    return BlocProvider(
      create: (_) => ProjectBloc(repo)..add(GetProjectsEvent()),
      child: Scaffold(
        backgroundColor: Color(0xffF5F7FA),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: Text("My Project"),
        ),
        body: BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            if (state is ProjectLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is ProjectError) {
              return Center(
                child: Text(state.message, style: TextStyle(color: Colors.red)),
              );
            }

            if (state is ProjectSuccess) {
              if (state.projects.isEmpty) {
                return Center(
                  child: Text(
                    "No Projects Yet",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ProjectBloc>().add(GetProjectsEvent());
                },
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    SizedBox(height: 8),
                    Text(
                      "${state.projects.length} Projects",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20),

                    ...state.projects.map((project) {
                      final isActive = project.stock > 0;

                      return GestureDetector(
                        onTap: () {
                          context.push('/projectDetails', extra: project);
                        },
                        child: ProjectCard(
                          project: project,
                          onTap: () {
                            context.push('/projectDetails', extra: project);
                          },
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}
