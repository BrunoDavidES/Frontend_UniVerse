

class User {
  final String id, name, primaryRole;
  //final DateTime lastLogin;

  const User(
      {required this.id,
        required this.name,
        required this.primaryRole,
        //required this.lastLogin
      });

  // Convert a User into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      //'lastLogin': lastLogin.millisecondsSinceEpoch,
      'role': primaryRole
    };
  }

  // Implement toString to make it easier to see information about
  // each user when using the print statement.
  @override
  String toString() {
    return 'User{username: $id}';
  }

}
