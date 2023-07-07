

import 'package:UniVerse/profile_edit_screen/profile_edit_app.dart';
import 'package:UniVerse/profile_screen/profile_photo.dart';
import 'package:UniVerse/profile_screen/read_only_vertical_field.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';
import '../components/custom_shape.dart';
import '../profile_edit_screen/profile_edit_screen.dart';
import '../utils/user/user_data.dart';

class ProfilePageApp extends StatelessWidget {
  const ProfilePageApp({super.key});

  @override
  Widget build(BuildContext context) {
    UniverseUser user = UniverseUser("Rebeca", "rebe.a.gostosa", "Funcionário", "Divisão Erótica", "rebeca@sabes.pt", "+351 696969696", "O que é isso?", "Cave de Eletrotécnica", "UNREGISTERED", "Elah", "Núcleo 69", "CONTA ATIVA", "11/07/2023", "yes");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      appBar: AppBar(
        title: Image.asset("assets/app/profile_title.png", scale:6),
        leadingWidth: 20,
        leading: Builder(
            builder: (context) {
              return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {Navigator.pop(context);},
                  color: cDirtyWhiteColor);
            }
        ),
        backgroundColor: cPrimaryLightColor,
        titleSpacing: 15,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileEditApp(user: user,)));
            },
            icon: Icon(Icons.edit_outlined, color: cDirtyWhiteColor,),
          )
        ],
      ),
      body: Stack(
        children: [
          BasicInfo(user: user),
          FullInfo(user: user),
          BlueCurve(),
          PhotoRole(user: user),
            ],
          ),
      );
  }
}

class FullInfo extends StatelessWidget {
  const FullInfo({
    super.key,
    required this.user,
  });

  final UniverseUser user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 200,),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: cDirtyWhiteColor,
            ),
            child: Column(
              children: [
                MyReadOnlyVerticalField(icon: Icons.alternate_email, text: "Email: ", content: user.email!,),
                MyReadOnlyVerticalField(icon: Icons.phone, text: "Telemóvel:", content: user.phone!,),
                MyReadOnlyVerticalField(icon: Icons.insert_link, text: "LinkedIn:", content: user.email!,),
                MyReadOnlyVerticalField(icon: Icons.work, text: "Gabinete:", content: user.office!,),
                MyReadOnlyVerticalField(icon: Icons.directions_car_filled, text: "Matrícula:", content: user.license_plate!,),
                SizedBox(height: 70,)
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
    super.key,
    required this.user,
  });

  final UniverseUser user;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Column(
            children: [
              ProfilePhoto(),
            ],
          ),
          SizedBox(width: 5,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(user.role!,
                    style: TextStyle(
                        fontSize: 18,
                        color: cDirtyWhite
                    )),
                SizedBox(height: 5),
                Text(user.job!,
                    style: TextStyle(
                        fontSize: 15,
                        color: cDirtyWhite.withOpacity(0.8)
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BasicInfo extends StatelessWidget {

  final UniverseUser user;

  const BasicInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 145,),
                Text(user.name!,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black
                  ),
                ),
                Text(user.username!,
                  style: TextStyle(
                      fontSize: 15,
                      color: cHeavyGrey
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 25,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text("Conta Ativa".toUpperCase(),
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text("Na UniVerse desde ${user.creation}",
                  style: TextStyle(
                      fontSize: 13,
                      color: cHeavyGrey.withOpacity(0.5)
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BlueCurve extends StatelessWidget {
  const BlueCurve({
    super.key,
  });

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
          child:
          Container(
            height: 75,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  cPrimaryLightColor,
                  cPrimaryOverLightColor
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}




