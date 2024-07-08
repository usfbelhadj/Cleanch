// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myflutter/src/features/app/controllers/event_model.dart';
import 'package:myflutter/src/utils/translation/translation.dart';

import '../events/fetch.dart';
import 'send_to_event.dart';

class EventDetailsDialog {
  static void show(BuildContext context, Event event) async {
    var a = await fetchEventAddress(event.latitude, event.longitude);
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return GestureDetector(
            onTap: () => Get.to(EventDetailsDialogs(event: event)),
            child: SizedBox(
              height: 170,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: event.eventType == 'DangerZone'
                        ? Image.asset(
                            'assets/images/traffic/bluetraffic.png',
                            height: 50,
                            width: 50,
                          )
                        : Image.asset(
                            'assets/images/traffic/traffic.png',
                            height: 50,
                            width: 50,
                          ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        tr('EventDetailstxt'),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(tr('Eventtypetxt') + '${event.eventType}'),
                      Text(tr('Eventdatetxt') +
                          ' ${DateFormat(' MM-dd-y').format(event.eventDate)}'),

                      SizedBox(
                        width: 290,
                        child: Text(
                            '${event.eventType} : ' + '${a.substring(0, 30)}',
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),

                      // SizedBox(
                      //   height: 16,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
