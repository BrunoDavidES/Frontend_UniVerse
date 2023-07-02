import 'package:flutter/material.dart';

import '../../consts/color_consts.dart';
import '../profile/profile_page_app.dart';
import '../../utils/users/user_data.dart';

class PersonalCard extends StatelessWidget {
  const PersonalCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    String name =  User.getName();
    String role = User.getRole();
    String job = User.getJob();
    Color color;
    if(User.isVerified()) {
      if (User.isActive())
        color = Colors.green;
      else color = Colors.orange;
    } else color = Colors.red;
    return Container(
      margin: EdgeInsets.all(10),
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
          boxShadow: [ BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0,0),
          ),
          ]
      ),
      height: 175,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:10, left: 15, bottom:5),
            child: Text(
              "Olá, ${name}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          User.isVerified()
          ?Padding(
            padding: const EdgeInsets.only(left: 15, bottom:5),
            child: Text(
              role,
              style: TextStyle(
                color: cDirtyWhiteColor,
                fontSize: 20,
              ),
            ),
          )
          : SizedBox(width: 1,),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom:5),
            child: Text(
              User.isVerified()
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
                padding: const EdgeInsets.all(5),
                child: Image.asset("assets/dot.png", scale: 2, alignment: Alignment.bottomRight),
              ),
            ],
          )
        ],
      ),
    );
  }
}