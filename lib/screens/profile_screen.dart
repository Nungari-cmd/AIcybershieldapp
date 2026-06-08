import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            /// Profile avatar
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.cyan,

              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),

            const SizedBox(height: 20),

            /// User name
            const Text(
              'Agnes Nungari',

              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            /// User email
            const Text(
              'agnes@aicybershield.com',

              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),

            const SizedBox(height: 30),

            /// Settings card
            Card(
              child: ListTile(
                leading: const Icon(Icons.security, color: Colors.green),

                title: const Text('Security Settings'),

                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),

            const SizedBox(height: 15),

            /// Notifications card
            Card(
              child: ListTile(
                leading: const Icon(Icons.notifications, color: Colors.orange),

                title: const Text('Notifications'),

                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),

            const SizedBox(height: 15),

            /// Logout card
            Card(
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),

                title: const Text('Logout'),

                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
