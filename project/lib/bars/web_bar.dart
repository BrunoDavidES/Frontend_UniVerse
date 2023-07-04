import 'package:UniVerse/bars/components/popup_item.dart';
import 'package:UniVerse/components/default_button_simple.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:UniVerse/login_screen/login_web.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Components/default_button.dart';
import 'package:go_router/go_router.dart';
import '../consts/color_consts.dart';

class CustomWebBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 900;
    final bool isSmallScreen2 = MediaQuery.of(context).size.width < 700;

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
          if(!isSmallScreen2)
            InkWell(
            onTap: () => context.go('/home'),
            child: Image.asset(
              "assets/web/logo.png",
              scale: 5.5,
              alignment: Alignment.center,
            ),
          ),
          const SizedBox(width: 5),
          InkWell(
            onTap: () {
              launchUrl(Uri.parse("https://www.fct.unl.pt/"));
            },
            child: Image.asset(
              "assets/web/logoNova.png",
              scale: 30,
              alignment: Alignment.center,
            ),
          ),
          const Spacer(),
          if (!isSmallScreen)
              Row(
                children: [
                  _buildNavButton(context, "Início", "/home"),
                  _buildNavButton(context, "Procurar", "/find"),
                  _buildNavButton(context, "Notícias", "/news"),
                  _buildNavButton(context, "Eventos", "/events"),
                  _buildNavButton(context, "Ajuda", "/help"),
                ],
              ),
          if (Authentication.userIsLoggedIn)
            const PopUpMenu()
          else if (isSmallScreen)
            Row(
              children: [
                PopupMenuButton<String>(
                  itemBuilder: (_) => [
                    PopupMenuItem<String>(
                      child: Text("Início"),
                      value: "/home",
                    ),
                    PopupMenuItem<String>(
                      child: Text("Procurar"),
                      value: "/find",
                    ),
                    PopupMenuItem<String>(
                      child: Text("Notícias"),
                      value: "/news",
                    ),
                    PopupMenuItem<String>(
                      child: Text("Eventos"),
                      value: "/events",
                    ),
                    PopupMenuItem<String>(
                      child: Text("Ajuda"),
                      value: "/help",
                    ),
                  ],
                  onSelected: (route) {
                    context.go(route);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Icon(Icons.more_vert),
                  ),
                ),
                DefaultButton(
                  text: "LOGIN",
                  press: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        content: LoginPageWeb(),
                      ),
                    );
                  },
                ),
              ],
            )
          else
            DefaultButton(
              text: "LOGIN",
              press: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    content: LoginPageWeb(),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String text, String route) {
    return SizedBox(
      height: 40,// Adjust the width value to control the button width
      child: DefaultButtonSimple(
        press: () => context.go(route),
        text: text,
        height: 20,
        color: cPrimaryColor,
        ),
      );
  }
}