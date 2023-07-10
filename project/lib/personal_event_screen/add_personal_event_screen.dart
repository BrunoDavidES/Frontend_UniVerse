import 'package:UniVerse/components/500.dart';
import 'package:UniVerse/components/my_date_field.dart';
import 'package:UniVerse/components/my_time_field.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../components/default_button_simple.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../consts/color_consts.dart';
import '../login_screen/login_app.dart';
import '../utils/connectivity.dart';
import '../utils/events/personal_event_data.dart';
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

  void submitButtonPressed(String title, String location, String date, String hour) async {
    if(!kIsWeb && _source.keys.toList()[0]==ConnectivityResult.none) {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialogBox(
              title: "Sem internet",
              descriptions: "Parece que não estás ligado à internet! Para adicionares um evento à tua agenda, precisamos que te ligues a uma rede.",
              text: "OK",
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    } else {
      bool areControllersCompliant = CalendarEvent.areCompliant(title, location, date, hour);
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
      }
      else {
        var response = await CalendarEvent.add(UniverseUser.getUsername(), title, "i", location, date, hour);
        if (response == 200) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Sucesso!",
                  descriptions: "O evento criado foi adicionado ao teu calendário. Muito brevemente, constará na agenda do dia em que foi criado.",
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
                      if (kIsWeb) {
                        context.go("/home");
                      } else
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => const LoginPageApp()));
                    });
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
        } else {
          if(kIsWeb)
            context.go("/error");
          else
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Error500()));
        }
      }
      setState(() {
        isLoading = false;
      });
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
                  "Adicionar à minha agenda",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: cHeavyGrey,
                      fontSize: 20
                  ),
                ),
                MyTextField(controller: titleController, hintText: '', obscureText: false, label: 'Título', icon: Icons.title,),
                MyTextField(controller: locationController, hintText: '', obscureText: false, label: 'Localização', icon: Icons.location_on_outlined,),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                readOnly: true, //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      initialDatePickerMode: DatePickerMode.day,
                      //locale: Locale('pt', 'PT'),
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023, 7, DateTime.now().day),
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
            ),
                MyTimeField(controller: timeController, label: "Hora de início"),
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
                        text: "ADICIONAR",
                        color: cPrimaryColor,
                        press: () {
                          setState(() {
                            isLoading = true;
                          });
                          submitButtonPressed(titleController.text, locationController.text, dateController.text, timeController.text);
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