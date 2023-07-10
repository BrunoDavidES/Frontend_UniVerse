import 'package:UniVerse/find_screen/maps_screen/map_id_location_screen_app.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../consts/color_consts.dart';

class InfoDetailScreen extends StatelessWidget {
final String text;
final String id;
final String? link;
  InfoDetailScreen( {super.key,required this.text, this.link, required this.id});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.only(left:10, top:40, bottom: 10, right: 10),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(
              color: cHeavyGrey,
          ),
          boxShadow: [ BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0,0),
          ),
          ],
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: AssetImage("assets/images/welcome_photo.jpg"),
              fit: BoxFit.cover),
          color: cDirtyWhiteColor
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
                color: cDirtyWhiteColor.withOpacity(0.6)
        ),
              child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {Navigator.pop(context);},
                  color: cHeavyGrey),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 5),
              child: Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: cDirtyWhiteColor,
                    fontSize: 25
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              width: double.infinity,
              height: size.height/2.25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: cDirtyWhiteColor.withOpacity(0.8)
              ),
              child:SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: MapIdLocationApp(id: id),
                          ),
                        );
                      },
                      child: Text.rich(
                        TextSpan(
                          text: "Sabe a localização de $text ",
                          children: <TextSpan>[
                            TextSpan(
                              text: 'aqui.\n',
                              style: TextStyle(decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if(link!=null && link!.isNotEmpty)
                      InkWell(
                        onTap: () {
                          launchUrl(Uri.parse(link!));
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "Sabe mais sobre ",
                            children: <TextSpan>[
                              TextSpan(
                                text: 'aqui.',
                                style: TextStyle(decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                )
              ),
            ),
          ],
        ),

        /*Container(
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
            ],*/
      ),
    );
  }
}