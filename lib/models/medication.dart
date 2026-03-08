

enum MedicationStatus {
  missed,
  upcoming,
  taken
}

class Medication {
  final String name;
  final String dosage;
  final String time;
  final MedicationStatus status;
  final String imagePath;
  final DateTime date;

  Medication({
    required this.name,
    required this.dosage,
    required this.time,
    required this.status,
    required this.imagePath,
    required this.date,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      name: json['name'],
      dosage: json['dosage'],
      time: json['time'],
      status: MedicationStatus.values.firstWhere(
            (e) => e.toString() == 'MedicationStatus.${json['status']}',
            orElse: () => MedicationStatus.upcoming,
      ),
      imagePath: json['imagePath'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dosage': dosage,
      'time': time,
      'status': status.toString().split('.').last,
      'imagePath': imagePath,
      'date': date.toIso8601String(),
    };
  }
}
