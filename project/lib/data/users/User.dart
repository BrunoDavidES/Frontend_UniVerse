

class User {
  final String id, email;
  final DateTime lastLogin;

  const User(
      {required this.id,
        required this.email,
        required this.lastLogin});

  // Convert a User into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'username': id,
      'email': email,
      'lastLogin': lastLogin.millisecondsSinceEpoch,
    };
  }

  // Implement toString to make it easier to see information about
  // each user when using the print statement.
  @override
  String toString() {
    return 'User{username: $id, email: $email, lastLogin: $lastLogin}';
  }

}
