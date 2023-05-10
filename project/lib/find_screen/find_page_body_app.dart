import 'package:flutter/material.dart';
import 'package:UniVerse/consts.dart';

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
            return GridBox(text: "Mapas", icon: Icons.location_on_outlined);
            } else if(index==1) {
              return GridBox(text: "Serviços", icon: Icons.work_outline_rounded);
            }else if(index==2) {
              return GridBox(text: "Contactos", icon: Icons.local_phone);
            }else if(index==3) {
              return GridBox(text: "Links", icon: Icons.link_outlined);

            }else if(index==4) {
              return GridBox(text: "Departamentos", icon: Icons.account_balance_outlined);
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

class GridBox extends StatelessWidget {
  final String text;
  final IconData icon;
  const GridBox({
    super.key, required this.text, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: 10,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: cDirtyWhite,
            border: Border.all(
              color: cPrimaryLightColor,
              width:2,
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size:40, color: cDarkBlueColor),
            Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: cHeavyGrey
                ),
            )
          ],
        )
      ),
    );
  }
}