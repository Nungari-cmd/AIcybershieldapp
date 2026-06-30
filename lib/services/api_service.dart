import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Fetch sample users from API
  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  // Simulate AI threat scan
  Future<Map<String, String>> fakeScan() async {
    await Future.delayed(const Duration(seconds: 2));

    final threats = [
      {
        "name": "Suspicious Login Attempt",
        "description":
            "Multiple failed login attempts detected from an unknown device.",
        "severity": "High",
      },
      {
        "name": "Phishing Link Detected",
        "description": "A suspicious link was detected in incoming messages.",
        "severity": "Medium",
      },
      {
        "name": "Malware Signature Found",
        "description": "Possible malware activity detected on the device.",
        "severity": "High",
      },
      {
        "name": "Unusual Network Activity",
        "description": "Abnormal data traffic detected in the background.",
        "severity": "Low",
      },
    ];

    return threats[DateTime.now().second % threats.length];
  }

  // AI Assistant responses
Future<String> askAI(
  String question,
) async {
  await Future.delayed(
    const Duration(seconds: 2),
  );

  final q =
      question.toLowerCase();

  if (q.contains("phishing")) {
    return "Phishing emails usually ask for passwords or personal information. Avoid clicking suspicious links.";
  }

  if (q.contains("password")) {
    return "Use a strong password with uppercase, lowercase, numbers and symbols.";
  }

  if (q.contains("virus")) {
    return "Keep your antivirus updated and avoid downloading files from unknown sources.";
  }

  return "I am still learning. Please ask another cybersecurity question.";
}
}
