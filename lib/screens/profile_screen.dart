import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', nameController.text);
    await prefs.setString('email', emailController.text);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Profile Saved")));
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      nameController.text = prefs.getString('username') ?? '';

      emailController.text = prefs.getString('email') ?? '';
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 50)),

            const SizedBox(height: 30),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return SwitchListTile(
                  title: const Text("Dark Mode"),
                  subtitle: const Text("Enable dark theme"),
                  secondary: const Icon(Icons.dark_mode),
                  value: themeProvider.isDark,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                );
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveProfile,
              child: const Text("Save Profile"),
            ),
            ElevatedButton.icon(
              onPressed: logout,
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
