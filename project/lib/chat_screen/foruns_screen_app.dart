import 'dart:async';
import 'dart:math';
import 'package:UniVerse/chat_screen/enter_forum_screen.dart';
import 'package:UniVerse/chat_screen/members_screen.dart';
import 'package:UniVerse/chat_screen/promote_depromote_screen.dart';
import 'package:UniVerse/consts/list_consts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../components/500.dart';
import '../components/confirm_dialog_box.dart';
import '../components/my_text_button.dart';
import '../components/simple_dialog_box.dart';
import '../consts/color_consts.dart';
import '../login_screen/login_app.dart';
import '../personal_page_screen/app/personal_page_app.dart';
import '../utils/chat/chat_utils.dart';
import '../utils/connectivity.dart';
import 'chat_screen_app.dart';
import 'create_forum_screen.dart';

class ForunsScreenApp extends StatefulWidget {

  ForunsScreenApp({super.key});

  @override
  State<ForunsScreenApp> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<ForunsScreenApp> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  late StreamSubscription _forumStream;
  final StreamController<dynamic> _forumStreamController = StreamController<dynamic>();
  bool isLoading = false;

  @override
  void initState() {
    _connectivity.initialize();
    _connectivity.myStream.listen((source) {
      setState(() {
        _source = source;
      });
    });
    String? userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID != null) {
      _forumStream = FirebaseDatabase.instance
          .ref()
          .child('users/${userID.replaceAll(".", "-")}/forums/')
          .onValue
          .listen((event) {
        var snapshot = event.snapshot;
        var children = snapshot.value as Map<dynamic, dynamic>;

        _forumStreamController.add(children);
      });
    }
    super.initState();
  }

  @override
  void deactivate() {
    _forumStream.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    String forumName = '';
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: cDirtyWhiteColor,
      appBar: AppBar(
        title: Image.asset("assets/titles/messages.png", scale: 6),
        leading: Builder(
            builder: (context) {
              return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: cDarkBlueColorTransparent);
            }
        ),
        leadingWidth: 20,
        backgroundColor: cDirtyWhiteColor,
        titleSpacing: 15,
        elevation: 0,
      ),
      body: Stack(
          children: [
            if (_source.keys.toList()[0] == ConnectivityResult.none)
              InternetInfo()
            else StreamBuilder(
              stream: _forumStreamController.stream,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Error500()));
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Info();
                }

                var forums = snapshot.data as Map<dynamic, dynamic>;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: forums.entries.map((entry) {
                          var forumID = entry.key;
                          var forumData = entry.value;
                          forumName = forumData['name'];
                          return ForumCard(data: entry);
                        },).toList(),
                      ),
                      SizedBox(height: 200,)
                    ],
                  ),
                );
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Button(text: "CRIAR FÓRUM", screen: CreateForumScreen(),),
                Button(text: "ACEDER A UM FÓRUM", screen: EnterForumScreen(forumName: forumName,),),
                SizedBox(
                    height:70
                )
              ],
            ),
          ]
      ),

    );
  }
}

class ForumCard extends StatelessWidget {
  const ForumCard({
    super.key, this.data,
  });

  final data;

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int cindex = random.nextInt(toRandom2.length);
    var forumID = data.key;
    var forumData = data.value;
    var forumName = forumData['name'];
    var role = forumData['role'];
    return Container(
      height: 50,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              color: toRandom2[cindex],
              width: 2
          )
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatPageApp(forumID: forumID!, forumName: forumName!,)));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                forumName,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: cHeavyGrey
                ),
                maxLines: 1,
                softWrap: true,
              ),
            ),
            Spacer(),
            if(role != "MEMBER")
              InkWell(
                child: Icon(
                  Icons.info_outline,
                  color:
                  cPrimaryLightColor,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => CustomDialogBox(title: "Informação", descriptions: "O ID deste fórum é:\n\n${forumID}", text: "OK")
                  );
                },
              ),
            SizedBox(width: 3,),
            if(role != "MEMBER")
              InkWell(
                child: Icon(
                  Icons.person_outlined,
                  color:
                  cPrimaryLightColor,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MembersPageApp(forumID: forumID, forumName: forumName)));
                },
              ),
            SizedBox(width: 3,),
            /*if(role == "A")
              InkWell(
                child: Icon(
                  Icons.switch_access_shortcut,
                  color:
                  cPrimaryLightColor,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => Dialog(
                          backgroundColor: cDirtyWhiteColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(
                                  Radius.circular(10.0)
                              )
                          ),
                          child: PromoteDepromoteScreen(toPromote: true, forumID: forumID,)
                      )
                  );
                },
              ),*/
            SizedBox(width: 3,),
            if(role == "MEMBER")
              InkWell(
                child: Icon(
                  Icons.logout_outlined,
                  color:
                  cHeavyGrey.withOpacity(0.6),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) =>
                          ConfirmDialogBox(
                              descriptions: "Tens a certeza que pretendes sair do fórum $forumName?",
                              press: () async {
                                var response = await Chat.delete(forumID);
                                if (response == 200) {
                                  Navigator.pop(context);
                                  showDialog(context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialogBox(
                                          title: "Sucesso!",
                                          descriptions: "Já não subscreves este fórum.",
                                          text: "OK",
                                        );
                                      }
                                  );
                                }
                                if (response == 401) {
                                  showDialog(context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialogBox(
                                            title: "Ups!",
                                            descriptions: "Parece que a tua sessão expirou. Inicia sessão novamente, por favor.",
                                            text: "OK",
                                            press: () {
                                              Navigator.pushReplacement(
                                                  context, MaterialPageRoute(
                                                  builder: (
                                                      context) => const LoginPageApp()));
                                            });
                                      }
                                  );
                                }else {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Error500()));
                                }
                              }
                          ));
                },
              ),
            SizedBox(width: 3,),
            if(role == "A")
              InkWell(
                child: Icon(
                  Icons.delete_outline,
                  color:
                  cPrimaryLightColor,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) =>
                          ConfirmDialogBox(
                              descriptions: "Tens a certeza que pretendes eliminar o fórum $forumName?",
                              press: () async {
                                var response = await Chat.delete(forumID);
                                if (response == 200) {
                                  Navigator.pop(context);
                                  showDialog(context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialogBox(
                                          title: "Sucesso!",
                                          descriptions: "O fórum foi eliminado. Qualquer participante já terá acesso a este fórum.",
                                          text: "OK",
                                        );
                                      }
                                  );
                                }
                                if (response == 401) {
                                  showDialog(context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialogBox(
                                            title: "Ups!",
                                            descriptions: "Parece que a tua sessão expirou. Inicia sessão novamente, por favor.",
                                            text: "OK",
                                            press: () {
                                              Navigator.pushReplacement(
                                                  context, MaterialPageRoute(
                                                  builder: (
                                                      context) => const LoginPageApp()));
                                            });
                                      }
                                  );
                                } else if (response == 400) {
                                  showDialog(context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialogBox(
                                          title: "Ups!",
                                          descriptions: "Aconteceu um erro inesperado! Por favor, tenta novamente.",
                                          text: "OK",
                                          press: () {
                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(
                                                    builder: (
                                                        context) => const AppPersonalPage()));
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
                                        );
                                      }
                                  );
                                } else {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Error500()));
                                }
                              }
                          ));
                },
              ),
          ],
        ),
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "SEM FÓRUNS",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: cPrimaryLightColor,
            fontSize: 25
        ),
      ),
    );
  }
}

class InternetInfo extends StatelessWidget {
  const InternetInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: size.height/4,),
            Text(
              "SEM INTERNET",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cPrimaryLightColor,
                  fontSize: 25
              ),
            ),
            SizedBox(height: 15,),
            Text("Para que possas ver os teus fóruns, precisas de te ligar a uma rede.",style: TextStyle(fontSize: 14, color: cHeavyGrey),textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}