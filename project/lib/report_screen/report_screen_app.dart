
import 'dart:io';
import 'package:UniVerse/components/500.dart';
import 'package:UniVerse/utils/report/report_data.dart';
import 'package:camera/camera.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../camera_screen/camera_screen.dart';
import '../components/confirm_dialog_box.dart';
import '../components/default_button_simple.dart';
import '../components/description_field.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../consts/color_consts.dart';
import '../login_screen/login_app.dart';
import '../utils/connectivity.dart';

class ReportScreenApp extends StatefulWidget {
  const ReportScreenApp({super.key});

  @override
  State<ReportScreenApp> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreenApp> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  bool isLoading = false;
  late TextEditingController titleController;
  late TextEditingController locationController;
  late TextEditingController descriptionController;
  File? pickedImage;
  Uint8List imageUint8 = Uint8List(8);

  @override
  void initState() {
    titleController = TextEditingController();
    locationController = TextEditingController();
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
   titleController.dispose();
   locationController.dispose();
   descriptionController.dispose();

   super.dispose();
  }

  void submitButtonPressed(title, location, description) async {
    if(!kIsWeb && _source.keys.toList()[0]==ConnectivityResult.none) {
      showDialog(context: context,
          builder: (BuildContext context){
            return const CustomDialogBox(
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
                descriptions: "Parece que não adicionaste nenhuma fotgrafia do problema. Precisamos que o faças",
                text: "OK",
              );
            }
        );
      } else {
        showDialog(
            context: context,
            builder: (_) =>
                ConfirmDialogBox(
                    descriptions: "A submissão de um report é previamente validada. Qualquer submissão inválida ou que desrespeite as nossas regras, resultará na suspensão da conta e no subsequente aviso aos serviços da faculdade.",
                    press: () async {
                      Navigator.pop(context);
                      var response = await Report.send(
                          title, location, description, imageUint8);
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
                                descriptions: "Parece que não tens sessão iniciada.",
                                text: "OK",
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (
                                                context) => const LoginPageApp()));
                                  }
                              );
                            }
                        );
                      } else
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Error500()));
                    }
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool added = false;
    return Scaffold(
        backgroundColor: cDirtyWhiteColor,
        appBar: AppBar(
          title: Image.asset("assets/titles/report.png", scale:6),
          automaticallyImplyLeading: false,
          backgroundColor: cDirtyWhiteColor,
          titleSpacing: 15,
          elevation: 0,
          leading: Builder(
              builder: (context) {
                return IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {Navigator.pop(context);},
                    color: cDarkBlueColorTransparent);
              }
          ),
          leadingWidth: 20,
        ),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top:15, bottom: 15),
                    child: const Text(
                      "Encontraste um problema no campus? Preenche os campos abaixo para que possamos conhecer a situação e agir o mais rapidamente possível.",
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  MyTextField(controller: titleController, hintText: 'Introduz um título', obscureText: false, label: 'Título', icon: Icons.title,),
                  MyTextField(controller: locationController, hintText: 'Onde ecnontraste o problema?', obscureText: false, label: 'Localização', icon: Icons.location_on_outlined,),
                  DescriptionField(label: "Descrição", max:300, controller: descriptionController),
                  InkWell(
                    onTap: () async {
                      await availableCameras().then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CameraScreen(cameras: value,))));
                     try {
                        /*final ImagePicker picker = ImagePicker();
                        XFile? image = await picker.pickImage(
                            source: ImageSource.gallery);*/
                        if (Report.imagePath !=null) {
                          File img = File(Report.imagePath!);
                          var f = await img.readAsBytes();
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
                            padding: const EdgeInsets.only(left:5),
                            child: Icon(Icons.camera_alt_outlined, color: cDarkBlueColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:12),
                            child: pickedImage != null
                                ?Text(
                              "Fotografia adicionada!",
                              style: TextStyle(
                                  color: Colors.green
                              ),
                            )
                                : Text(
                              "Adciona uma foto do problema aqui",
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
                              submitButtonPressed(titleController.text, locationController.text, descriptionController.text);
                            },
                            height: 20),
                      ],
                    ),
  ]
          ),
        )
    );
  }
}