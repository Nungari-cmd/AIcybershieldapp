import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey =
      "-svcacct-9nz-vwjvJW3nPWuS-x6yZwb6o8bxySVHlRf1h3X5qgxF_SAmNi-beP7C9YYrxtCsiBMyK7LQwmT3BlbkFJ0AR0pfOe-OinuUjv_Mnzgd47aEPPrh3ljqcrdcVGxObwCFRISEldykeDA9Xol_FIFUkKdZbnkA";

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );

    return jsonDecode(response.body);
  }

  Future<String> fakeScan() async {
    await Future.delayed(const Duration(seconds: 2));

    return "No threats detected. System is secure";
  }

  Future<String> askAI(String message) async {
    final url = Uri.parse("https://api.openai.com/v1/chat/completions");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      },
      body: jsonEncode({
        "model": "gpt-4o-mini",
        "messages": [
          {"role": "user", "content": message},
        ],
      }),
    );

    final data = jsonDecode(response.body);
    return data["choices"][0]["message"]["content"];
  }
}
