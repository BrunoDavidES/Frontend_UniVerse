import 'dart:convert';

import 'package:UniVerse/components/500.dart';
import 'package:UniVerse/components/my_date_field.dart';
import 'package:UniVerse/login_screen/login_web.dart';
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

import '../Components/default_button.dart';
import '../components/app/500_app_with_bar.dart';
import '../components/confirm_dialog_box.dart';
import '../components/default_button_simple.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../components/url_launchable_item.dart';
import '../consts/color_consts.dart';
import '../info_screen/universe_info_app.dart';
import '../login_screen/login_app.dart';
import '../personal_page_screen/web/personal_page_web.dart';
import '../register_screen/register_app.dart';
import '../register_screen/register_web.dart';
import '../utils/connectivity.dart';
import 'package:intl/intl.dart';

import '../utils/events/personal_event_data.dart';

class PersonalEventEditScreen extends StatefulWidget {
  final CalendarEvent data;
  const PersonalEventEditScreen({super.key, required this.data});

  @override
  State<PersonalEventEditScreen> createState() => _EventCreationScreenState();
}

class _EventCreationScreenState extends State<PersonalEventEditScreen> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  bool isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.data.title!;
    locationController.text = widget.data.location!;
    dateController.text = widget.data.date!;
    timeController.text = widget.data.hour!;
    _connectivity.initialize();
    _connectivity.myStream.listen((source) {
      setState(() {
        _source = source;
      });
    });
    super.initState();
  }

  void submitButtonPressed(id, title, location, date, hour) async {
    if (!kIsWeb && _source.keys.toList()[0] == ConnectivityResult.none) {
      showDialog(context: context,
          builder: (BuildContext context) {
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
      bool areControllersCompliant = CalendarEvent.areCompliant(
          title, "o", location, date, hour);
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
      else {
        showDialog(
            context: context,
            builder: (_) =>
                ConfirmDialogBox(
                    descriptions: "Tens a certeza que queres atualizar o teu perfil na UniVerse?",
                    press: () async {
                      var response = await CalendarEvent.edit(
                          id, title, location, date, hour);
                      if (response == 200) {
                        showDialog(context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: "Sucesso!",
                                descriptions: "O evento criado foi adicionado ao teu calendário.",
                                text: "OK",
                              );
                            }
                        );
                      } else if (response == 403) {
                        showDialog(context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: "Ups!",
                                descriptions: "",
                                text: "OK",
                                press: () {
                                  if (kIsWeb) {
                                    showDialog(
                                        context: context,
                                        builder: (_) =>
                                        const AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(10.0)
                                              )
                                          ),
                                          content: LoginPageWeb(),
                                        )
                                    );
                                  } else
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (
                                            context) => const LoginPageApp()));
                                },
                              );
                            }
                        );
                      } else {
                        if (kIsWeb)
                          context.go("/error");
                        else
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Error500()));
                      }
                    }
                ));
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Editar Evento Pessoal",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cHeavyGrey,
                  fontSize: 20
              ),
            ),
            MyTextField(
              controller: titleController,
              hintText: '',
              obscureText: false,
              label: 'Título',
              icon: Icons.title,),
            MyTextField(
              controller: locationController,
              hintText: '',
              obscureText: false,
              label: 'Localização',
              icon: Icons.location_on_outlined,),
            MyDateField(controller: dateController, label: "Data",),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: TextField(
                controller: timeController,
                //editing controller of this TextField
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
                readOnly: true,
                //set it true, so that user will not able to edit text
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
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
                  if (pickedTime != null) {
                    print(pickedTime.format(context)); //output 10:51 PM
                    DateTime parsedTime = DateFormat("h:mm a").parse(
                        pickedTime.format(context));
                    //converting to DateTime so that we can further format on different pattern.
                    print(parsedTime); //output 1970-01-01 22:53:00.000
                    String formattedTime = DateFormat('HH:mm').format(
                        parsedTime);
                    print(formattedTime); //output 14:59:00
                    //DateFormat() is from intl package, you can format the time on any pattern you need.
                    setState(() {
                      timeController.text =
                          formattedTime; //set the value of text field.
                    });
                  } else {
                    print("Time is not selected");
                  }
                },
              ),
            ),
            const SizedBox(height: 15),
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
                    height: 10),
                DefaultButtonSimple(
                    text: "CONFIRMAR",
                    color: cPrimaryColor,
                    press: () {
                      submitButtonPressed(widget.data.id, titleController.text,
                          locationController.text, dateController.text,
                          timeController.text);
                      setState(() {
                        isLoading = true;
                      });
                    },
                    height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}