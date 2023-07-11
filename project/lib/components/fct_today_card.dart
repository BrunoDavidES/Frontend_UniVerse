import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;

import '../consts/color_consts.dart';
import '../utils/user/user_data.dart';

class FCTTodayWebCard extends StatelessWidget {
  const FCTTodayWebCard({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  Future<String> fetchTextFile() async {
    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref('hojenafct.txt');
      final response = await ref.getData();
      return utf8.decode(response as List<int>);
    } catch (e) {
      print('Error fetching text file: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: cHeavyGrey.withOpacity(0.4),
      ),
      height: size.height / 3.25,
      width: size.width / 2.75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 13, bottom: 5),
            child: Text(
              "Hoje na FCT",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          FutureBuilder<String>(
            future: fetchTextFile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LinearProgressIndicator(color: cDirtyWhite,
                            minHeight: 10,
                            backgroundColor: cDirtyWhiteColor,),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "A CARREGAR",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: cDirtyWhiteColor
                              ),
                            ),
                          ),
                        ]
                    )
                );
              } else if (snapshot.hasError) {
                return Text('Error fetching file');
              } else {
                return Padding(
                  padding: const EdgeInsets.only(left: 25, top: 10, right: 25),
                  child: Text(
                    snapshot.data ?? '',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: cDirtyWhite.withOpacity(0.75),
                      fontSize: 20,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}