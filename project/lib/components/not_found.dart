import 'package:UniVerse/main_screen/components/body.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import '../components/faq_item.dart';
import '../find_screen/maps_screen/map_page_web.dart';
import '../consts/color_consts.dart';

class PageNotFound extends StatelessWidget {
  PageNotFound({super.key});

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(                    //Zona principal
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/web/404.png"),
              fit: BoxFit.cover
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomWebBar(),
            Spacer(),
            Text(
              "Não encontrámos o que procuras...",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      text: "O Universo tem muito mais para explorar\nPara voltares à página inicial clica ",
                      style: TextStyle(
                        color:cDirtyWhiteColor,
                        fontSize: 20
                      ),
                      children: <TextSpan> [
                        TextSpan(
                          text: 'aqui.',style: TextStyle(decoration: TextDecoration.underline),
                        )
                      ]
                  ),
                ),
              ),
            ),
            SizedBox(height: 25,),
            Spacer(),
            Row(
              children: [
                Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Imagem de pixabay.com",
                      style: TextStyle(
                        color: cDirtyWhite
                      ),),
                    )
              ],
            )
          ],
        ),
      ),
    );
  }
}
