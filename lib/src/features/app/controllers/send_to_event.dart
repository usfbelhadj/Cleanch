import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:myflutter/src/features/app/home/home.dart';

import '../../../utils/translation/translation.dart';
import '../events/fetch.dart';
import 'event_model.dart';

// when i click on the gesterdector from the home screen should diplay the event in another screen

class EventDetailsDialogs extends StatelessWidget {
  final Event event;
  const EventDetailsDialogs({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 150, 222, 255),
        automaticallyImplyLeading: false,
        title: Text(event.eventType),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => HomeScreen());
            },
            icon: Icon(Icons.close),
          )
        ],
      ),
      body: Center(
        heightFactor: 1.3,
        child: SizedBox(
          height: 500,
          width: 390,
          child: Card(
            elevation: 10,
            color: Color.fromARGB(255, 227, 231, 227),
            shadowColor: Color.fromARGB(255, 10, 10, 10),
            child: ListTile(
              title: Text(tr('Eventtypetxt') + '${event.eventType}',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      height: 120,
                      child: event.eventType == 'DangerZone'
                          ? Image.asset(
                              'assets/images/traffic/bluetraffic.png',
                            )
                          : Image.asset(
                              'assets/images/traffic/traffic.png',
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    tr(('Eventdatetxt')) +
                        '${DateFormat('y-MM-d: H:mm').format(event.eventDate).toString()}',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    tr(('eventMessage')) + event.message.toString() ??
                        'No message available.',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<String>(
                    future: fetchEventAddress(event.latitude, event.longitude),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error fetching address: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text('No address available.');
                      } else {
                        return Text(
                          'Event Address: ${snapshot.data}',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              color: Colors.black),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
