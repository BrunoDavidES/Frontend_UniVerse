import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

class Error500App extends StatelessWidget {
  const Error500App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Container(
        child: Column(
          children: [
            Image.asset("assets/app/ufo.png",scale: 6,),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: cDarkLightBlueColor,
                      width: 2
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text("Ups!",
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                    ),
                    Text("Parece que perdemos contacto com o Universo. Dá-nos alguns minutos para que possamos voltar a estar em órbita.",
                      textAlign: TextAlign.center,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}