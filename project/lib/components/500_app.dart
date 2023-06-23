import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

class Error500App extends StatelessWidget {
  const Error500App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.height);
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height/8,),
                Image.asset("assets/app/ufo.png",scale: 8,),
                Text("Ups!",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                        SizedBox(height: 5,),

                        Text("Parece que perdemos contacto com o Universo. Dá-nos alguns minutos para que possamos voltar a estar em órbita.",
                          textAlign: TextAlign.center,)
                      ],
                    ),
      );
  }
}