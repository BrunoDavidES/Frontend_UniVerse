
import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../personal_event_screen/personal_event_app.dart';
import '../personal_event_screen/personal_event_web.dart';
import '../utils/events/personal_event_data.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CalendarEventCard extends StatefulWidget {
  CalendarEventCard(this.data, {super.key, required this.color});
  CalendarEvent data;
  final Color color;

  @override
  State<StatefulWidget> createState() => CalendarEventState();
}

class CalendarEventState extends State<CalendarEventCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
   return InkWell(
     onTap: () {
       showDialog(
           context: context,
           builder: (_) => AlertDialog(
             backgroundColor: cDirtyWhiteColor,
             shape: RoundedRectangleBorder(
                 borderRadius:
                 BorderRadius.all(
                     Radius.circular(10.0)
                 )
             ),
             content: kIsWeb
             ?PersonalEventWeb(toCreate: false, toEdit:false, data: widget.data,/*focusDay: focusedDay*/)
             :PersonalEventApp(toCreate: false, toEdit:false, data: widget.data,/*focusDay: focusedDay*/)
           )
       );
     },
     child: Container(
              margin: const EdgeInsets.only(right: 10, bottom: 10, left:10),
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 5),
              width: size.width-100,
              decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(10),

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                       Text(
                              widget.data.title!,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: cDirtyWhiteColor
                              ),
                            ),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Icon(Icons.location_on_outlined, color: cDirtyWhite,),
                      SizedBox(width: 5,),
                      Text(
                        widget.data.location!,
                        style: const TextStyle(
                            fontSize: 13,
                            color: cDirtyWhiteColor
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.access_time, color: cDirtyWhite,),
                      SizedBox(width:5),
                      Text(
                        widget.data.hour!,
                        style: const TextStyle(
                            fontSize: 15,
                            color: cDirtyWhiteColor
                        ),
                      ),
                    ],
                  )
                ],
              ),
          ),
   );
  }
}