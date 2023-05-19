import 'package:flutter/material.dart';

import '../../main_screen/app/homepage_app.dart';

/*class InfoSearch extends SearchDelegate<String> {
  List<String> searchResults = [
    'Serviços',
    'Departamentos',
    'Mapa',
    'Contactos',
  ];

  @override
  Widget buildLeading(BuildContext context) =>
      IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.clear),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
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
];

  @override
  void buildResults(BuildContext context) {

  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
  {
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
}*/
