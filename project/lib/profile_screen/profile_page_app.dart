
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

    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: cPrimaryLightColor,
                height: 75,
              ),
              ClipPath(
                clipper: CustomShape(),
                child:
                Container(
                  height: 130,
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
          ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    AppBar(
                      title: Image.asset("assets/app/profile_title.png", scale:6),
                      leadingWidth: 20,
                      leading: Builder(
                          builder: (context) {
                            return IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {Navigator.pop(context);},
                                color: cDirtyWhiteColor);
                          }
                      ),
                      backgroundColor: Colors.transparent,
                      titleSpacing: 15,
                      elevation: 0,
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileEditScreen(data: user)));
                          },
                          icon: Icon(Icons.edit_outlined, color: cDirtyWhiteColor,),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            ProfilePhoto(),
                            Text(user.name!,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(user.username!,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: cHeavyGrey
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(user.role!,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: cHeavyGrey
                                  )),
                              SizedBox(height: 5),
                              Text(user.job!,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: cHeavyGrey
                                  )),
                              SizedBox(height: 30,),
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
                                    fontSize: 15,
                                    color: cHeavyGrey.withOpacity(0.5)
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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




