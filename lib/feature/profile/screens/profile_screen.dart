import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String username = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('username') ?? '';
      email = prefs.getString('email') ?? '';
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xffF5F7FA),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,
        title:  Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.all(20),
        child: Column(
          children: [

             SizedBox(height: 20),

            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.greenAccent,
              child: Text(
                username.isNotEmpty
                    ? username[0].toUpperCase()
                    : "?",
                style:  TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),

             SizedBox(height: 20),

            Text(
              username,
              style:  TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

             SizedBox(height: 8),

            Text(
              email,
              style:  TextStyle(
                color: Colors.grey,
              ),
            ),

             SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: logout,
                child:  Text("Logout",style: TextStyle(
                  color: Colors.black
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}