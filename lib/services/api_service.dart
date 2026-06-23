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
        "description":
            "A suspicious link was detected in incoming messages.",
        "severity": "Medium",
      },
      {
        "name": "Malware Signature Found",
        "description":
            "Possible malware activity detected on the device.",
        "severity": "High",
      },
      {
        "name": "Unusual Network Activity",
        "description":
            "Abnormal data traffic detected in the background.",
        "severity": "Low",
      },
    ];

    return threats[
        DateTime.now().second % threats.length];
  }

  // AI Assistant responses
  Future<String> askAI(String question) async {
    await Future.delayed(const Duration(seconds: 2));

    question = question.toLowerCase();

    if (question.contains("phishing")) {
      return "Do not click suspicious links and always verify the sender before opening emails or messages.";
    }

    if (question.contains("malware")) {
      return "Run a full system scan, remove suspicious apps, and keep your antivirus updated.";
    }

    if (question.contains("password")) {
      return "Use strong passwords with letters, numbers, and symbols. Enable two-factor authentication.";
    }

    if (question.contains("wifi")) {
      return "Avoid public Wi-Fi networks or use a VPN to protect your data.";
    }

    if (question.contains("virus")) {
      return "Update your antivirus and perform a complete device scan immediately.";
    }

    return "I recommend keeping your device updated, avoiding suspicious downloads, and enabling security features.";
  }
}