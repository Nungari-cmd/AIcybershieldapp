import 'package:flutter/material.dart';
import '../models/threat.dart';
import '../services/api_service.dart';
import '../services/firestore_service.dart';
import '../services/event_logger.dart';

class ThreatScreen extends StatefulWidget {
  const ThreatScreen({super.key});

  @override
  State<ThreatScreen> createState() => _ThreatScreenState();
}

class _ThreatScreenState extends State<ThreatScreen> {
  String latestThreat = "No scan yet";
  String latestSeverity = "None";

  Future<void> runScan() async {
    EventLogger.log("Threat scan started");

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Running AI scan...")));

    final api = ApiService();
    final result = await api.fakeScan();

    final threat = Threat(
      threatName: result["name"]!,
      description: result["description"]!,
      severity: result["severity"]!,
      scanDate: DateTime.now().toString(),
    );

    await FirestoreService().addThreat(threat);

    setState(() {
      latestThreat = result["name"]!;
      latestSeverity = result["severity"]!;
    });

    EventLogger.log("Threat saved: $result");

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Threat detected: $result")));
  }

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
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'AI monitoring is active and scanning for suspicious activities.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: runScan,
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

              const SizedBox(height: 25),

              GestureDetector(
                onTap: () {
                  EventLogger.log("Threat card tapped");

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Threat card tapped")),
                  );
                },
                onLongPress: () {
                  EventLogger.log("Threat card long pressed");

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Threat Details"),
                      content: Text(
                        "Threat: $latestThreat\nSeverity: $latestSeverity",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  );
                },
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.warning, color: Colors.orange),
                    title: Text(latestThreat),
                    subtitle: Text("Severity: $latestSeverity"),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Recent Threat Activity',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.warning, color: Colors.orange),
                  title: const Text('Suspicious Login Attempt'),
                  subtitle: const Text('Blocked 10 minutes ago'),
                ),
              ),

              const SizedBox(height: 15),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.link_off, color: Colors.red),
                  title: const Text('Unsafe Link Detected'),
                  subtitle: const Text('Potential phishing website'),
                ),
              ),

              const SizedBox(height: 15),

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
