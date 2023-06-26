import 'package:flutter/material.dart';

import '../../consts/color_consts.dart';
import '../../login_screen/functions/auth.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        tooltip: "Opções",
        offset: const Offset(0.0, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        onSelected: (value) async {
          if(value=="area") {
            Navigator.pushNamed(context, "/personal/main");
          } else {
            var response = await Authentication.revoge();
            if(response==200)
              Navigator.pushNamed(context, "/home");
          }
        },
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(
            value: "area",
            child: Row(
              children: const [
                Icon(Icons.person_outline, color: cHeavyGrey),
                SizedBox(width:5),
                Text(
                  "Área Pessoal",
                  style: TextStyle(
                    color: cHeavyGrey,
                  ),
                )
              ],
            ),
          ),
          PopupMenuItem(
            value: "logout",
            child: Row(
              children: const [
                Icon(Icons.logout_outlined, color: cHeavyGrey),
                SizedBox(width:5),
                Text(
                  "Sair",
                  style: TextStyle(
                    color: cHeavyGrey,
                  ),
                )
              ],
            ),
          ),
        ],
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: cPrimaryColor,
          ),
          child: Text(
            Authentication.getName(),
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
        )
    );
  }
}