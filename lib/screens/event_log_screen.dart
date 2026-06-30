import 'package:flutter/material.dart';
import '../services/event_logger.dart';

class EventLogScreen extends StatelessWidget {
  const EventLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = EventLogger.getLogs();

    return Scaffold(
      appBar: AppBar(title: const Text("Event Logs")),
      body: logs.isEmpty
          ? const Center(child: Text("No events yet"))
          : ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(logs[index]),
                  ),
                );
              },
            ),
    );
  }
}
