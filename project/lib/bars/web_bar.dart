import 'package:UniVerse/components/default_button_simple.dart';
import 'package:UniVerse/login_screen/functions/auth.dart';
import 'package:UniVerse/login_screen/login_web.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Components/default_button.dart';
import '../consts/color_consts.dart';

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
            Navigator.pushNamed(context, "/home");
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
            /* DefaultButton(
              text: "Francisco".toUpperCase(),
              press: () {*/

      /*PopupMenuButton(
        tooltip: "Opções",
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: cPrimaryColor,
            border: Border.all(
              color: cPrimaryColor,
              width: 3,
            )
          ),
          child: Text(
            "FRANCISCO",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        ),
        offset: Offset(0.0, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          child: Row(
            children: [
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
          onTap: () {
            //Navigator.pushNamed(context, '/personal/main');
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
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
          onTap: () async{
            //Navigator.pushNamed(context, '/personal/main');
            var response = Authentication.revoge();
            if(response==200)
              Navigator.pushNamed(context, '/home');
          },
        ),
      ]
    )
   // }
    //)*/
         DefaultButton(
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
            },
          ),
        ],
            },*/
    ],

    ),
    );
    }
}