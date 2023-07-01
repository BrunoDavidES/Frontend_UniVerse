import 'dart:convert';

import 'package:UniVerse/components/500.dart';
import 'package:UniVerse/login_screen/reset_password_app.dart';
import 'package:UniVerse/login_screen/reset_password_screen.dart';
import 'package:UniVerse/login_screen/reset_password_web.dart';
import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:UniVerse/personal_page_screen/personal_page_app.dart';
import 'package:UniVerse/personal_page_screen/personal_page_body_app.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Components/default_button.dart';
import '../components/app/500_app_with_bar.dart';
import '../components/default_button_simple.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../components/url_launchable_item.dart';
import '../consts/color_consts.dart';
import '../info_screen/universe_info_app.dart';
import '../personal_page_screen/personal_page_web.dart';
import '../register_screen/register_app.dart';
import '../register_screen/register_web.dart';
import '../utils/connectivity.dart';
import 'package:intl/intl.dart';

class PersonalEventCreationScreen extends StatefulWidget {
  const PersonalEventCreationScreen({super.key});

  @override
  State<PersonalEventCreationScreen> createState() => _EventCreationScreenState();
}

class _EventCreationScreenState extends State<PersonalEventCreationScreen> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  bool isLoading = false;
  late TextEditingController titleController;
  late TextEditingController locationController;
  late TextEditingController timeController;
  late TextEditingController dateController;

  @override
  void initState() {
    titleController = TextEditingController();
    locationController = TextEditingController();
    dateController = TextEditingController();
    timeController = TextEditingController();
    _connectivity.initialize();
    _connectivity.myStream.listen((source) {
      setState(() {
        _source = source;
      });
    });
    super.initState();
  }

  void submitButtonPressed(String title, String location, String date, String time) async {
    if(!kIsWeb && _source.keys.toList()[0]==ConnectivityResult.none) {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialogBox(
              title: "Sem internet",
              descriptions: "Parece que não estás ligado à internet! Para iniciares sessão precisamos que te ligues a uma rede.",
              text: "OK",
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    } else {
      /*bool areControllersCompliant = Authentication.isCompliant(id, password);
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
      else {
        var response = await Authentication.loginUser(id, password);
        if (response == 200) {
          if(kIsWeb) {
            Navigator.pushNamed(context, "/personal/main");
          }
          else Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AppPersonalPage()));
        } else if (response==401) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Ups!",
                  descriptions: "O email e/ou password estão incorretos. Tenta novamente.",
                  text: "OK",
                );
              }
          );
        } else {
          if(kIsWeb)
            Navigator.popAndPushNamed(context, "/error");
          else
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Error500WithBar(i:3, title: Image.asset("assets/app/login.png", scale: 6,))));
        }
      }*/
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      appBar: AppBar(
        title: Text(
            "Adicionar à minha agenda",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: cHeavyGrey
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: cDirtyWhiteColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
              child: Column(
                  children: [
                    MyTextField(controller: titleController, hintText: '', obscureText: false, label: 'Título', icon: Icons.title,),
                    MyTextField(controller: locationController, hintText: '', obscureText: false, label: 'Localização', icon: Icons.location_on_outlined,),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right:20, top: 10),
                      child: TextField(
                        controller: dateController,
                        //editing controller of this TextField
                        decoration: InputDecoration(
                            labelText: "Data",
                            labelStyle: TextStyle(
                                color: cDarkLightBlueColor
                            ),
                            prefixIcon: Icon(Icons.calendar_today, color: cDarkLightBlueColor),
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
                            hintText: "dd-MM-yyyy",
                            hintStyle: TextStyle(
                                color: Colors.grey
                            )
                        ),
                        readOnly: true,//set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              //locale: Locale('pt', 'PT'),
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2023, DateTime.now().month),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2030));
                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              dateController.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                      ),
                    )
                    ,Container(
                      margin: const EdgeInsets.only(left: 20, right:20, top: 10),
                      child: TextField(
                        controller: timeController, //editing controller of this TextField
                        decoration: InputDecoration(
                            labelText: "Hora de início",
                            labelStyle: TextStyle(
                                color: cDarkLightBlueColor
                            ),
                            prefixIcon: Icon(Icons.timer, color: cDarkLightBlueColor),
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
                            hintText: "HH:mm",
                            hintStyle: TextStyle(
                                color: Colors.grey
                            )
                        ),
                        readOnly: true,  //set it true, so that user will not able to edit text
                        onTap: () async {
                          TimeOfDay? pickedTime =  await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                              /*builder: (BuildContext context, Widget? child) => MediaQuery(
                                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                child: Localizations.override(
                                  context: context,
                                  locale: const Locale('pt_pt', 'PT'),
                                  child: child!,
                                ),
                              )*/
                          );

                          if(pickedTime != null ){
                            print(pickedTime.format(context));   //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime = DateFormat('HH:mm').format(parsedTime);
                            print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                            setState(() {
                              timeController.text = formattedTime; //set the value of text field.
                            });
                          }else{
                            print("Time is not selected");
                          }
                        },
                      ),
                    )
                    ,const SizedBox(height: 20),
                    isLoading
                        ? Container(
                        width: 150,
                        child: const LinearProgressIndicator(
                          color: cPrimaryColor,
                          backgroundColor: cPrimaryOverLightColor,
                        )
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultButtonSimple(
                            text: "CANCELAR",
                            color: cPrimaryColor,
                            press: () {
                              Navigator.pop(context);
                            },
                            height: 20),
                        DefaultButtonSimple(
                            text: "ADICIONAR",
                            color: cPrimaryColor,
                            press: () {
                              submitButtonPressed(titleController.text, locationController.text, "DATE", "TIME");
                              setState(() {
                                isLoading = true;
                              });
                            },
                            height: 20),
                      ],
                    ),
                  ],
                ),
              ),
    );
  }
}