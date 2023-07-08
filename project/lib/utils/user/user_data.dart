import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:UniVerse/consts/api_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import '../authentication/auth.dart';

class UniverseUser {

  String? name, username, role, job, email, phone, linkedin, office, license_plate, department, organization, status, creation, isPublic;

  UniverseUser(
      this.name,
      this.username,
      this.role,
      this.job,
      this.email,
      this.phone,
      this.linkedin,
      this.office,
      this.license_plate,
      this.department,
      this.organization,
      this.status,
      this.creation,
      this.isPublic
      );

  static String getUsername() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }
    return "ERROR";
  }

  static String getName() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.displayName!;
    }
    return "UNKNOWN ERROR";
  }

  static String getRole() {
    /*String token = Authentication.getTokenID() as String;
    if (token.isNotEmpty) {
      return token.;
    }
    return "UNKNOWN ERROR";*/
    return "T";
  }

  static String getJob() {
    /*String token = Authentication.getTokenID() as String;
    if (token.isNotEmpty) {
      return token.;
    }
    return "UNKNOWN ERROR";*/
    return "Presidente de Núcleo";
  }

  static bool isVerified() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.emailVerified == true;
    }
    return false;
  }

  static bool isActive() {
    /*var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.emailVerified == true;
    }
    return false;*/
    return true;
  }

  UniverseUser.fromJson(Map<String, dynamic> json ) {
    var properties = json['properties'];
    username = properties['username'];
    department = properties['department']['value'];
    job = properties['department_job']['value'];
    //phone = properties['phone']['value'];
    //linkedin = properties['linkedin']['value'];
    //isPublic = properties['isPublic']['value'];
    email = properties['email']['value'];
    license_plate = properties['license_plate']['value'];
    name = properties['name']['value'];
    organization =properties['nucleus']['value'];
    office=properties['office']['value'];
    status =properties['status']['value'];
    //creation = properties['time_creation']['value'];
  }

  //401, 400, 200
  static Future<UniverseUser?> get() async {
    String token = await Authentication.getTokenID();

    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return null;
    }

    String username = getUsername();
    String url = '$baseUrl/profile/$username';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': token,
      },
    );

    print("passou");

    if (response.statusCode == 200) {
      print("encontrou");
      var decoded = json.decode(response.body);
      var user = UniverseUser.fromJson(decoded);
      print(user.email);
      print(user.name);
      print(user.role);
      print(user.department);
      print(user.username);
      return user;
    } else if (response.statusCode == 401) {
      Authentication.userIsLoggedIn = false;
      Authentication.revoke();
      return null;
    }
    print(response.statusCode);
    return null;
  }

  static Future<int> update(name, phone, linkedin, office, license_plate, isPublic, Uint8List? image) async {
    String token = await Authentication.getTokenID();

    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }

    String url = '$baseUrl/modify/attributes';
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: json.encode({
        'name': name,
        'status': isPublic,
        'license_plate': license_plate,
        'office': office,
        'phone': phone,
        'linkedin': linkedin,
        'isPublic': isPublic,
      }),
    );
    if (response.statusCode == 200) {
      if(image!=null) {
        var username = UniverseUser.getUsername();
        var ref = FirebaseStorage.instance.ref().child("Reports/$username");
        ref.putData(image, SettableMetadata(contentType: 'image/jpeg'));
      }
      return 200;
    } else if (response.statusCode == 401) {
      Authentication.userIsLoggedIn = false;
      Authentication.revoke();
    }
    return response.statusCode;
  }

  static Future<int> delete() async {
    String token = await Authentication.getTokenID();
    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }
    const String url = '$baseUrl/modify/delete';
    final http.Response response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: json.encode({
        'target': UniverseUser.getUsername(),
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 401) {
      Authentication.userIsLoggedIn = false;
      Authentication.revoke();
    }
    return response.statusCode;
  }

}
