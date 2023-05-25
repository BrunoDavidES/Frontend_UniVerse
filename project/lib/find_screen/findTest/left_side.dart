import 'dart:ui';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/find_list_item.dart';
import '../../components/url_launchable_item.dart';

class LeftSide extends StatefulWidget {
  const LeftSide({super.key});

  @override
  State<LeftSide> createState() => _LeftSideState();
}

class _LeftSideState extends State<LeftSide> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children:  [
        Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom:5),
                  child: FindListItem(icon: Icon(Icons.work_outline_rounded), name: "Serviços"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom:5),
                  child: FindListItem(icon: Icon(Icons.local_phone), name: "Contactos"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom:5),
                  child: FindListItem(icon: Icon(Icons.link_outlined), name: "Links"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom:5),
                  child: FindListItem(icon: Icon(Icons.account_balance_outlined), name: "Departamentos"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom:5),
                  child: FindListItem(icon: Icon(Icons.home_work_outlined), name: "Edifícios"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom:5),
                  child: FindListItem(icon: Icon(Icons.restaurant_outlined), name: "Restaurantes"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom:5),
                  child: FindListItem(icon: Icon(Icons.local_activity_outlined), name: "Núcleos"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom:5),
                  child: FindListItem(icon: Icon(Icons.camera_alt_outlined), name: "Galeria"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom:5),
                  child: FindListItem(icon: Icon(Icons.directions_bus), name: "Transportes"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom:5),
                  child: FindListItem(icon: Icon(Icons.person_search_outlined), name: "Pessoas"),
                ),
                FindListItem(icon: Icon(Icons.rule_outlined), name: "Regras"),
              ],
        ),
      ],
    );
  }
}

/*
class MySearchDelegate extends SearchDelegate {
  List<String> searchResults = [
    'Serviços',
    'Departamentos',
    'Mapa',
    'Contactos',
  ];

  @override
  Widget? buildLeading(BuildContext context) =>
      IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.clear),
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      onPressed: () {
        if(query.isEmpty) {
          close(context, null);
        }
        else {
          query = '';
        }
      },
      icon: const Icon(Icons.clear),
    );
  }

  @override
  Widget buildResults(BuildContext context) => Center(
    child: Text(
      query,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();
    return ListView.builder(
        itemCount:suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;
              showResults(context);
            },
          );
        }
    );
  }
}
*/