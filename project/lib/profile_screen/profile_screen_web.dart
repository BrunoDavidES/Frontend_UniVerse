import 'package:UniVerse/components/web/web_menu.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/profile_edit_screen/profile_edit_page_web.dart';
import 'package:UniVerse/profile_screen/profile_photo.dart';
import 'package:UniVerse/profile_screen/read_only_field.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import 'package:flutter/material.dart';

class ProfileScreenWeb extends StatelessWidget {
  const ProfileScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    UniverseUser user = UniverseUser("Rebeca", "rebe.a.gostosa", "Funcionário", "Divisão Erótica", "rebeca@sabes.pt", "+351 696969696", "O que é isso?", "Cave de Eletrotécnica", "UNREGISTERED", "Elah", "Núcleo 69", "CONTA ATIVA", "11/07/2023", "yes");
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WebMenu(width: size.width/9, height: size.height/1.5,)
          ],
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Image.asset("assets/web/profile-title.png", scale: 4.5,)
                    ),
                  ),
                      SizedBox(
                        width: size.width/1.65,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            ProfilePhoto(),
                            Padding(
                              padding: const EdgeInsets.only(top:30),
                              child: Column(
                                children: [
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
                            ),
                            SizedBox(width:50),

                             Padding(
                               padding: const EdgeInsets.only(top: 40),
                               child: Text(user.role!,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                             ),
                                SizedBox(width:10,),
                              Padding(
                                padding: const EdgeInsets.only(top: 45),
                                child: Text(user.job!,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: cHeavyGrey
                                      ),
                                    ),
                              ),
                            Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "EDITAR",
                                  style: TextStyle(
                                    color: cHeavyGrey,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                IconButton(onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      content: ProfileEditPageWeb(data: user),
                                    ),
                                  );
                                }, icon: Icon(Icons.edit_outlined, color: cHeavyGrey,)),
                              ],
                            )

                          ],
                        ),
                      ),
                ],
              ),
              SizedBox(
                width: size.width-size.width/6.50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width:600,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height:size.height/10),
                          MyReadOnlyField(icon: Icons.alternate_email, text: "Email: ", content: user.email!,),
                          MyReadOnlyField(icon: Icons.phone, text: "Telemóvel:", content: user.phone!,),
                          MyReadOnlyField(icon: Icons.insert_link, text: "LinkedIn:", content: user.email!,),
                          MyReadOnlyField(icon: Icons.work, text: "Gabinete:", content: user.office!,),
                          MyReadOnlyField(icon: Icons.directions_car_filled, text: "Matrícula:", content: user.license_plate!,),
                        ],
                      ),
                    ),
                   Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text("Conta Ativa".toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Text("Na UniVerse desde ${user.creation}",
                          style: TextStyle(
                            fontSize: 18,
                            color: cHeavyGrey.withOpacity(0.5)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:10),
                          child: Text(user.isPublic!,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text(user.department!,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(user.organization!,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Spacer()
                  ],
                ),
              ),
              SizedBox(height:size.height/6)
            ],
          ),
      ],
    );
  }
}
