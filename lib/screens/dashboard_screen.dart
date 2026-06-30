import 'package:flutter/material.dart';
import 'event_log_screen.dart';
import 'threat_screen.dart';
import 'ai_assistant_screen.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI CyberShield Dashboard"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Icon(Icons.security, size: 100, color: Colors.blue),

            const SizedBox(height: 20),

            const Text(
              "Welcome to AI CyberShield",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),
            Card(
              child: ListTile(
                leading: const Icon(Icons.history),
                title: const Text("Event Logs"),
                subtitle: const Text("View user interactions"),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EventLogScreen()),
                  );
                },
              ),
            ),

            // THREAT SCREEN BUTTON
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.warning_amber),
                label: const Text("Threat Scanner"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ThreatScreen()),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            // AI ASSISTANT BUTTON
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.smart_toy),
                label: const Text("AI Assistant"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AiAssistantScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            // PROFILE BUTTON
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.person),
                label: const Text("Profile"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
