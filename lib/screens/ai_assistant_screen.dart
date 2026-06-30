import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/event_logger.dart';

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final api = ApiService();

  final TextEditingController controller = TextEditingController();

  String response = "";

  Future<void> askAI() async {
    if (controller.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter a question first")));
      return;
    }

    EventLogger.log("AI Question: ${controller.text}");

    setState(() {
      response = "Thinking...";
    });

    final result = await api.askAI(controller.text);

    setState(() {
      response = result;
    });

    EventLogger.log("AI Response Generated");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Assistant")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Ask CyberShield AI",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) {
                askAI();
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: askAI, child: const Text("Ask AI")),
            const SizedBox(height: 20),
            Text(response),
          ],
        ),
      ),
    );
  }
}
