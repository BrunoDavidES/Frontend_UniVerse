import 'package:UniVerse/components/web/web_menu.dart';
import 'package:UniVerse/find_screen/buildings_screen/buildings_body_app.dart';
import 'package:UniVerse/find_screen/courses_screen/courses_screen_app.dart';
import 'package:UniVerse/find_screen/maps_screen/maps_page_app.dart';
import 'package:UniVerse/find_screen/restaurants_screen/restaurants_screen.dart';
import 'package:UniVerse/find_screen/services_screen/services_body_app.dart';
import 'package:flutter/material.dart';

import 'departments_screen/departments_body_app.dart';
import 'links_screen/links_body_app.dart';

class Item {

  String? text;
  IconData? icon;
  Widget? page;

  Item(
      this.text,
      this.icon,
      this.page
      );

  static List<Item> findItems = [
    Item("Mapas", Icons.location_on_outlined, MapsPageApp()),
    Item("Serviços", Icons.work_outline_rounded, ServicesBodyApp()),
    Item("Contactos", Icons.local_phone, MapsPageApp()),
    Item("Links", Icons.link_outlined, LinksBodyApp()),
    Item("Cursos", Icons.school_outlined, CoursesScreenApp()),
    Item("Departamentos", Icons.account_balance_outlined, DepartmentsBodyApp()),
    Item("Edifícios", Icons.home_work_outlined, BuildingsBodyApp()),
    Item("Restaurantes", Icons.restaurant_outlined, RestaurantsScreen()),
    Item("Núcleos", Icons.local_activity_outlined, MapsPageApp()),
    Item("Galeria", Icons.camera_alt_outlined, null), //showDialog
    Item("Transportes", Icons.directions_bus, MapsPageApp()),
    Item("Pessoas", Icons.person_search_outlined, ServicesBodyApp()),
  ];

}

/*
showDialog(
                      context: context,
                      builder: (_) => Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(
                            Radius.circular(10.0)
                        )
                    ),
                    child: SoonPopUp(),
                  )
                  );
 */