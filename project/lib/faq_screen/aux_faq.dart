import 'package:UniVerse/components/faq_item.dart';
import 'package:UniVerse/faq_screen/list_faqs.dart';
import 'package:UniVerse/main_screen/components/about_bottom.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import 'package:go_router/go_router.dart';
import '../components/default_button_simple.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../consts/color_consts.dart';
import '../find_screen/findTest/right_side.dart';
import '../main_screen/components/about_bottom_body.dart';
import '../utils/connectivity.dart';
import '../utils/faq/faq_utils.dart';

class FAQWebPageAux extends StatefulWidget {
  const FAQWebPageAux({super.key});

  @override
  State<FAQWebPageAux> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<FAQWebPageAux> {
  late TextEditingController emailController;
  late TextEditingController titleController;
  late TextEditingController messageController;
  bool isLoading = false;

  @override
  void initState() {
    titleController = TextEditingController();
    emailController = TextEditingController();
    messageController = TextEditingController();
    super.initState();
  }

  void submitButtonPressed(email, title, message) {
   if(!Faq.areCompliant(email, title, message)) {
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
        context.go("/error");
      }
    }
  }

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
                question: 'O que é a UniVerse?',
                answer: 'A UniVerse é a mais recente plataforma que vai trazer uma nova vida ao campus da tua faculdade!\nCom todo o Universo da NOVA FCT num só lugar, vai ser mais fácil encontrares informações básicas, avisos, eventos, organizares o teu dia-a-dia e muito mais. Junta-te já ao Universo!',
              ),
              FAQbox(
                question: 'É necessário criar uma conta?',
                answer: 'Não. Podes explorar a plataforma, de forma limitada, sem registo e/ou sessão iniciada. No entanto, aconselhamos-te a fazê-lo para que possas usufruir de todas as vantagens que te trazemos. Insere o teu e-mail institucional, nome e uma palavra-passe e está feito. Fazes agora parte da UniVerse!',
              ),
              FAQbox(
                question: 'Não sou da faculdade, posso visitar a UniVerse?',
                answer: 'Claro! Queremos que o Universo chegue a todos. Por isso, podes ver as mais recentes notícias e próximos eventos abertos a visitantes. Podes também encontrar informaçóes básicas para que não tenhas qualquer dúvida, estando o registo na plataforma aberto apenas a pessoas com vínculo à FCT.',
              ),
              FAQbox(
                question: 'Por que não me consigo registar?',
                answer: 'Se não pertences a esta faculdade, não te poderás registar nesta plataforma. Contudo, e se estiveres vinculado à faculdade, o registo pode falhar por não te estares a inscrever com o teu e-mail institucional, a palavra-passe que escolheste não seguir as restrições de, no mínimo, 6 caracteres, 1 número e 1 letra maiúscula ou porque algém se já registou com o teu e-mail (neste caso, por favor contacta-nos).',
              ),
              FAQbox(
                question: 'Quem é a CAPI CREW?',
                answer: 'A CAPI CREW são os criadores da UniVerse. São 5 estudantes do curso de Engenharia Informática da NOVA FCT.',
              ),
              FAQbox(
                question: 'Que linguagens de programação foram utilizadas para a criação da UniVerse?',
                answer: 'Alcançámos o Universo usando Java, JavaScript, HTML, CSS e Dart.',
              ),
              FAQbox(
                question: 'Onde posso saber mais sobre a UniVerse?',
                answer: 'Não queremos que o Universo esteja distante, por isso, podes acompanhar-nos no Instagram em @universe.fct',
              ),
              FAQbox(
                question: 'Onde posso receber ajuda sobre a FCT?',
                answer: 'Visita a página de Ajuda do website da NOVA FCT ou recolhe informação na nossa página de Procurar.',
              ),
              FAQbox(
                question: 'A minha pergunta não foi respondida..',
                answer: 'Se tiveres alguma dúvida, utiliza o nosso formulário de contacto para respondermos o mais brevemente possível.',
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
                        submitButtonPressed(emailController.text.trim(), titleController.text, messageController.text);
                        setState(() {
                          isLoading = true;
                        });
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