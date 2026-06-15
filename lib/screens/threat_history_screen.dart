import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';
import '../models/threat.dart';

class ThreatHistoryScreen extends StatefulWidget {
  const ThreatHistoryScreen({super.key});

  @override
  State<ThreatHistoryScreen> createState() => _ThreatHistoryScreenState();
}

class _ThreatHistoryScreenState extends State<ThreatHistoryScreen> {
  final FirestoreService service = FirestoreService();
  String searchText = "";

  void showEditDialog(
    String id,
    String name,
    String description,
    String severity,
    String date,
  ) {
    final nameController = TextEditingController(text: name);
    final descController = TextEditingController(text: description);
    final severityController = TextEditingController(text: severity);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Threat"),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Threat Name"),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: severityController,
                decoration: const InputDecoration(labelText: "Severity"),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () async {
                final updatedThreat = Threat(
                  threatName: nameController.text,
                  description: descController.text,
                  severity: severityController.text,
                  scanDate: date,
                );

                await service.updateThreat(id, updatedThreat);

                Navigator.pop(context);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Threat updated")));
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Threat History")),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search threats",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: service.getThreats(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs.where((doc) {
                  return doc['threatName'].toString().toLowerCase().contains(
                    searchText,
                  );
                }).toList();

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];

                    return Card(
                      child: ListTile(
                        title: Text(doc['threatName']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Severity: ${doc['severity']}"),
                            Text("Date: ${doc['scanDate']}"),
                          ],
                        ),

                        leading: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showEditDialog(
                              doc.id,
                              doc['threatName'],
                              doc['description'],
                              doc['severity'],
                              doc['scanDate'],
                            );
                          },
                        ),

                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            service.deleteThreat(doc.id);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
