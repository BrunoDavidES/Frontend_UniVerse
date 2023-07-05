import 'dart:convert';
import 'dart:io';

import 'package:UniVerse/components/500.dart';
import 'package:UniVerse/components/my_date_field.dart';
import 'package:UniVerse/components/my_image_picker.dart';
import 'package:UniVerse/reset_pwd_screen/reset_password_app.dart';
import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_app.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_body_app.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../components/default_button_simple.dart';
import '../../components/simple_dialog_box.dart';
import '../../components/text_field.dart';
import '../../consts/color_consts.dart';
import '../../utils/connectivity.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../components/confirm_dialog_box.dart';
import '../utils/events/event_data.dart';
import 'organized_events_screen.dart';


class PublishScreenApp extends StatefulWidget {
  const PublishScreenApp({super.key});

  @override
  State<PublishScreenApp> createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreenApp> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  bool isLoading = false;
  late TextEditingController titleController;
  late TextEditingController capacityController;
  //late TextEditingController departmentController;
  late TextEditingController locationController;
  //late TextEditingController timeController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController descriptionController;
  late String isItPaid;
  late String isItPublic;
  late File thumbnail;
  Uint8List imageUint8 = Uint8List(8);

  @override
  void initState() {
    titleController = TextEditingController();
    locationController = TextEditingController();
    capacityController = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    descriptionController = TextEditingController();
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
    super.dispose();
  }

  void submitEventButtonPressed(title, startDate, endDate, isPublic, isItPaid, location, capacity, description, File thumbnail) async {
    if(_source.keys.toList()[0]==ConnectivityResult.none) {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialogBox(
              title: "Sem internet",
              descriptions: "Parece que não estás ligado à internet! Para poderes submeter um evento no feed, tens de te ligar a uma rede.",
              text: "OK",
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    } else {
      bool areControllersCompliant = Event.areCompliant(title, startDate, location, capacity, description);
      if (!areControllersCompliant) {
        showDialog(context: context,
            builder: (BuildContext context){
              return CustomDialogBox(
                title: "Ups!",
                descriptions: "Existem campos obrigatórios vazios. Preenche-os, por favor.",
                text: "OK",
              );
            }
        );
        setState(() {
          isLoading = false;
        });
      } else {
        var response = await Event.post(title, startDate, endDate, isPublic, isItPaid, location, capacity, description,  imageUint8);
        if (response == 200) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Sucesso!",
                  descriptions: "Já recebemos a tua submissão. Após validação, constará no feed da UniVerse!",
                  text: "OK",
                );
              }
          );
        } else if (response==401) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Ups!",
                  descriptions: "Parece que não tens sessão iniciada.",
                  text: "OK",
                );
              }
          );
        } else if (response==403) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Ups!",
                  descriptions: "Parece que não tens permissões para esta operação.",
                  text: "OK",
                );
              }
          );
        } else if (response==400) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Ups!",
                  descriptions: "Aconteceu um erro inesperado! Por favor, tenta novamente.",
                  text: "OK",
                );
              }
          );
        }else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Error500()));
        }
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String job = UniverseUser.getJob();
    Uint8List imageUint8 = Uint8List(8);
    File? pickedImage;
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      appBar: AppBar(
        title: Image.asset("assets/titles/organize.png", scale:4.5),
        leading: Builder(
            builder: (context) {
              return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {Navigator.pop(context);},
                  color: cDarkBlueColorTransparent);
            }
        ),
        leadingWidth: 20,
        backgroundColor: cDirtyWhiteColor,
        titleSpacing: 15,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top:15),
              child: Text(
                "Por seres $job, podes publicar o evento que estás a organizar no feed de Eventos da Universe!",
                textAlign: TextAlign.justify,
              ),
            ),
            Row(
              children: [
                Spacer(),
                DefaultButtonSimple(
                    text: "VER OS EVENTOS QUE ORGANIZEI",
                    color: cHeavyGrey,
                    press: () {
                      showDialog(
                          context: context,
                          builder: (_) => const Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(10.0)
                                  )
                              ),
                              child: OrganizedEventsFeed()
                          )
                      );
                    },
                    height: 5),
              ],
            ),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Este evento vai ser pago?",
                    style: TextStyle(
                        color: cDarkBlueColor
                    ),
                  ),
                  Spacer(),
                  ToggleSwitch(
                    customWidths: [60.0, 60.0],
                    cornerRadius: 15.0,
                    activeBgColors: [[cDarkLightBlueColor], [cDarkLightBlueColor]],
                    activeFgColor: Colors.white,
                    inactiveBgColor: cDirtyWhite,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Este evento está aberto apenas à comunidade FCTense?",
                    style: TextStyle(
                        color: cDarkBlueColor
                    ),
                  ),
                  ToggleSwitch(
                    customWidths: [60.0, 60.0],
                    cornerRadius: 15.0,
                    activeBgColors: [[cDarkLightBlueColor], [cDarkLightBlueColor]],
                    activeFgColor: Colors.white,
                    inactiveBgColor: cDirtyWhite,
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
                final ImagePicker picker = ImagePicker();
                XFile? image = await picker.pickImage(source: ImageSource.gallery);
                if(image!=null) {
                  var f = await image.readAsBytes();
                  imageUint8= f;
                  setState(() {
                    pickedImage = File("a");
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.only(left: 25, top: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:5),
                      child: Icon(Icons.camera_alt_outlined, color: cDarkBlueColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:12),
                      child: pickedImage!=null
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
            Container(
              margin: const EdgeInsets.only(left: 20, right:20, top: 10),
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
                width: 150,
                child: const LinearProgressIndicator(
                  color: cPrimaryColor,
                  backgroundColor: cPrimaryOverLightColor,
                )
            )
                :  DefaultButtonSimple(
              text: "SUBMETER",
              color: cPrimaryColor,
              press: () {
                showDialog(
                    context: context,
                    builder: (_) =>
                        ConfirmDialogBox(
                            descriptions: "A submissão de um evento é previamente validada. Qualquer submissão inválida ou que desrespeite as nossas regras, resultará na suspensão da conta e aviso aos serviços da faculdade.",
                            press: () {
                              submitEventButtonPressed(
                                  titleController.text,
                                  startDateController.text,
                                  endDateController.text,
                                  isItPublic,
                                  isItPaid,
                                  locationController.text,
                                  capacityController.text,
                                  descriptionController.text,
                                  thumbnail);
                            })
                );
              }, height: 10,),
            SizedBox(height: 70,)
          ],
        ),
      ),
    );
  }
}