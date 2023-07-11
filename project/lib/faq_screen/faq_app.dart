import 'package:UniVerse/consts/color_consts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/500.dart';
import '../components/default_button_simple.dart';
import '../components/faq_item.dart';
import '../components/simple_dialog_box.dart';
import '../utils/connectivity.dart';
import 'list_faqs.dart';
import '../utils/faq/faq_utils.dart';

class FaqApp extends StatefulWidget {

  @override
  State<FaqApp> createState() => _ScreenState();
}

class _ScreenState extends State<FaqApp> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  bool isLoading = false;
  late TextEditingController emailController;
  late TextEditingController titleController;
  late TextEditingController messageController;

  @override
  void initState() {
    emailController = TextEditingController();
    titleController = TextEditingController();
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
  void dispose() {
    emailController.dispose();
    titleController.dispose();
    messageController.dispose();
    super.dispose();
  }
  
  void submitButtonPressed(email, title, message) {
    if(!kIsWeb && _source.keys.toList()[0]==ConnectivityResult.none) {
      showDialog(context: context,
          builder: (BuildContext context){
            return const CustomDialogBox(
              title: "Sem internet",
              descriptions: "Parece que não estás ligado à internet! Para submeteres a tua pergunta precisas de te ligar a uma rede.",
              text: "OK",
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    } else if(!Faq.areCompliant(email, title, message)) {
      showDialog(context: context,
          builder: (BuildContext context){
            return const CustomDialogBox(
              title: "Ups!",
              descriptions: "Existem campos vazios. Preenche-os, por favor.",
              text: "OK",
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    } else {
      var response = Faq.request(title, email, message);
      if(response == 200) {
        showDialog(context: context,
            builder: (BuildContext context){
              return const CustomDialogBox(
                title: "Sucesso",
                descriptions: "Recebemos a tua pergunta. Vamos responder-te, brevemente.",
                text: "OK",
              );
            }
        );
        setState(() {
          isLoading = false;
        });
      }  else {
        Navigator.pop(context);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Error500()));
      }
      }
    }

  
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
        title: Image.asset('assets/titles/help.png', scale: 6),
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
                         submitButtonPressed(emailController.text.trim(), titleController.text, messageController.text);
                         setState(() {
                           isLoading = true;
                         });
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
