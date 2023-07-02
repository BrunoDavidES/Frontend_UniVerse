import 'dart:convert';
import 'dart:io';

import 'package:UniVerse/components/500.dart';
import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_app.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_body_app.dart';
import 'package:UniVerse/utils/camera/camera_screen.dart';
import 'package:UniVerse/utils/report/report_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../Components/default_button.dart';
import '../components/app/500_app_with_bar.dart';
import '../components/confirm_dialog_box.dart';
import '../components/default_button_simple.dart';
import '../components/description_field.dart';
import '../components/my_date_field.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../components/url_launchable_item.dart';
import '../components/web/web_menu.dart';
import '../components/web_menu_card.dart';
import '../consts/color_consts.dart';
import '../info_screen/universe_info_app.dart';
import '../login_screen/login_app.dart';
import '../register_screen/register_app.dart';
import '../register_screen/register_web.dart';
import '../utils/connectivity.dart';
import '../utils/users/user_data.dart';
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
  //late TextEditingController departmentController;
  late TextEditingController locationController;
  //late TextEditingController timeController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController descriptionController;
  late String isItPaid;
  late String isItPublic;
  Uint8List imageUint8 = Uint8List(8);
  File? pickedImage;

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

  void submitButtonPressed(String title, String location, String description) async {
    bool areControllersCompliant = Report.isCompliant(title, location, description);
    if (!areControllersCompliant) {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialogBox(
              title: "Ups!",
              descriptions: "Existem campos vazios. Preenche-os, por favor.",
              text: "OK",
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    }
    //else if(File.isEmpty)
    else{
      var response = await Report.send(
          title, location, description);
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
      } else if (response == 403) {
        showDialog(context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                  title: "Ups!",
                  descriptions: "Parece que não iniciaste sessão na tua conta.",
                  text: "OK",
                  press: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPageApp()));
                  }
              );
            }
        );
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                Error500WithBar(i: 3,
                    title: Image.asset(
                      "assets/app/login.png", scale: 6,))));
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String job = User.getJob();
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
                                  submitButtonPressed(titleController.text, locationController.text, descriptionController.text);
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