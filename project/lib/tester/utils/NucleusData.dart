class NucleusData {
  final String id;
  final String email;
  final String name;
  final String president;
  final String newName;
  final String website;
  final String instagram;
  final String twitter;
  final String facebook;
  final String youtube;
  final String linkedIn;
  final String description;
  final List<String> members;

  NucleusData({
    required this.id,
    required this.email,
    required this.name,
    required this.president,
    required this.newName,
    required this.website,
    required this.instagram,
    required this.twitter,
    required this.facebook,
    required this.youtube,
    required this.linkedIn,
    required this.description,
    required this.members
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'president': president,
      'newName': newName,
      'website': website,
      'instagram': instagram,
      'twitter': twitter,
      'facebook': facebook,
      'youtube': youtube,
      'linkedIn': linkedIn,
      'description': description,
      'members': members
    };
  }
}