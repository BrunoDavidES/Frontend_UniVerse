
import 'package:flutter/material.dart';

import '../consts/color_consts.dart';
import '../utils/news/article_data.dart';

class InfoDetailScreen extends StatefulWidget {
  InfoDetailScreen(this.data, {super.key});
  Article data;

  @override
  State<StatefulWidget> createState() => InfoDetailState();
}

class InfoDetailState extends State<InfoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 190,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(widget.data.urlToImage!),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  ),
                  Container(
                    height: 190,
                    child: Column(
                      children: [
                        IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {Navigator.pop(context);},
                            color: cDirtyWhiteColor),
                      ],
                    ),
                  )
                ]
            ),
            Padding(
              padding: const EdgeInsets.only(top:5, left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.data.date!,
                    style: TextStyle(
                        fontSize: 13,
                        color: cHeavyGrey
                    ),
                  ),
                  Spacer(),
                  Text(
                    "autoria de "+widget.data.author!,
                    style: TextStyle(
                        fontSize: 13,
                        color: cHeavyGrey
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left:10, bottom: 5),
              child: Text(
                widget.data.title!.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    widget.data.text!,
                    textAlign: TextAlign.justify,
                  ),
                  //SizedBox(height: 10,)
                ),
              ),
            ),
          ],
        ),
    );
  }
}