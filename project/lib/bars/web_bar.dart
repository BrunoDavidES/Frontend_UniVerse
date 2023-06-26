
import 'package:UniVerse/bars/components/popup_item.dart';
import 'package:UniVerse/components/default_button_simple.dart';
import 'package:UniVerse/login_screen/functions/auth.dart';
import 'package:UniVerse/login_screen/login_web.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Components/default_button.dart';
import 'package:go_router/go_router.dart';
import '../consts/color_consts.dart';

class CustomWebBar extends StatelessWidget {
  const CustomWebBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 30,
            color: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () => context.go('/home'),
            child: Image.asset("assets/web/logo.png",
              scale: 5.5,
              alignment: Alignment.center,
            ),
          ),
          const SizedBox(width:5),
          InkWell(
            onTap: () {
              launchUrl(Uri.parse("https://www.fct.unl.pt/"));
            },
            child: Image.asset("assets/web/logoNova.png",
              scale: 30,
              alignment: Alignment.center,
            ),
          ),
          const Spacer(),
          DefaultButtonSimple(
            text: "Início",
            color: cPrimaryColor,
            press: () => context.go('/home'),
            height: 20,
          ),
          DefaultButtonSimple(
            text: "Procurar",
            color: cPrimaryColor,
            press: () => context.go('/find'),
            height: 20,
          ),
          DefaultButtonSimple(
            text: "Notícias",
            color: cPrimaryColor,
            press: () => context.go('/news'),
            height: 20,
          ),
          DefaultButtonSimple(
            text: "Eventos",
            color: cPrimaryColor,
            press: () {
              Navigator.pushNamed(context, '/events');
            },
            height: 20,
          ),
          DefaultButtonSimple(
            text: "Ajuda",
            color: cPrimaryColor,
            press: () {
              Navigator.pushNamed(context, '/help');
            },
            height: 20,
          ),
         Authentication.userIsLoggedIn
              ? const PopUpMenu()
              : DefaultButton(
              text: "LOGIN",
              press: () {
                showDialog(
                    context: context,
                    builder: (_) => const AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(10.0)
                          )
                      ),
                      content: LoginPageWeb(),
                    )
                );
              }),
        ],

      ),
    );
  }
}