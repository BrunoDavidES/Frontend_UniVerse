import 'package:UniVerse/components/url_launchable_item.dart';
import 'package:UniVerse/consts/list_consts.dart';
import 'package:flutter/material.dart';

import '../consts/color_consts.dart';
import '../main_screen/homepage_web.dart';
import 'list_button_simple.dart';

class FindListItem extends StatelessWidget {
  final Icon icon;
  final String name;
  final int i;
  const FindListItem({
    super.key, required this.icon, required this.name, required this.i});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.center,
              //tileMode:TileMode.mirror,
              colors: [
                cPrimaryOverLightColor.withOpacity(0.5),
                cDirtyWhite,
                cDirtyWhiteColor
              ],
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: cPrimaryLightColor,
              width:2,
            )
        ),
        child: ExpansionTile(
            leading: icon,
            title: Text(name),
            backgroundColor: cDirtyWhiteColor,
            textColor: Colors.black,
            iconColor: cPrimaryColor,
            collapsedIconColor: cPrimaryColor,
            collapsedTextColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            children: [
              if(name=='Serviços')
              ListButtonSimple(
                  text: "Divisão Académica", tobeBold: false, press: () {
              }),
              if(i==1)
              ListButtonSimple(
                  text: "Divisão de Acompanhamento de Parcerias",tobeBold: false,
                  press: () {}),
              ListButtonSimple(
                  text: "Divisão de Apoio à Formação Avançada",tobeBold: false,
                  press: () {}),
              ListButtonSimple(
                  text: "Divisão de Apoio Geral", tobeBold: false,press: () {}),
              ListButtonSimple(
                  text: "Divisão de Apoio Técnico", tobeBold: false,press: () {}),
              ListButtonSimple(
                  text: "Divisão de Comunicação e Relações Exteriores",tobeBold: false,
                  press: () {}),
              ListButtonSimple(
                  text: "Divisão de Documentação e Cultura",tobeBold: false, press: () {}),
            ]
        ),
      ),
    );
  }
}