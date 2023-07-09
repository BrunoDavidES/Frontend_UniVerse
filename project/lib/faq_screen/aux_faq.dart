import 'package:UniVerse/components/faq_item.dart';
import 'package:UniVerse/faq_screen/list_faqs.dart';
import 'package:UniVerse/main_screen/components/about_bottom.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import '../components/default_button_simple.dart';
import '../components/text_field.dart';
import '../consts/color_consts.dart';
import '../find_screen/findTest/right_side.dart';
import '../main_screen/components/about_bottom_body.dart';
import '../utils/faq/faq_utils.dart';

class FAQWebPageAux extends StatelessWidget {
  TextEditingController? controller;

  FAQWebPageAux({super.key});

  ScrollController yourScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width/2.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Perguntas mais frequentes:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: cHeavyGrey
                    ),
                  ),
                ),
                FAQbox(
                  question: 'É necessário criar uma conta?',
                  answer: 'Não! \nSe és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito. \n',
                ),
                FAQbox(
                  question: 'É necessário criar uma conta?',
                  answer: 'Não! Se és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito.',
                ),
                FAQbox(
                  question: 'É necessário criar uma conta?',
                  answer: 'Não! Se és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito.',
                ),
                FAQbox(
                  question: 'É necessário criar uma conta?',
                  answer: 'Não! Se és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito.',
                ),
                FAQbox(
                  question: 'É necessário criar uma conta?',
                  answer: 'Não! Se és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito.',
                ),
                FAQbox(
                  question: 'É necessário criar uma conta?',
                  answer: 'Não! Se és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito.',
                ),FAQbox(
                  question: 'É necessário criar uma conta?',
                  answer: 'Não! Se és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito.',
                ),
                FAQbox(
                  question: 'É necessário criar uma conta?',
                  answer: 'Não! Se és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito.',
                ),
                FAQbox(
                  question: 'É necessário criar uma conta?',
                  answer: 'Não! Se és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito.',
                ),
              ],
            ),
          ),
          SizedBox(width: 50),
          Container(
            width: size.width/2.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Ainda tens dúvidas? Contacta-nos!",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: cHeavyGrey
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: cHeavyGrey.withOpacity(0.4),
                          width: 1
                      )
                  ),
                  child: Column(
                    children: [
                      Row(
                          children: [
                            Text(
                              "Email:",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: cDarkBlueColor
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: TextFormField(
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
                                    fillColor: cDirtyWhiteColor,
                                    filled: true,
                                    hintStyle: TextStyle(
                                        color: Colors.grey
                                    )
                                ),
                              ),
                            ),
                          ]
                      ),
                      SizedBox(height: 10),
                      Row(
                          children: [
                            Text(
                              "Assunto:",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: cDarkBlueColor
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: TextFormField(
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
                                    fillColor: cDirtyWhiteColor,
                                    filled: true,
                                    hintStyle: TextStyle(
                                        color: Colors.grey
                                    )
                                ),
                              ),
                            ),
                          ]
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Descrição:",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: cDarkBlueColor
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: TextFormField(
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
                                  fillColor: cDirtyWhiteColor,
                                  filled: true,
                                  hintStyle: TextStyle(
                                      color: Colors.grey
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      DefaultButtonSimple(
                        text: "Enviar",
                        color: cDarkBlueColor,
                        press: () {
                         // Faq.requestHelp(title, email, message);
                        },
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }
}