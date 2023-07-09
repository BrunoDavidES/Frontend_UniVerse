
import 'package:UniVerse/components/web/web_menu.dart';
import 'package:UniVerse/utils/search/info.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../consts/color_consts.dart';
import '../list_button_simple.dart';

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
                ...services.map((e) => ListButtonSimple(
                    text: e.values.first, tobeBold: false, press: () => context.go('/find/services/${e.keys.first}'))).toList(),
              if(name=='Contactos')
                ...services.map((e) => ListButtonSimple(
                    text: e.values.first, tobeBold: false, press: () => context.go('/find/services/${e.keys.first}'))).toList(),
              if(name=='Links')
                ...links.map((e) => ListButtonSimple(
                    text: e.keys.first, tobeBold: false, press: () => launchUrl(Uri.parse(e.values.first)))).toList(),
              if(name=='Cursos')
                ...courses.map((e) => ListButtonSimple(
                    text: e.keys.first, tobeBold: false, press: () => launchUrl(Uri.parse(e.values.first)))).toList(),
              if(name=='Departamentos')
                ...departments.map((e) => ListButtonSimple(
                    text: e.values.first[0], tobeBold: false, press: () => context.go('/find/departments/${e.keys.first}'))).toList(),
              if(name=='Edifícios')
                ...buildings.map((e) => ListButtonSimple(
                    text: e.values.first[0], tobeBold: false, press: () => context.go('/find/buildings/${e.keys.first}'))).toList(),
              if(name=='Restaurantes')
                ...restaurants.map((e) => ListButtonSimple(
                    text: e.values.first, tobeBold: false, press: () => context.go('/find/restaurants/${e.keys.first}'))).toList(),
              if(name=='Núcleos')
                ...organizations.map((e) => ListButtonSimple(
                    text: e.values.first[0], tobeBold: false, press: () => context.go('/find/organizations/${e.keys.first}'))).toList(),
              if(name=='Galeria')
                  InfoPopUp(text: "brevemente disponível na universe",),
            ]
        ),
      ),
    );
  }
}