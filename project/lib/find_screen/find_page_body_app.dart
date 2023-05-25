import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';

import '../components/grid_item.dart';
import 'chosen_page_app.dart';
import 'maps_screen/maps_page_app.dart';
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
              title: Image.asset("assets/app/find_title.png", scale:5),
              backgroundColor: cDirtyWhiteColor,
              titleSpacing: 15,
            )
          ];
        },
        body: GridView.builder(
          itemCount: 14,
          gridDelegate:
              SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                childAspectRatio: 4/2,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3
              ),
         // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            if(index == 0) {
              return InkWell(
                child: GridBox(text: "Mapas", icon: Icons.location_on_outlined),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MapsPageApp()));
                },
              );
            } else if(index==1) {
              return InkWell(
                child: GridBox(text: "Serviços", icon: Icons.work_outline_rounded),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChosenPageApp(i: 1)));
                },
              );
            }else if(index==2) {
              return GridBox(text: "Contactos", icon: Icons.local_phone);
            }else if(index==3) {
              return InkWell(
              child: GridBox(text: "Links", icon: Icons.link_outlined),
            onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChosenPageApp(i: 3)));
            },
            );
            }else if(index==4) {
              return InkWell(
                child: GridBox(text: "Departamentos", icon: Icons.account_balance_outlined),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChosenPageApp(i: 4)));
                },
              );
            }else if(index==5) {
             return GridBox(text: "Edifícios", icon: Icons.home_work_outlined);
            } else if(index==6) {
              return GridBox(text: "Restaurantes", icon: Icons.restaurant_outlined);
            }else if(index==7) {
              return GridBox(text: "Núcleos", icon: Icons.local_activity_outlined);
            }else if(index==8) {
              return GridBox(text: "Galeria", icon: Icons.camera_alt_outlined);
            }else if(index==9) {
              return GridBox(text: "Transportes", icon: Icons.directions_bus);
            }else if(index==10) {
              return GridBox(text: "Pessoas", icon: Icons.person_search_outlined);
            }else if(index==11) {
              return GridBox(text: "Regras", icon: Icons.rule_outlined);
            }
          },
        )
      );

  }
}