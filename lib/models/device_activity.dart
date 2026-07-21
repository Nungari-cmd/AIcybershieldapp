class DeviceActivity {
  final String imagePath;
  final String latitude;
  final String longitude;
  final String dateTime;

  DeviceActivity({
    required this.imagePath,
    required this.latitude,
    required this.longitude,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      "imagePath": imagePath,
      "latitude": latitude,
      "longitude": longitude,
      "dateTime": dateTime,
    };
  }
}
