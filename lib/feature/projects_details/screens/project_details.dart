import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manger/feature/projects/model/project_model.dart';
import 'package:task_manger/feature/tasks/bloc/bloc/task_bloc.dart';
import 'package:task_manger/feature/tasks/bloc/bloc/task_event.dart';
import 'package:task_manger/feature/tasks/bloc/bloc/task_state.dart';
import 'package:task_manger/feature/tasks/model/task_model.dart';


class ProjectDetailsScreen extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailsScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isActive = project.stock > 0;

    return BlocProvider(
      create: (_) => TaskBloc(),
      child: Scaffold(
        backgroundColor:  Color(0xffF5F7FA),
        appBar: AppBar(
          title: Text(project.title),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () {
              _showAddTaskBottomSheet(context);
            },
            child:  Icon(Icons.add),
          ),
        ),
        body: Padding(
          padding:  EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                project.disc,
                style:  TextStyle(fontSize: 15),
              ),

               SizedBox(height: 20),

               Text(
                "Tasks",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),

               SizedBox(height: 16),

              Expanded(
                child: BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state.tasks.isEmpty) {
                      return  Center(
                        child: Text("No tasks yet"),
                      );
                    }

                    return ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        final task = state.tasks[index];

                        return ListTile(
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
                          subtitle: Text(task.priority),
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
      builder: (_) {
        return Padding(
          padding:  EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Text(
                "Add Task",
                style: TextStyle(fontSize: 18),
              ),
               SizedBox(height: 10),
              TextField(
                controller: controller,
                decoration:
                     InputDecoration(labelText: "Task title"),
              ),
              DropdownButton<String>(
                value: priority,
                items:  [
                  DropdownMenuItem(
                      value: "Low", child: Text("Low")),
                  DropdownMenuItem(
                      value: "Medium", child: Text("Medium")),
                  DropdownMenuItem(
                      value: "High", child: Text("High")),
                ],
                onChanged: (value) {
                  priority = value!;
                },
              ),
              ElevatedButton(
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
                child:  Text("Add"),
              ),
            ],
          ),
        );
      },
    );
  }
}