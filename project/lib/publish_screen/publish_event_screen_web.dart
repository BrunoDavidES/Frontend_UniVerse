
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../components/confirm_dialog_box.dart';
import '../components/default_button_simple.dart';
import '../components/my_date_field.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../components/web/web_menu.dart';
import '../consts/color_consts.dart';
import '../utils/events/event_data.dart';
import '../utils/user/user_data.dart';
import 'organized_events_screen.dart';

class PublishEventScreenWeb extends StatefulWidget {
  const PublishEventScreenWeb({super.key});

  @override
  State<PublishEventScreenWeb> createState() => _PublishEventScreenState();
}

class _PublishEventScreenState extends State<PublishEventScreenWeb> {
  bool isLoading = false;
  late TextEditingController titleController;
  late TextEditingController capacityController;
  late TextEditingController locationController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController descriptionController;
  String? isItPaid;
  String? isItPublic;
  Uint8List imageUint8 = Uint8List(8);
  File? thumbnail;

  @override
  void initState() {
    titleController = TextEditingController();
    locationController = TextEditingController();
    capacityController = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void submitEventButtonPressed(title, startDate, endDate, isPublic, isItPaid, location, capacity, description) async {
      bool areControllersCompliant = Event.areCompliant(title, startDate, location, capacity, description);
      if (!areControllersCompliant) {
        showDialog(context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: "Ups!",
                descriptions: "Existem campos obrigatórios vazios. Preenche-os, por favor.",
                text: "OK",
              );
            }
        );
      } else if (thumbnail == null) {
        showDialog(context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: "Ups!",
                descriptions: "Parece que não adicionaste nenhuma thumbnail do evento. Precisamos que o faças",
                text: "OK",
              );
            }
        );
      } else {
        showDialog(
            context: context,
            builder: (_) =>
                ConfirmDialogBox(
                    descriptions: "A submissão de um evento é validada. Qualquer submissão inválida ou que desrespeite as nossas regras, resultará na suspensão da conta e no subsequente aviso aos serviços da faculdade.",
                    press: () async {
                      var response = await Event.post(
                          title,
                          startDate,
                          endDate,
                          isPublic,
                          isItPaid,
                          location,
                          capacity,
                          description,
                          imageUint8);
                      if (response == 200) {
                        showDialog(context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: "Sucesso!",
                                descriptions: "Já recebemos a tua submissão. Após validação, constará no feed da UniVerse!",
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
                                },
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
                                },
                              );
                            }
                        );
                      } else if (response == 400) {
                        showDialog(context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: "Ups!",
                                descriptions: "Aconteceu um erro inesperado! Por favor, tenta novamente.",
                                text: "OK",
                              );
                            }
                        );
                      } else {
                        context.go("/error");
                      }
                    }
                ));
      }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String job = UniverseUser.getJob();
    return Row(
        children: [
          WebMenu(width: size.width/9, height: size.height/1.25,),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Image.asset("assets/titles/organize.png", scale: 3.5,)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:30, top:15, bottom: 15),
                  child: Text(
                    "Por seres $job, podes publicar o evento que estás a organizar no feed de Eventos da Universe!",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width:size.width/1.5),
                    DefaultButtonSimple(
                        text: "VER OS EVENTOS QUE ORGANIZEI",
                        color: cHeavyGrey,
                        press: () {
                          showDialog(
                              context: context,
                              builder: (_) => const AlertDialog(
                                backgroundColor: cDirtyWhiteColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(10.0)
                                      )
                                  ),
                                  content: OrganizedEventsFeed()
                              )
                          );
                        },
                        height: 5),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width/2.5,
                      margin: EdgeInsets.only(left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyTextField(controller: titleController, hintText: 'Introduz um título', obscureText: false, label: 'Título', icon: Icons.title,),
                          MyTextField(controller: locationController, hintText: 'Onde vai acontecer o evento?', obscureText: false, label: 'Localização', icon: Icons.location_on_outlined,),
                          MyTextField(controller: capacityController, hintText: 'Qual é a capacidade do evento?', obscureText: false, label: 'Capacidade', icon: Icons.people,),
                          MyDateField(controller: startDateController, label: "Data",),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                            child: Text(
                              "Este evento decorre em mais do que um dia? Adiciona a data de fim.",
                              style: TextStyle(
                                color: cDarkBlueColor,
                              ),
                            ),
                          ),
                          MyDateField(controller: endDateController, label: "Data de fim",),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right:20, top: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Este evento vai ser pago?",
                                  style: TextStyle(
                                      color: cDarkBlueColor
                                  ),
                                ),
                                SizedBox(width: 15),
                                ToggleSwitch(
                                  customWidths: [60.0, 60.0],
                                  cornerRadius: 15.0,
                                  activeBgColors: [[cDarkLightBlueColor], [cDarkLightBlueColor]],
                                  activeFgColor: Colors.white,
                                  inactiveBgColor: cDirtyWhiteColor,
                                  inactiveFgColor: cHeavyGrey,
                                  totalSwitches: 2,
                                  labels: ['Sim', 'Não'],
                                  onToggle: (index) {
                                    if(index==0)
                                      isItPaid = 'yes';
                                    else isItPaid = 'no';
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right:20, top: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Este evento está aberto apenas à comunidade FCTense?",
                                  style: TextStyle(
                                      color: cDarkBlueColor
                                  ),
                                ),
                                SizedBox(width: 15,),
                                ToggleSwitch(
                                  customWidths: [60.0, 60.0],
                                  cornerRadius: 15.0,
                                  activeBgColors: [[cDarkLightBlueColor], [cDarkLightBlueColor]],
                                  activeFgColor: Colors.white,
                                  inactiveBgColor: cDirtyWhiteColor,
                                  inactiveFgColor: cHeavyGrey,
                                  totalSwitches: 2,
                                  labels: ['Sim', 'Não'],
                                  onToggle: (index) {
                                    if(index==0)
                                      isItPublic = 'yes';
                                    else isItPublic = 'no';
                                  },
                                ),
                              ],
                            ),
                          ),
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
                                    thumbnail = img;
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
                            child:  Container(
                              padding: const EdgeInsets.only(left: 20, top: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:5),
                                    child: Icon(Icons.camera_alt_outlined, color: cDarkBlueColor),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:12),
                                    child: thumbnail!=null
                                        ?Text(
                                      "Thumbnail adicionada!",
                                      style: TextStyle(
                                          color: Colors.green,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                        : Text(
                                      "Adciona a thumnail do evento aqui",
                                      style: TextStyle(
                                          color: cDarkBlueColor
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 30,),
                    Column(
                      children: [
                        Container(
                          width: size.width/2.5,
                          child: TextFormField(
                            maxLength: 500,
                            maxLines: 15,
                            controller: descriptionController,
                            decoration: InputDecoration(
                                labelText: "Descrição",
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
                                hintText: "Descreve o evento",
                                hintStyle: TextStyle(
                                    color: Colors.grey
                                )
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
                                                submitEventButtonPressed(
                                                    titleController.text,
                                                    startDateController.text,
                                                    endDateController.text,
                                                    isItPublic,
                                                    isItPaid,
                                                    locationController.text,
                                                    capacityController.text,
                                                    descriptionController.text,);
                                },
                                height: 20),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 50,)
              ]
          ),

        ]
    );


  }
}