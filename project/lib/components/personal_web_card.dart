import 'package:flutter/material.dart';

import '../consts/color_consts.dart';
import '../utils/user/user_data.dart';

class PersonalWebCard extends StatelessWidget {
  const PersonalWebCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String name =  UniverseUser.getName();
    var role = UniverseUser.getRole();
    String job = UniverseUser.getJob();
    Color color;
    if(UniverseUser.isVerified()) {
      if (UniverseUser.isActive())
        color = Colors.green;
      else color = Colors.orange;
    } else color = Colors.red;
    return Padding(
      padding: const EdgeInsets.only(left:30),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                cPrimaryLightColor,
               color
              ],
            ),
            //color: cPrimaryLightColor,
            boxShadow: [ BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0,0),
            ),
            ]
        ),
        height: size.height/3,
        width: size.width/3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:10, left: 13, bottom:5),
              child: Text(
                "Olá, ${name}",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      UniverseUser.isVerified()
          ?Padding(
              padding: const EdgeInsets.only(left: 18, bottom:5),
              child: Text(
                "Aluno",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: cDirtyWhiteColor,
                  fontSize: 20,
                ),
              ),
            )
          : SizedBox(width: 1,),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                UniverseUser.isVerified()
                    ? job
                    : "CONTA NÃO VERIFICADA",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: cDirtyWhite.withOpacity(0.75),
                  fontSize: 20,
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Image.asset("assets/images/dot.png", scale: 2, alignment: Alignment.bottomRight),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}