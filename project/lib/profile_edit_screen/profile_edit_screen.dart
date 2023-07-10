import 'dart:io';

import 'package:UniVerse/components/500.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_body_app.dart';
import 'package:UniVerse/profile_screen/profile_app.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../components/confirm_dialog_box.dart';
import '../components/default_button_simple.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../consts/color_consts.dart';
import '../login_screen/login_app.dart';
import '../utils/connectivity.dart';


class ProfileEditScreen extends StatefulWidget {
  final UniverseUser data;
  const ProfileEditScreen({super.key, required this.data});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEditScreen> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  late TextEditingController nameController= TextEditingController();
  late TextEditingController phoneController= TextEditingController();
  late TextEditingController linkedinController= TextEditingController();
  late TextEditingController officeController= TextEditingController();
  late TextEditingController license_plateController= TextEditingController();
  String? privacy;
  bool isLoading = false;
  Uint8List imageUint8 = Uint8List(8);
  File? pickedImage;

  @override
  void initState() {
    nameController.text = widget.data.name;
    phoneController.text = widget.data.phone;
    linkedinController.text = widget.data.linkedin;
    officeController.text = widget.data.office;
    license_plateController.text = widget.data.license_plate;
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

  void submitButtonPressed(name, phone, linkedin, office, licensePlate, privacy) async {
    if(!kIsWeb && _source.keys.toList()[0]==ConnectivityResult.none) {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialogBox(
              title: "Sem internet",
              descriptions: "Parece que não estás ligado à internet! Para confirmares as alterações no teu perfil precisamos que te ligues a uma rede.",
              text: "OK",
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    } else {
      showDialog(
          context: context,
          builder: (_) => ConfirmDialogBox(
              descriptions: "Tens a certeza que queres atualizar o teu perfil na UniVerse?",
              press: () async {
                Navigator.pop(context);
                setState(() {
                  isLoading = true;
                });
                var response = await UniverseUser.update(name, phone, linkedin, office, licensePlate, privacy, imageUint8);
                if (response == 200) {
                  showDialog(context: context,
                      builder: (BuildContext context) {
                        return CustomDialogBox(
                          title: "Sucesso",
                          descriptions: "Já atualizámos o teu perfil! Muito brevemente verás as alterações no teu perfil.",
                          text: "OK",
                          press: () {
                            if(kIsWeb) {
                              Navigator.pop(context);
                              context.go("/personal");
                            } else {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          }
                        );
                      }
                  );
                  setState(() {
                    isLoading = false;
                  });
                } else if (response==401) {
                  showDialog(context: context,
                      builder: (BuildContext context) {
                        return CustomDialogBox(
                          title: "Ups!",
                          descriptions: "Parece que a tua sessão expirou. Precisamos que inicies sessão novamente.",
                          text: "OK",
                          press: () {
                            Navigator.pop(context);
                            if(kIsWeb)
                              context.go("/home");
                            else Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPageApp()));
                          }
                        );
                      }
                  );
                  setState(() {
                    isLoading = false;
                  });
                } else if (response == 403) {
                  showDialog(context: context,
                      builder: (BuildContext context) {
                        return CustomDialogBox(
                            title: "Ups!",
                            descriptions: "Parece que não tens permissões para esta operação.",
                            text: "OK",
                            press: () {
                              Navigator.pop(context);
                              if(kIsWeb)
                                context.go("/home");
                              else Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const PersonalPageBodyApp()));
                            }
                        );
                      }
                  );
                  setState(() {
                    isLoading = false;
                  });
                } else if (response==400) {
                  showDialog(context: context,
                      builder: (BuildContext context){
                        return CustomDialogBox(
                          title: "Ups!",
                          descriptions: "Aconteceu algo inesperado... Tenta novamente, por favor.",
                          text: "OK",
                        );
                      }
                  );
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  if(kIsWeb)
                    context.go("/error");
                  else
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Error500()));
                }
              }
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cDirtyWhiteColor,
        appBar: kIsWeb
        ?AppBar(
          title: Image.asset("assets/titles/edit.png", scale:6),
          backgroundColor: cDirtyWhiteColor,
          automaticallyImplyLeading: false,
          titleSpacing: 15,
          elevation: 0,
        )
        :AppBar(
          title: Image.asset("assets/titles/edit.png", scale:6),
          backgroundColor: cDirtyWhiteColor,
          leading: Builder(
              builder: (context) {
                return IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {Navigator.pop(context);},
                    color: cDarkLightBlueColor);
              }
          ),
          leadingWidth: 20,
          titleSpacing: 15,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "O teu perfil na UniVerse não é vinculativo com as tuas informações nos serviços da faculdade.",
                style:TextStyle(
                  fontSize: 13,
                  color: Colors.redAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              MyTextField(controller: nameController, hintText: '', obscureText: false, label: 'Nome', icon: Icons.person_outline,),
              MyTextField(controller: phoneController, hintText: '', obscureText: false, label: 'Telémovel', icon: Icons.phone_outlined,),
              MyTextField(controller: linkedinController, hintText: '', obscureText: false, label: 'Perfil LinkedIn', icon: Icons.link_outlined,),
              Authentication.role != 'S'
              ?MyTextField(controller: officeController, hintText: '', obscureText: false, label: 'Gabinete', icon: Icons.work_outline,) :SizedBox(),
              MyTextField(controller: license_plateController, hintText: '', obscureText: false, label: 'Matrícula', icon: Icons.directions_car_filled,),
              Container(
                margin: const EdgeInsets.only(left: 20, right:20, top: 10),
                child: kIsWeb
                  ? Row(
                  children: [
                    Text(
                      "Visibilidadade da conta:",
                      style: TextStyle(
                          color: cDarkBlueColor
                      ),
                    ),
                    SizedBox(width: 15),
                    ToggleSwitch(
                      customWidths: [80, 80.0],
                      cornerRadius: 15.0,
                      activeBgColors: [[cDarkLightBlueColor], [cDarkLightBlueColor]],
                      activeFgColor: Colors.white,
                      inactiveBgColor: cDirtyWhiteColor,
                      inactiveFgColor: cHeavyGrey,
                      totalSwitches: 2,
                      labels: ['Pública', 'Privada'],
                      onToggle: (index) {
                        if(index==0)
                          privacy = 'PUBLIC';
                        else privacy = 'PRIVATE';
                      },
                    ),
                  ],
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Visibilidadade da conta:",
                      style: TextStyle(
                          color: cDarkBlueColor
                      ),
                    ),
                    SizedBox(width: 15),
                    ToggleSwitch(
                      customWidths: [80, 80.0],
                      cornerRadius: 15.0,
                      activeBgColors: [[cDarkLightBlueColor], [cDarkLightBlueColor]],
                      activeFgColor: Colors.white,
                      inactiveBgColor: cDirtyWhiteColor,
                      inactiveFgColor: cHeavyGrey,
                      totalSwitches: 2,
                      labels: ['Pública', 'Privada'],
                      onToggle: (index) {
                        if(index==0)
                          privacy = 'PUBLIC';
                        else privacy = 'PRIVATE';
                      },
                    ),
                  ],
                )
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Text(
                  "Ao tornares a tua conta pública, só pessoas que estejam registada na UniVerse poderão visualizá-la.",
                  style: TextStyle(
                    color: cDarkBlueColor,
                    fontSize: 13
                  ),
                  textAlign: TextAlign.center,
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
                      if(f.lengthInBytes > 3000000) {
                        showDialog(context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: "Ups!",
                                descriptions: "A imagem excede o tamanho máximo permitido de 3 MB.",
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
                            ? Text(
                          "Fotografia Adicionada!",
                          style: TextStyle(
                              color: Colors.green
                          ),
                        )
                            : Text(
                          "Muda a tua foto de perfil aqui (max 3 MB)",
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
                  ? Row(
                children: [
                  Spacer(),
                  Container(
                      width: 150,
                      child: const LinearProgressIndicator(
                        color: cPrimaryColor,
                        backgroundColor: cPrimaryOverLightColor,
                      )
                  ),
                ],
              )
                  : Row(
                children: [
                  Spacer(),
                  if(kIsWeb)
                    DefaultButtonSimple(
                        text: "CANCELAR",
                        color: cPrimaryColor,
                        press: () {
                          Navigator.pop(context);
                        },
                        height: 20),
                  DefaultButtonSimple(
                      text: "CONFIRMAR ALTERAÇÕES",
                      color: cPrimaryColor,
                      press: () {
                        submitButtonPressed(nameController.text, phoneController.text, linkedinController.text, officeController.text, license_plateController.text, privacy);
                      },
                      height: 20),
                ],
              ),
              !kIsWeb
              ? SizedBox(height: 80)
                  :SizedBox()
            ],
          ),
        )
    );
  }
}