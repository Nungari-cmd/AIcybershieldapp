class Threat {
  final String threatName;
  final String description;
  final String severity;
  final String scanDate;

  Threat({
    required this.threatName,
    required this.description,
    required this.severity,
    required this.scanDate,
  });

  Map<String, dynamic> toMap() {
    return {
      "threatName": threatName,
      "description": description,
      "severity": severity,
      'scanDate': scanDate,
      "timestamp": DateTime.now().toIso8601String(),
    };
  }
}
