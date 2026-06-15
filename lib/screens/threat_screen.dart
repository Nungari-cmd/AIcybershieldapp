import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ThreatScreen extends StatefulWidget {
  const ThreatScreen({super.key});

  @override
  State<ThreatScreen> createState() => _ThreatScreenState();
}

class _ThreatScreenState extends State<ThreatScreen> {
  final ApiService api = ApiService();

  bool isScanning = false;
  String result = "";

  Future<void> runScan() async {
    setState(() {
      isScanning = true;
      result = "Scanning system...";
    });

    final response = await api.fakeScan();

    setState(() {
      result = response;
      isScanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Threat Scanner")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: runScan,
              child: const Text("Run Threat Scan"),
            ),

            const SizedBox(height: 20),

            if (isScanning)
              const CircularProgressIndicator()
            else
              Text(
                result.isEmpty ? "No scan run yet" : result,
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
