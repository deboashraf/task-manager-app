import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manger/feature/projects/model/project_model.dart';
import 'package:task_manger/feature/tasks/bloc/bloc/task_bloc.dart';
import 'package:task_manger/feature/tasks/bloc/bloc/task_event.dart';
import 'package:task_manger/feature/tasks/bloc/bloc/task_state.dart';
import 'package:task_manger/feature/tasks/model/task_model.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailsScreen({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => TaskBloc(),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Hero(
            tag: "project_${project.id}",
            child: Material(
              color: Colors.transparent,
              child: Text(
                project.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () => _showAddTaskBottomSheet(context),
            child: const Icon(Icons.add),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.disc,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Text(
                "Tasks",
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state.tasks.isEmpty) {
                      return const Center(
                        child: Text("No tasks yet"),
                      );
                    }

                    return ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        final task = state.tasks[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: IconButton(
                              icon: Icon(
                                task.isDone
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: task.isDone
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                context
                                    .read<TaskBloc>()
                                    .add(ToggleTaskEvent(index));
                              },
                            ),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                decoration: task.isDone
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            subtitle: Text(
                              task.priority,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddTaskBottomSheet(BuildContext context) {
    final controller = TextEditingController();
    String priority = "Low";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add Task",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: "Task title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: priority,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: "Low", child: Text("Low")),
                  DropdownMenuItem(value: "Medium", child: Text("Medium")),
                  DropdownMenuItem(value: "High", child: Text("High")),
                ],
                onChanged: (value) {
                  priority = value!;
                },
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      context.read<TaskBloc>().add(
                            AddTaskEvent(
                              TaskModel(
                                title: controller.text,
                                priority: priority,
                              ),
                            ),
                          );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add Task"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}