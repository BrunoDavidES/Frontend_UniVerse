import 'package:UniVerse/login_screen/login_app.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/app/grid_item.dart';
import '../components/list_button_simple.dart';
import '../components/simple_dialog_box.dart';
import '../components/web/web_menu.dart';
import '../main_screen/app/homepage_app.dart';
import '../utils/search/info_search.dart';
import 'chosen_page_app.dart';
import 'maps_screen/maps_page_app.dart';
import 'package:UniVerse/find_screen/Item.dart';
import 'services_screen/services_body_app.dart';

class FindPageBodyApp extends StatelessWidget {
  const FindPageBodyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool isScrolled) {
          return [
            SliverAppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: cHeavyGrey.withOpacity(0.2),
                statusBarIconBrightness: Brightness.dark
              ),
              automaticallyImplyLeading: false,
              title: Image.asset("assets/titles/find.png", scale:6),
              backgroundColor: cDirtyWhiteColor,
              titleSpacing: 15,
              actions: <Widget>[
              ],
            ),
          ];
        },
        body: GridView.builder(
          itemCount: 12,
          gridDelegate:
              SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                childAspectRatio: 4/2,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3
              ),
         // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            final item = Item.findItems[index];
            return InkWell(
                child: GridBox(text: item.text!, icon: item.icon!),
                onTap: () {
                  if(item.text=="Galeria") {
                    showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(
                                  Radius.circular(10.0)
                              )
                          ),
                          child: InfoPopUp(text: "brevemente disponível na Universe",),
                        )
                    );
                  }
                  else if(item.text=="Transportes")
                    launchUrl(Uri.parse("https://moovitapp.com/index/pt/transportes_p%C3%BAblicos-FCT_UNL_Faculdade_de_Ci%C3%AAncias_e_Tecnologia_da_Universidade_Nova_de_Lisboa-Lisboa-site_20129427-2460"), mode: LaunchMode.externalApplication);
                   else if(item.text=="Pessoas" && !Authentication.userIsLoggedIn) {
                    showDialog(context: context,
                        builder: (BuildContext context){
                          return CustomDialogBox(
                            title: "Ups!",
                            descriptions: "Para poderes ver os utilizadores públicos na UniVerse, precisas de iniciar sessão.",
                            text: "OK",
                            press: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPageApp()));
                            },
                          );
                        }
                    );
                  }
                     else Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChosenPageApp(page:item.page!)));
                },
              );
          },
        )
      );

  }
}


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {

  static List<ListButtonSimple> info = [
  ListButtonSimple(
  text: "Divisão Académica", tobeBold: true, press: () {})
  ];

  List<ListButtonSimple> displayList = [

  ];

  void updateList(String value) {
    setState(() {
      displayList = info.where((element) => element.text.contains(value)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 30,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {Navigator.pop(context);},
            color: cDarkBlueColor),
      ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            image: DecorationImage(
              image: AssetImage("assets/web/foto.jpg"),
              colorFilter: ColorFilter.mode(cBlackOp, BlendMode.darken),
              //colorFilter: ColorFilter.mode(cDirtyWhiteColor, BlendMode.saturation),
              fit: BoxFit.cover,
            ),
          ),
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: TextField(
                onChanged: (value) => updateList(value),
                decoration: InputDecoration(
                  fillColor: cDirtyWhite.withOpacity(0.75),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Pesquisar",
                    prefixIcon: Icon(Icons.search_outlined)
                ),
              ),
      ),
              Expanded(
                  child: displayList.length==0 ? Text("Não foram encontrados resultados...") : ListView.builder(itemBuilder: (context, index) => ListTile(
                    title: Text(
                      displayList[index].text
                    )
                  ),
              )
              ),
            ],
          ),
        ),
    );
  }

}
