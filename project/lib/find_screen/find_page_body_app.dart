import 'package:flutter/material.dart';
import 'package:UniVerse/consts.dart';

class FindPageBodyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: NestedScrollView(
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
          itemCount: 18,
          gridDelegate:
              SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                childAspectRatio: 3/2,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3
              ),
         // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            if(index == 0) {
            return GridBox(text: "Mapa", icon: Icons.location_on_outlined);
            } else if(index==1) {
              return GridBox(text: "Contactos", icon: Icons.local_phone);
            }else if(index==2) {
              return GridBox(text: "Departamentos", icon: Icons.account_balance_outlined);
            }else if(index==3) {
              return GridBox(text: "Serviços", icon: Icons.location_on_outlined);
            }
          },
        )
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
            Icon(icon, size:45, color: cDarkBlueColor),
            Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  color: cHeavyGrey
                ),
            )
          ],
        )
      ),
    );
  }
}