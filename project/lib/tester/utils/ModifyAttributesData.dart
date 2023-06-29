class ModifyAttributesData {
  final String name;
  final String status;
  final String license_plate;

  ModifyAttributesData({
    required this.name,
    required this.status,
    required this.license_plate
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status,
      'license_plate': license_plate,
    };
  }
}