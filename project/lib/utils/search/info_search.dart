import 'package:UniVerse/components/default_button_simple.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/find_screen/info_detail_screen.dart';
import 'package:UniVerse/utils/search/info.dart';
import 'package:flutter/material.dart';

import '../../components/list_button_simple.dart';
import '../../main_screen/app/homepage_app.dart';

class MySearchDelegate extends SearchDelegate {

  @override
  Widget buildLeading(BuildContext context) =>
      IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back),
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
    )
];

  @override
  Widget buildResults(BuildContext context) {
    return Container();
    /*return InfoDetailScreen(
    data: services.where((element) => element.values.first==query)
    );*/
  }

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

          return ListButtonSimple(
  text: suggestion,
            tobeBold: true,
            press: () {
              query = suggestion;
              showResults(context);
            },
          );
        }
    );
  }
}