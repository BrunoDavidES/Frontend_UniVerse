import 'package:UniVerse/components/url_launchable_item.dart';
import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

class FindListItem extends StatelessWidget {
  final Icon icon;
  final String name;
  const FindListItem({
    super.key, required this.icon, required this.name});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: cPrimaryLightColor,
              width:2,
            )
        ),
        child: ExpansionTile(
          leading: icon,
          title: Text(name),
          backgroundColor: cDirtyWhite,
          textColor: Colors.black,
          iconColor: cDarkBlueColor,
          collapsedIconColor: cDarkBlueColor,
          collapsedTextColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          children: const [
            ExpansionTile(
              title: Text("Divisão Académica", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              children: [
                Text("\nInfo basica", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: UrlLaunchableItem(text: 'Mais informação', url: 'https://www.fct.unl.pt/faculdade/servicos/divisao-academica', color: Colors.black,)
                ),
                Text(""),
              ],
            ),
          ],
        ),
      ),
    );
  }
}