class DepartmentData {
  final String id;
  final String email;
  final String name;
  final String president;
  final String phoneNumber;
  final String address;
  final String fax;
  final List<String> members;

  DepartmentData({
    required this.id,
    required this.email,
    required this.name,
    required this.president,
    required this.phoneNumber,
    required this.address,
    required this.fax,
    required this.members
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'president': president,
      'phoneNumber': phoneNumber,
      'address': address,
      'fax': fax,
      'members': members
    };
  }
}