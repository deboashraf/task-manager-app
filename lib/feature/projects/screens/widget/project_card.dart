import 'package:flutter/material.dart';
import 'package:task_manger/feature/projects/model/project_model.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback onTap;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = project.stock > 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:  EdgeInsets.only(bottom: 16),
        padding:  EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset:  Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    project.title,
                    style:  TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding:  EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.green.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isActive ? "Active" : "Done",
                    style: TextStyle(
                      color: isActive ? Colors.green : Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
             SizedBox(height: 12),
            Text(
              project.disc,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:  TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}