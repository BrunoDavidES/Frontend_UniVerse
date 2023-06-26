
import 'package:flutter/material.dart';


class Error500 extends StatelessWidget {
  const Error500({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height/8,),
                Image.asset("assets/images/ufo.png",scale: 8,),
                const Text("Ups!",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                        const SizedBox(height: 5,),
                        const Text("Parece que perdemos contacto com o Universo. Dá-nos alguns minutos para que possamos voltar a estar em órbita.",
                          textAlign: TextAlign.center,)
                      ],
                    ),
      );
  }
}