import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

import '../models/device_activity.dart';
import '../services/firestore_service.dart';

class DeviceFeaturesScreen extends StatefulWidget {
  const DeviceFeaturesScreen({super.key});

  @override
  State<DeviceFeaturesScreen> createState() => _DeviceFeaturesScreenState();
}

class _DeviceFeaturesScreenState extends State<DeviceFeaturesScreen> {
  File? image;

  String latitude = "Not Available";
  String longitude = "Not Available";

  final FirestoreService firestoreService = FirestoreService();

  Future<void> capturePhoto() async {
    final picker = ImagePicker();

    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });

      saveActivity();
    }
  }

  Future<void> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enable GPS")));
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Location permission permanently denied."),
        ),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
    });

    saveActivity();
  }

  Future<void> saveActivity() async {
    if (image == null ||
        latitude == "Not Available" ||
        longitude == "Not Available") {
      return;
    }

    final activity = DeviceActivity(
      imagePath: image!.path,
      latitude: latitude,
      longitude: longitude,
      dateTime: DateTime.now().toString(),
    );

    await firestoreService.addDeviceActivity(activity);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Device activity saved successfully.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Device Features"), centerTitle: true),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: capturePhoto,
              icon: const Icon(Icons.camera_alt),
              label: const Text("Capture Photo"),
            ),

            const SizedBox(height: 20),

            image == null
                ? Container(
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(child: Text("No Image Captured")),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(image!, height: 220, fit: BoxFit.cover),
                  ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: getLocation,
              icon: const Icon(Icons.location_on),
              label: const Text("Get Location"),
            ),

            const SizedBox(height: 25),

            Card(
              child: ListTile(
                leading: const Icon(Icons.my_location, color: Colors.blue),
                title: const Text("Latitude"),
                subtitle: Text(latitude),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.location_pin, color: Colors.red),
                title: const Text("Longitude"),
                subtitle: Text(longitude),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.calendar_today, color: Colors.green),
                title: const Text("Date & Time"),
                subtitle: Text(DateTime.now().toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
