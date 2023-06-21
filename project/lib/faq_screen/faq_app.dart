import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';

import '../components/default_button_simple.dart';
import '../components/faq_item.dart';
import 'list_faqs.dart';

class FaqApp extends StatelessWidget {
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leadingWidth: 20,
        leading: Builder(
          builder: (context) {
            return IconButton(
                icon: const Icon(Icons.arrow_back_outlined),
                onPressed: () {Navigator.pop(context);},
                color: cDarkBlueColor);
          }
        ),
        title: Image.asset('assets/app/ajuda.png', scale: 6),
        backgroundColor: cDirtyWhiteColor,

      ),
      body: Container(                //Zona das Perguntas
        color: cDirtyWhiteColor,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top:10, left: 20),
              child: Text(
                "Perguntas mais frequentes:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: cHeavyGrey
                ),
              ),
            ),
            FAQlist(question: 'FAQ:', starts: true,),
            Padding(
              padding: EdgeInsets.only(bottom: 10, left: 20, top: 20),
              child: Text(
                "Ainda tens dúvidas? Contacta-nos!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: cHeavyGrey
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: cHeavyGrey.withOpacity(0.4),
                      width: 1
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:15),
                    child: Text(
                      "Email:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: cDarkBlueColor
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: cDarkLightBlueColor
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: cDarkLightBlueColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: cDarkBlueColor,
                            )
                        ),
                        fillColor: Colors.white60,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Colors.grey
                        )
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left:15),
                    child: Text(
                      "Assunto:",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: cDarkBlueColor
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: cDarkLightBlueColor
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: cDarkLightBlueColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: cDarkBlueColor,
                            )
                        ),
                        fillColor: Colors.white60,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Colors.grey
                        )
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left:15),
                    child: Text(
                      "Descrição:",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: cDarkBlueColor
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  TextFormField(
                    maxLines: 7,
                    maxLength: 300,
                    controller: controller,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: cDarkLightBlueColor
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: cDarkLightBlueColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: cDarkBlueColor,
                            )
                        ),
                        fillColor: Colors.white60,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Colors.grey
                        )
                    ),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      DefaultButtonSimple(
                        text: "Enviar",
                        color: cDarkBlueColor,
                        press: () {
                        },
                        height: 20,
                      ),
                      Spacer()
                    ],
                  ),
                ],
              ),
            )
                ],
              ),
      ),
    );
  }
}
