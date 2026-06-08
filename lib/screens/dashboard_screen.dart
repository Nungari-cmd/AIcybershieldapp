import 'package:flutter/material.dart';

import 'threat_screen.dart';
import 'ai_assistant_screen.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI CyberShield'), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              /// Dashboard title
              const Text(
                'Security Dashboard',

                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              /// System security card
              Card(
                child: ListTile(
                  leading: const Icon(Icons.security, color: Colors.green),

                  title: const Text('System Secure'),

                  subtitle: const Text('No threats detected'),
                ),
              ),

              const SizedBox(height: 20),

              /// Threat scanner navigation card
              Card(
                child: ListTile(
                  leading: const Icon(Icons.warning, color: Colors.orange),

                  title: const Text('Threat Scanner'),

                  subtitle: const Text('Run AI-powered scan'),

                  trailing: const Icon(Icons.arrow_forward),

                  onTap: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) => const ThreatScreen(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              /// AI assistant navigation card
              Card(
                child: ListTile(
                  leading: const Icon(Icons.smart_toy, color: Colors.cyan),

                  title: const Text('AI Assistant'),

                  subtitle: const Text('Get AI cybersecurity help'),

                  trailing: const Icon(Icons.arrow_forward),

                  onTap: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) => const AIAssistantScreen(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              /// Profile navigation card
              Card(
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.purple),

                  title: const Text('Profile'),

                  subtitle: const Text('Manage your account'),

                  trailing: const Icon(Icons.arrow_forward),

                  onTap: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
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
}
