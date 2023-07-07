
import 'dart:io';
import 'package:UniVerse/utils/report/report_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../components/confirm_dialog_box.dart';
import '../components/default_button_simple.dart';
import '../components/description_field.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../components/web/web_menu.dart';
import '../consts/color_consts.dart';
import '../login_screen/login_app.dart';

class ReportScreenWeb extends StatefulWidget {
  const ReportScreenWeb({super.key});

  @override
  State<ReportScreenWeb> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreenWeb> {
  bool isLoading = false;
  late TextEditingController titleController;
  late TextEditingController locationController;
  late TextEditingController descriptionController;
  Uint8List imageUint8 = Uint8List(8);
  File? pickedImage;

  @override
  void initState() {
    titleController = TextEditingController();
    locationController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void submitButtonPressed(title, location, description) async {
    bool areControllersCompliant = Report.areCompliant(
        title, location, description);
    if (!areControllersCompliant) {
      showDialog(context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Ups!",
              descriptions: "Existem campos vazios. Preenche-os, por favor.",
              text: "OK",
            );
          }
      );
    }
    else if (pickedImage == null) {
      showDialog(context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Ups!",
              descriptions: "Parece que não adicionaste nenhuma fotgrafia do problema. Precisamos que o faças.",
              text: "OK",
            );
          }
      );
    } else {
      showDialog(
          context: context,
          builder: (_) =>
              ConfirmDialogBox(
                  descriptions: "A submissão de um report é validada. Qualquer submissão inválida ou que desrespeite as nossas regras, resultará na suspensão da conta e no subsequente aviso aos serviços da faculdade.",
                  press: () async {
                    Navigator.pop(context);
                    var response = await Report.send(title, location, description, imageUint8);
                    if (response == 200) {
                      showDialog(context: context,
                          builder: (BuildContext context) {
                            return CustomDialogBox(
                              title: "Obrigado!",
                              descriptions: "Já recebemos a tua submissão.",
                              text: "OK",
                            );
                          }
                      );
                    } else if (response == 401) {
                      showDialog(context: context,
                          builder: (BuildContext context) {
                            return CustomDialogBox(
                              title: "Ups!",
                              descriptions: "Parece que a tua sessão expirou. Inicia sessão novamente, por favor.",
                              text: "OK",
                              press: () {
                                context.go("/home");
                              }
                            );
                          }
                      );
                    } else if (response == 403) {
                      showDialog(context: context,
                          builder: (BuildContext context) {
                            return CustomDialogBox(
                                title: "Ups!",
                                descriptions: "Parece que não tens permissões para esta operação.",
                                text: "OK",
                                press: () {
                                  context.go("/personal");
                                }
                            );
                          }
                      );
                    } else
                      context.go('/error');
                  }
              ));
    }
  }

    @override
    Widget build(BuildContext context) {
      Size size = MediaQuery
          .of(context)
          .size;
      return Row(
          children: [
            WebMenu(width: size.width / 9, height: size.height / 1.15,),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30, top: 20, bottom: 20),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Image.asset("assets/titles/report.png", scale: 4.5,)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30, top: 15, bottom: 15),
                    child: const Text(
                      "Encontraste um problema no campus? Preenche os campos abaixo para que possamos conhecer a situação e agir o mais rapidamente possível.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 15
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30, top: 15, bottom: 15),
                    child: const Text(
                      "Todos os campos são obrigatórios",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.redAccent
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      height: size.height / 1.25,
                      width: size.width / 2,
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10),
                      margin: EdgeInsets.only(left: 250, right: 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyTextField(controller: titleController,
                            hintText: 'Introduz um título',
                            obscureText: false,
                            label: 'Título',
                            icon: Icons.title,),
                          MyTextField(controller: locationController,
                            hintText: 'Onde econtraste o problema?',
                            obscureText: false,
                            label: 'Localização',
                            icon: Icons.location_on_outlined,),
                          DescriptionField(label: "Descrição", max:300, controller: descriptionController),
                          InkWell(
                            onTap: () async {
                              try {
                                final ImagePicker picker = ImagePicker();
                                XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  File img = File(image.path);
                                  var f = await image.readAsBytes();
                                  if(f.lengthInBytes > 5000000) {
                                    print("REACHED!!!!!!!");
                                    showDialog(context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialogBox(
                                            title: "Ups!",
                                            descriptions: "A imagem excede o tamanho máximo permitido de 5 MB.",
                                            text: "OK",
                                          );
                                        }
                                    );
                                    return;
                                  }
                                  imageUint8 = f;
                                  setState(() {
                                    pickedImage = img;
                                  });
                                }
                              } on PlatformException catch (e) {
                                showDialog(context: context,
                                    builder: (BuildContext context) {
                                      return CustomDialogBox(
                                        title: "Ups!",
                                        descriptions: "Não conseguimos obter a imagem que escolheste. Tenta novamente, por favor.",
                                        text: "OK",
                                      );
                                    }
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 25, top: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Icon(Icons.camera_alt_outlined,
                                        color: cDarkBlueColor),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: pickedImage != null
                                        ? Container(
                                      height: size.width / 8,
                                      width: size.width / 4,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              15)
                                      ),
                                      child: Image.memory(
                                          imageUint8, fit: BoxFit.scaleDown,
                                          scale: 5),
                                    )
                                        : Text(
                                      "Adciona uma foto do problema aqui (max 5 MB)",
                                      style: TextStyle(
                                          color: cDarkBlueColor
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          isLoading
                              ? Container(
                              padding: EdgeInsets.all(10),
                              width: 150,
                              child: const LinearProgressIndicator(
                                color: cPrimaryColor,
                                backgroundColor: cPrimaryOverLightColor,
                              )
                          )
                              : Column(
                            children: [
                              DefaultButtonSimple(
                                  text: "SUBMETER",
                                  color: cPrimaryColor,
                                  press: () {
                                    submitButtonPressed(titleController.text,
                                        locationController.text,
                                        descriptionController.text);
                                  },
                                  height: 20),
                            ],
                          ),
                        ],
                      )
                  ),
                  //MyTextField(controller: locationController, hintText: '', obscureText: true, label: 'Palavra-passe', icon: Icon(Icons.lock_outline),),
                ]
            ),

          ]
      );
    }  }