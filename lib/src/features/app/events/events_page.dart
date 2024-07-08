// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myflutter/src/constants/sizes.dart';
import 'package:myflutter/src/features/app/controllers/get_event_api.dart';
import 'package:myflutter/src/features/app/home/home.dart';

import 'package:myflutter/src/features/app/controllers/event_model.dart';
import 'package:intl/intl.dart';
import 'package:myflutter/src/utils/translation/translation.dart';

import 'fetch.dart';

class EventsPage extends StatefulWidget {
  static const String routeName = '/events';

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage>
    with AutomaticKeepAliveClientMixin {
  late Future<List<Event>> _eventsFuture;

  @override
  void initState() {
    super.initState();
    _eventsFuture = EventApi.fetchEvents();
  }

  @override
  void dispose() {
    // Cancel the timer or remove any listeners here.
    _eventsFuture = EventApi.fetchEvents();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 150, 222, 255),
        leading: IconButton(
          onPressed: () => Get.offAll(HomeScreen()),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          tr('eventsText'),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(DefaultSize),
          child: FutureBuilder<List<Event>>(
            future: _eventsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Check Your Connection');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No events available.');
              } else {
                return Column(
                  children: snapshot.data!
                      .map((event) => _buildEventCard(event))
                      .toList(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(Event event) {
    return Card(
      child: ListTile(
        title: Text(tr('Eventtypetxt') + '${event.eventType}',
            style: Theme.of(context).textTheme.titleLarge),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr(('Eventdatetxt')) +
                  'Event Date: ${DateFormat('y MMM EEEE d H:m').format(event.eventDate).toString()}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              tr(('eventMessage')) + event.message.toString() ??
                  'No message available.',
              style: TextStyle(
                  fontSize: 20, fontFamily: 'Roboto', color: Colors.black),
            ),
            FutureBuilder<String>(
              future: fetchEventAddress(event.latitude, event.longitude),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Check Your Connection ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No address available.');
                } else {
                  return Text('Event Address: ${snapshot.data}',
                      style: Theme.of(context).textTheme.bodyMedium);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
