import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AIScreen extends StatefulWidget {
  const AIScreen({super.key});

  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {
  final controller = TextEditingController();
  final api = ApiService();

  String response = "";
  bool loading = false;

  Future<void> ask() async {
    setState(() => loading = true);

    try {
      final result = await api.askAI(controller.text);
      setState(() => response = result);
    } catch (e) {
      setState(() => response = "Error: $e");
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI CyberShield Assistant")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: "Ask something..."),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: ask, child: const Text("Send")),
            const SizedBox(height: 20),
            if (loading) const CircularProgressIndicator(),
            if (response.isNotEmpty)
              Expanded(child: SingleChildScrollView(child: Text(response))),
          ],
        ),
      ),
    );
  }
}
