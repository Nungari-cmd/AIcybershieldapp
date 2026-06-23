import 'package:flutter/material.dart';
import '../models/threat.dart';
import '../services/api_service.dart';
import '../services/firestore_service.dart';

class ThreatScreen extends StatefulWidget {
  const ThreatScreen({super.key});

  @override
  State<ThreatScreen> createState() =>
      _ThreatScreenState();
}

class _ThreatScreenState
    extends State<ThreatScreen> {
  String latestThreat =
      "No scan performed";
  String latestSeverity = "None";

  Future<void> runScan() async {
    final api = ApiService();

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content:
            Text("Running AI Scan..."),
      ),
    );

    final result =
        await api.fakeScan();

    final threat = Threat(
      threatName:
          result["name"]!,
      description:
          result["description"]!,
      severity:
          result["severity"]!,
      scanDate:
          DateTime.now().toString(),
    );

    await FirestoreService()
        .addThreat(threat);

    setState(() {
      latestThreat =
          result["name"]!;
      latestSeverity =
          result["severity"]!;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          "${result["name"]} saved to Firebase",
        ),
      ),
    );
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Threat Detection",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              "AI Threat Scanner",
              style: TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(
                  20,
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.security,
                      size: 80,
                      color:
                          Colors.cyan,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      width:
                          double.infinity,
                      child:
                          ElevatedButton.icon(
                        onPressed:
                            runScan,
                        icon:
                            const Icon(
                          Icons.search,
                        ),
                        label:
                            const Text(
                          "Run Scan",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            Card(
              child: ListTile(
                leading:
                    const Icon(
                  Icons.warning,
                  color:
                      Colors.orange,
                ),
                title:
                    Text(latestThreat),
                subtitle: Text(
                  "Severity: $latestSeverity",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}