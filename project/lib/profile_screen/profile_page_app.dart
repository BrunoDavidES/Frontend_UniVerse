import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;

import 'package:UniVerse/profile_edit_screen/profile_edit_app.dart';
import 'package:UniVerse/profile_screen/profile_photo.dart';
import 'package:UniVerse/profile_screen/read_only_vertical_field.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';
import '../components/custom_shape.dart';
import '../utils/user/user_data.dart';

class ProfilePageApp extends StatefulWidget {
  const ProfilePageApp({Key? key}) : super(key: key);

  @override
  _ProfilePageAppState createState() => _ProfilePageAppState();
}

class _ProfilePageAppState extends State<ProfilePageApp> {
  UniverseUser? user;

  @override
  void initState() {
    retrieveUser();
    super.initState();
  }

  Future<int> retrieveUser() async {
    try {
      var retrievedUser = await UniverseUser.get();
      user = retrievedUser;
      return 200;
    } catch (e) {
      user = null;
      return 400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      appBar: AppBar(
        title: Image.asset("assets/app/profile_title.png", scale: 6),
        leadingWidth: 20,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
              color: cDirtyWhiteColor,
            );
          },
        ),
        backgroundColor: cPrimaryLightColor,
        titleSpacing: 15,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfileEditApp(user: user!),
              ));
            },
            icon: Icon(
              Icons.edit_outlined,
              color: cDirtyWhiteColor,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: retrieveUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == 400) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlueCurve(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "ACONTECEU ALGO INESPERADO.\nTENTA NOVAMENTE, POR FAVOR.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: cPrimaryLightColor,
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Stack(
                children: [
                  BasicInfo(user: user!),
                  FullInfo(user: user!),
                  BlueCurve(),
                  PhotoRole(user: user!),
                ],
              );
            }
          }
          return Loading();
        },
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlueCurve(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: LinearProgressIndicator(
            color: cPrimaryOverLightColor,
            minHeight: 10,
            backgroundColor: cPrimaryLightColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "A ENCONTRAR AS TUAS INFORMAÇÕES",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: cPrimaryLightColor,
            ),
          ),
        )
      ],
    );
  }
}

class FullInfo extends StatelessWidget {
  const FullInfo({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UniverseUser user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 200),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: cDirtyWhiteColor,
            ),
            child: Column(
              children: [
                MyReadOnlyVerticalField(
                  icon: Icons.alternate_email,
                  text: "Email: ",
                  content: user.email,
                ),
                MyReadOnlyVerticalField(
                  icon: Icons.phone,
                  text: "Telemóvel:",
                  content: user.phone,
                ),
                MyReadOnlyVerticalField(
                  icon: Icons.insert_link,
                  text: "LinkedIn:",
                  content: user.linkedin,
                ),
                Authentication.role != 'S'
                    ? MyReadOnlyVerticalField(
                  icon: Icons.work,
                  text: "Gabinete:",
                  content: user.office,
                )
                    : SizedBox(),
                MyReadOnlyVerticalField(
                  icon: Icons.directions_car_filled,
                  text: "Matrícula:",
                  content: user.license_plate,
                ),
                SizedBox(height: 70)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PhotoRole extends StatelessWidget {
  const PhotoRole({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UniverseUser user;

  Future<Uint8List> fetchImageFile(String id) async {
    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref('/Users/$id');
      final downloadUrl = await ref.getDownloadURL();
      final response = await http.get(Uri.parse(downloadUrl));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception('Failed to fetch image file.');
      }
    } catch (e) {
      throw Exception('Failed to fetch image file.');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<Uint8List>(
          future: fetchImageFile(user.username),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: MemoryImage(
                            snapshot.data!
                        ),
                      fit: BoxFit.fill
                    )
                ),
                width: 140, height: 140,
              );
            }
            return Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/images/person.png")
                  )
              ),
              width: 140, height: 140,
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                UniverseUser.friendlyRole,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                user.job,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        )
      ],
    );
       /* final image = MemoryImage(snapshot.data!);
        return Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 5),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    user.role,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    user.job,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );*/
  }
}

class BasicInfo extends StatelessWidget {
  final UniverseUser user;

  const BasicInfo({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 145),
              Text(
                user.name,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              Text(
                user.username,
                style: TextStyle(
                  fontSize: 15,
                  color: cHeavyGrey,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  "Conta Ativa".toUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "Na UniVerse desde\n${user.creation}",
                style: TextStyle(
                  fontSize: 13,
                  color: cHeavyGrey.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
        Spacer()
      ],
    );
  }
}

class BlueCurve extends StatelessWidget {
  const BlueCurve({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: cPrimaryLightColor,
          height: 40,
        ),
        ClipPath(
          clipper: CustomShape(),
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  cPrimaryLightColor,
                  cPrimaryOverLightColor,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}