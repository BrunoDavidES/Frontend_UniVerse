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
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: (size.width - size.width/1.1)),
            child: Container(
              height: size.height/6,
              width: size.width/6,
              decoration: const BoxDecoration(
                image: DecorationImage(
                image: AssetImage("assets/web/findTitle.jpeg"),
                ),
              ),
            ),
          ),
          const FindListItem(icon: Icon(Icons.work_outline_rounded), name: "Serviços"),
          const ExpansionTile(
            title: Text("Serviços", style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
            children: [
              ExpansionTile(
                title: Text("Divisão Académica", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                children: [
                  Text("\nInfo basica", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: UrlLaunchableItem(text: 'Mais informação', url: 'https://www.fct.unl.pt/faculdade/servicos/divisao-academica', color:Colors.black),
                  ),
                  Text(""),
                ],
              ),
            ],
          ),
          const ExpansionTile(
            title: Text("Contactos", style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
          ),
          const ExpansionTile(
            title: Text("Links", style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
          ),
          const ExpansionTile(
            title: Text("Departamentos", style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
          ),
          const ExpansionTile(
            title: Text("Edifícios", style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
          ),
          const ExpansionTile(
            title: Text("Restaurantes", style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
          ),
          const ExpansionTile(
            title: Text("Edifícios", style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
          ),
          const ExpansionTile(
            title: Text("Núcleos", style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
          ),
          const ExpansionTile(
            title: Text("Galeria", style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
          ),
          const ExpansionTile(
            title: Text("Transportes", style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
          ),
          const ExpansionTile(
            title: Text("Pessoas", style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
          ),
          const ExpansionTile(
            title: Text("Regras", style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
          ),
        ],
      ),
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