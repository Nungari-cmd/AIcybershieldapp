import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import 'event_log_screen.dart';
import 'threat_screen.dart';
import 'ai_assistant_screen.dart';
import 'profile_screen.dart';
import 'device_features_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FirestoreService firestoreService = FirestoreService();

  int totalThreats = 0;
  int highThreats = 0;

  @override
  void initState() {
    super.initState();
    loadStatistics();
  }

  Future<void> loadStatistics() async {
    final total = await firestoreService.getThreatCount();
    final high = await firestoreService.getHighThreatCount();

    if (!mounted) return;

    setState(() {
      totalThreats = total;
      highThreats = high;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CyberShield AI"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const Icon(
              Icons.security,
              size: 90,
              color: Colors.blue,
            ),

            const SizedBox(height: 15),

            const Text(
              "Welcome to CyberShield AI",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              "Your personal cybersecurity companion",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.security,
                            color: Colors.blue,
                            size: 40,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Threats",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            totalThreats.toString(),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.warning,
                            color: Colors.red,
                            size: 40,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "High Risk",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            highThreats.toString(),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Card(
              color: Colors.green,
              elevation: 5,
              child: const ListTile(
                leading: Icon(
                  Icons.verified_user,
                  color: Colors.white,
                ),
                title: Text(
                  "System Status",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "Protected",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Card(
              elevation: 5,
              child: ListTile(
                leading: const Icon(
                  Icons.phone_android,
                  color: Colors.teal,
                  size: 35,
                ),
                title: const Text(
                  "Device Features",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text("Camera • GPS • Sensors"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DeviceFeaturesScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            Card(
              elevation: 5,
              child: ListTile(
                leading: const Icon(Icons.history),
                title: const Text(
                  "Event Logs",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text("View user interactions"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EventLogScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.warning_amber),
                label: const Text(
                  "Threat Scanner",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ThreatScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.smart_toy),
                label: const Text(
                  "AI Assistant",
                  style: TextStyle(fontSize: 18),
                ),
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

            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.person),
                label: const Text(
                  "Profile",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProfileScreen(),
                    ),
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