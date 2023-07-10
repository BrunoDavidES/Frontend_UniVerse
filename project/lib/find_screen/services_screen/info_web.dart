import 'package:UniVerse/find_screen/maps_screen/maps_for_web.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../consts/color_consts.dart';

class InfoWeb extends StatelessWidget {
  final String name;
  final AssetImage image;
  final String? link;
  final bool? toShowMap;

  const InfoWeb({super.key, required this.name, required this.image, this.link, this.toShowMap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var containerHeight = size.height/1.5;
    var containerWidth = size.width/1.5;
    return Container(
      height: containerHeight,
      width: containerWidth,
      color: cDirtyWhite,
      child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: cHeavyGrey),
            boxShadow: [ BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0,0),
            ),
            ],
            color: cDirtyWhiteColor
        ),
        child: Row(
            children: [
        Container(
        width: containerWidth-containerWidth/3.5-15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:15, top: 15, bottom:5),
                child: Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: cHeavyGrey,
                      fontSize: 25
                  ),
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(left:15),
                width: double.infinity,
                height: containerHeight/1.5,
                child:SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(toShowMap!)
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              content: MapsPageWeb(),
                            ),
                          );
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "Sabe a localização de $name ",
                            children: <TextSpan>[
                              TextSpan(
                                text: 'aqui.\n',
                                style: TextStyle(decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //texto da info
                      if(link!=null && link!.isNotEmpty)
                        InkWell(
                          onTap: () {
                            launchUrl(Uri.parse(link!));
                          },
                          child: Text.rich(
                            TextSpan(
                              text: "Sabe mais ",
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
                  ),
                ),
              ),
            ],
          ),
        ),
          Spacer(),
          Container(
              width: containerWidth/3.5-15,
              decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage("assets/images/welcome_photo.jpg"),
          fit: BoxFit.cover),
      borderRadius: BorderRadius.circular(15),
    ),
    ),
            ],
    )
    ),
    );
  }
}