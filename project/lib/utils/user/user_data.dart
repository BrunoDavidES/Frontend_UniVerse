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
    department = properties['department']['value'];
    //job
    phone = properties['phone']['value'];
    linkedin = properties['linkedin']['value'];
    isPublic = properties['isPublic']['value'];
    email = properties['email']['value'];
    license_plate = properties['license_plate']['value'];
    name = properties['name']['value'];
    organization =properties['organization']['value'];
    office=properties['office']['value'];
    status =properties['status']['value'];
    creation = properties['time_creation']['value'];
  }

  //401, 400, 200
  Future<UniverseUser?> get() async {
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
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      UniverseUser.fromJson(decoded);
      var toSplit = email;
      username = toSplit!.split("@")[0];
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

  /*
  var response = await User.updatePwd(oldPwd, newPwd, confirmation);
  //meter validacao internet
        if (response == 200) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Sucesso!",
                  descriptions: "Já alterámos a tua palavra-passe. Inicia sessão de novo, por favor",
                  text: "OK",
                );
              }
          );
        } else if (response==401) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Ups!",
                  descriptions: "Parece que não tens sessão iniciada.",
                  text: "OK",
                );
              }
          );
        } else if (response==400) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Ups!",
                  descriptions: "Aconteceu um erro inesperado! Por favor, tenta novamente.",
                  text: "OK",
                );
              }
          );
        }else {
            context.go("/error");
        }
      }
    setState(() {
      isLoading = false;
    });
  }
   */

  static Future<int> delete() async {
    String token = await Authentication.getTokenID();
    const String url = '$baseUrl/modify/delete';

    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }

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
