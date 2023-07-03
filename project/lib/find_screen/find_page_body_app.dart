import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';

import '../components/app/grid_item.dart';
import '../components/list_button_simple.dart';
import '../components/web/web_menu.dart';
import '../main_screen/app/homepage_app.dart';
import 'chosen_page_app.dart';
import 'maps_screen/maps_page_app.dart';
import 'package:UniVerse/find_screen/Item.dart';
import 'services_screen/services_body_app.dart';

class FindPageBodyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool isScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Image.asset("assets/app/find_title.png", scale:6),
              backgroundColor: cDirtyWhiteColor,
              titleSpacing: 15,
              actions: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(right:15),
                    child: Icon(Icons.search_outlined, color: cPrimaryColor,),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                )
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChosenPageApp(page:item.page!)));
                },
              );
          },
        )
      );

  }
}


class SearchPage extends StatefulWidget {
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
