import 'package:UniVerse/components/faq_item.dart';
import 'package:UniVerse/faq_screen/list_faqs.dart';
import 'package:UniVerse/main_screen/components/about_bottom.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import '../components/default_button_simple.dart';
import '../components/text_field.dart';
import '../consts/color_consts.dart';
import '../find_screen/findTest/right_side.dart';
import '../main_screen/components/about_bottom_body.dart';
import '../utils/connectivity.dart';
import '../utils/faq/faq_utils.dart';

class FAQWebPageAux2 extends StatefulWidget {
  const FAQWebPageAux2({super.key});

  @override
  State<FAQWebPageAux2> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<FAQWebPageAux2> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  late TextEditingController emailController;
  late TextEditingController titleController;
  late TextEditingController messageController;
  bool isLoading = false;

  @override
  void initState() {
    titleController = TextEditingController();
    emailController = TextEditingController();
    messageController = TextEditingController();
    _connectivity.initialize();
    _connectivity.myStream.listen((source) {
      setState(() {
        _source = source;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    titleController = TextEditingController();
    messageController = TextEditingController();
    emailController = TextEditingController();

    Size size = MediaQuery
        .of(context)
        .size;
    return Column(
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
                question: 'O que é a UniVerse?',
                answer: 'A UniVerse é a mais recente plataforma que vai trazer uma nova vida ao campus da tua faculdade!\nCom todo o Universo da NOVA FCT num só lugar, vai ser mais fácil encontrares informações básicas, avisos, eventos, organizares o teu dia-a-dia e muito mais. Junta-te já ao Universo!',
              ),
              FAQbox(
                question: 'É necessário criar uma conta?',
                answer: 'Não. Estamos a trabalhar no sentido de tornar a UniVerse mais acessível para ti e, por isso, por enquanto, se fazes parte da FCT NOVA é aconselhável registares-te para não perderes os benefícios que isso traz. Insere o teu e-mail institucional, nome e uma palavra-passe e está feito. Fazes agora parte da UniVerse!',
              ),
              FAQbox(
                question: 'A UniVerse e só para pessoas da faculdade?',
                answer: 'Não! Se não fazes parte da NOVA FCT, podes fazer parte do universo. Podes ver o que é que se passa e ver os próximos eventos que irão decorrer na faculdade. Podes também procurar por informação da FCT.',
              ),
              FAQbox(
                question: 'Quem é a CAPICREW?',
                answer: 'A CAPICREW são os criadores da UniVerse. São 5 estudantes do curso de informática (MIEI) da NOVA FCT.',
              ),
              FAQbox(
                question: 'Porque é que não me consigo registar?',
                answer: 'Se não pertences á NOVA FCT não vais conseguir registar, esta aplicação tem como objetivo a facilitação de acesso de informação aos estudantes e de facilitação de informação para os que estão a oassar por cá.',
              ),FAQbox(
                question: 'Que linguagens foram utilizadas para a criação da UniVerse?',
                answer: 'Para a criação da Universe foram utilizadas uma variedade de linguagens, desde JavaScript, Java, Html, CSS a Dart.',
              ),
              FAQbox(
                question: 'Dentro da UniVerse existe algum segredo que o utilizador consiga descobrir?',
                answer: 'Pergunta interessante! Dentro da UniVerse, há uma aura de mistério que cativa a curiosidade dos utilizadores. Embora não possa confirmar nem negar explicitamente a existência de segredos, posso dizer que a plataforma foi desenvolvida com detalhes minuciosos e uma atenção cuidadosa aos pormenores.',
              ),
              FAQbox(
                question: 'Onde posso saber mais sobre a UniVerse?',
                answer: 'Não queremos que o Universo esteja distante, por isso, podes acompanhar-nos no Instagram @universe.fct',
              ),
              FAQbox(
                question: 'Quer saber alguma informação específica sobre a faculdade FCT NOVA?',
                answer: 'Vai ao site de ajuda da FCT, onde encontra a FAQ da faculdade com várias questões frequentemente perguntadas. Link: https://www.fct.unl.pt/faq#t136n17231',
              ),
            ],
          ),
        ),
        SizedBox(height: 50),
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
                              controller: emailController,
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
                              controller: titleController,
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
                            controller: messageController,
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
                        Faq.requestHelp(titleController.text, emailController.text, messageController.text);

                      },
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}