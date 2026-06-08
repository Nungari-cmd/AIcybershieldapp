import 'package:flutter/material.dart';

class ThreatScreen extends StatelessWidget {
  const ThreatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Threat Detection'), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text(
                'AI Threat Scanner',

                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade900,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  children: [
                    const Icon(Icons.security, size: 80, color: Colors.cyan),

                    const SizedBox(height: 15),

                    const Text(
                      'Your Device is Protected',

                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// AI monitoring description
                    const Text(
                      'AI monitoring is active and scanning for suspicious activities.',

                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    /// Scan button
                    SizedBox(
                      width: double.infinity,
                      height: 50,

                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Temporary button action
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('AI Scan Started...')),
                          );
                        },

                        icon: const Icon(Icons.search),

                        label: const Text(
                          'Run Scan',

                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// Recent activity title
              const Text(
                'Recent Threat Activity',

                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              /// Threat activity card 1
              Card(
                child: ListTile(
                  leading: const Icon(Icons.warning, color: Colors.orange),

                  title: const Text('Suspicious Login Attempt'),

                  subtitle: const Text('Blocked 10 minutes ago'),
                ),
              ),

              const SizedBox(height: 15),

              /// Threat activity card 2
              Card(
                child: ListTile(
                  leading: const Icon(Icons.link_off, color: Colors.red),

                  title: const Text('Unsafe Link Detected'),

                  subtitle: const Text('Potential phishing website'),
                ),
              ),

              const SizedBox(height: 15),

              /// Threat activity card 3
              Card(
                child: ListTile(
                  leading: const Icon(Icons.shield, color: Colors.green),

                  title: const Text('Firewall Active'),

                  subtitle: const Text('System protection enabled'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
