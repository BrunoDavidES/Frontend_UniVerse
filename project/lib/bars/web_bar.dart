import 'package:UniVerse/components/default_button_simple.dart';
import 'package:UniVerse/login_screen/login_web.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Components/default_button.dart';
import '../consts/color_consts.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

class CustomWebBar extends StatelessWidget {
  bool isUserLogged = true;

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
          onTap: () {

    },
      child: Image.asset("assets/web/logo.png",
        scale: 5.5,
        alignment: Alignment.center,
      ),
    ),
            SizedBox(width:5),
            InkWell(
              onTap: () {
               launchUrl(Uri.parse("https://www.fct.unl.pt/"));
              },
              child: Image.asset("assets/web/logoNova.png",
                scale: 30,
                alignment: Alignment.center,
              ),
            ),
    //Image.asset("assets/web/combo_logo.png",
    //    scale: 6,
    //    alignment: Alignment.center,),
    const Spacer(),
    DefaultButtonSimple(
    text: "Início",
    press: () {

    Navigator.pushNamed(context, '/home');
    }, height: 20,
    ),
    DefaultButtonSimple(
    text: "Procurar",
    press: () {
    Navigator.pushNamed(context, '/find');
    },
    height: 20,
    ),
    DefaultButtonSimple(
    text: "Notícias",
    press: () {
    Navigator.pushNamed(context, '/news');
    },
    height: 20,
    ),
    DefaultButtonSimple(
    text: "Eventos",
    press: () {
    Navigator.pushNamed(context, '/events');
    },
    height: 20,
    ),
    DefaultButtonSimple(
    text: "Ajuda",
    press: () {
    Navigator.pushNamed(context, '/help');
    },
    height: 20,
    ),
    /*isUserLogged
    ? (
      child: Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    border: Border.all(
    color: cPrimaryColor,
    width: 3,
    )
    ),
    child: Text(
    "FRANCISCO",
    style: const TextStyle(
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
      itemBuilder: (context) {
        return List.generate(
          5,
              (index) {
            return PopupMenuItem(
              child: Text('button no $index'),
            );
          },
        );
      },
    )
    :*/DefaultButton(
    text: "Área Pessoal",
    press: () {
    //Navigator.pushNamed(context, '/personal/main');
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
    /*showDialog(
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
            },*/
    ],

    ),
    );
    }
}