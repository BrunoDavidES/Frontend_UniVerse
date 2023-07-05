import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../consts/color_consts.dart';
import '../../utils/authentication/auth.dart';
import '../../utils/user/user_data.dart';

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
            context.go('/personal');
          } else {
            var response = await Authentication.revoke();
            if(response==200)
              context.go('/home');
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
            UniverseUser.getName(),
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
        )
    );
  }
}