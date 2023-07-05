import 'dart:convert';
import 'package:UniVerse/consts/api_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return "Aluno";
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
    return true;
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
    //phone
    //linkedin
    //isPublic
    email = properties['email']['value'];
    license_plate = properties['license_plate']['value'];
    name = properties['name']['value'];
    organization =properties['organization']['value'];
    office=properties['office']['value'];
    status =properties['status']['value'];
    creation = properties['time_creation']['value'];
  }

  //401, 400, 200
  Future<int> get() async {
    String token = await Authentication.getTokenID();

    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }

    String username = getUsername();
    String url = '$baseUrl/profile/$username';

    final http.Response response = await http.post(
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
    }
    return response.statusCode;
  }

  static Future<int> update(name, phone, linkedin, office, license_plate, isPublic) async {
    String token = await Authentication.getTokenID();
    String url = '$magikarp/modify/attributes';

    if(token.isEmpty)
      return 403;

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: json.encode({
        'name': name,
        'status': isPublic,
        'licensePlate': license_plate,
      }),
    );
    if (response.statusCode == 200) {
      //final String id = response.body;
      return 200;
    } else if (response.statusCode == 401) {
      Authentication.userIsLoggedIn = false;
      Authentication.revoke();
    }
    return response.statusCode;
  }

  static bool areCompliant(oldPwd, newPwd, confirmation) {
    return oldPwd.isNotEmpty && newPwd.isNotEmpty && confirmation.isNotEmpty;
  }

  static bool areEqual(newPwd, confirmation) {
    return newPwd == confirmation;
  }

  static bool match (newPwd) {
    var validator = RegExp("(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,64}");
    return newPwd.matches(validator);
  }

  static Future<int> updatePwd(oldPwd, newPwd, confirmation) async {
    String token = await Authentication.getTokenID();
    const String url = '$magikarp/modify/pwd';

    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: json.encode({
        'password': oldPwd,
        'newPwd': newPwd,
        'confimation': confirmation
      }),
    );

    if (response.statusCode == 200) {
      Authentication.userIsLoggedIn = false;
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
    const String url = '$magikarp/modify/delete';

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

    if (response.statusCode == 200) {
      Authentication.userIsLoggedIn = false;
    }
    return response.statusCode;
  }

}
