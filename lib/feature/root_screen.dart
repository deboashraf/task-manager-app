import 'package:flutter/material.dart';
import 'package:task_manger/core/network/dio_server.dart';
import 'package:task_manger/feature/profile/screens/profile_screen.dart';
import 'package:task_manger/feature/projects/screens/project_screen.dart';

class RootScreen extends StatefulWidget {
  final DioService dioService;

  const RootScreen({super.key, required this.dioService});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      ProjectsScreen(dioService: widget.dioService),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Projects",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}