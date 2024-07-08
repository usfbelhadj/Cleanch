import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myflutter/src/features/app/controllers/event_details.dart';
import 'package:myflutter/src/features/app/controllers/event_model.dart';
import 'package:myflutter/src/features/app/controllers/get_event_api.dart';
import 'package:myflutter/src/features/app/controllers/send_event_api.dart';
import 'package:myflutter/src/features/app/home/widget/map.dart';
import '../../../common_widgets/nav_bar/my_nav_bar.dart';
import '../../../utils/translation/translation.dart';

// To accomplish this task, you would first initialize the map with the given LatLng coordinates. Then, you would use a location plugin to get the current location of the user. The user's location can be fetched using the location plugin's 'getCurrentLocation' method. This will return a LocationData object that contains the latitude and longitude of the user's current location. You can then update the map's center to the user's current location using the 'animateCamera' method of the GoogleMapController. This will ensure that the map opens at the specified location, but also knows and can update to the user's current location.

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  bool _mounted = false;

  final EventService _eventService = EventService();

  LatLng? currentLocation;
  bool showFloatingButtons = false;
  void toggleFloatingButtons() {
    setState(() {
      showFloatingButtons = !showFloatingButtons;
    });
  }

  void hideFloatingButtons() {
    setState(() {
      showFloatingButtons = false;
    });
  }

  MapController _mapController = MapController();

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    // permission
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print('Location permissions are denied.');
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      if (_mounted) {
        setState(() {
          currentLocation = LatLng(position.latitude, position.longitude);
          _mapController.move(
            currentLocation!,
            12.0,
          );
        });
      }
    } catch (e) {
      if (_mounted) {
        print("Error getting current location: $e");
      }
    }
  }

  LatLng myLocation = AppConstants.theLocation;

  void moveToCurrentLocation() {
    if (currentLocation != null) {
      print(currentLocation);
      _mapController.move(currentLocation!, 15.0);
    }
  }

  Future<void> _sendEvent(String eventType) async {
    if (currentLocation != null) {
      await _eventService.sendEvent(eventType, currentLocation!);
    }
  }

  List<Event> events = [];
  Future<void> _fetchEvents() async {
    final fetchedEvents = await EventApi.fetchEvents();

    setState(() {
      events = fetchedEvents;
    });
  }

  void _showEventDetails(Event event) {
    EventDetailsDialog.show(context, event);
  }

  @override
  void initState() {
    super.initState();
    _mounted = true;
    _getCurrentLocation();
    _fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: myLocation,
          zoom: 7.0,
          minZoom: 3.0,
          maxZoom: 18.0,
          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
            additionalOptions: {
              'mapStyleId': AppConstants.mapBoxStyleId,
              'accessToken': AppConstants.mapBoxAccessToken,
              'id': 'mapbox.mapbox-streets-v8',
            },
          ),
          MarkerLayer(
            markers: [
              // Current location marker
              Marker(
                width: MediaQuery.of(context).size.width * 0.09,
                height: MediaQuery.of(context).size.width * 0.09,
                point: currentLocation ?? myLocation,
                builder: (ctx) => Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: MediaQuery.of(context).size.width * 0.1,
                ),
              ),
              for (Event event in events)
                Marker(
                  width: MediaQuery.of(context).size.width * 0.09,
                  height: MediaQuery.of(context).size.width * 0.09,
                  point: LatLng(event.latitude, event.longitude),
                  builder: (ctx) {
                    if (event.eventType == 'DangerZone') {
                      return GestureDetector(
                        onTap: () => _showEventDetails(event),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // color: Color.fromARGB(255, 7, 231, 18),
                          ),
                          child: Image.asset(
                            'assets/images/traffic/bluetraffic.png',
                            width: MediaQuery.of(context).size.width * 0.09,
                            height: MediaQuery.of(context).size.width * 0.09,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      );
                    } else if (event.eventType == 'Traffic') {
                      return GestureDetector(
                        onTap: () => _showEventDetails(event),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // color: Color.fromARGB(255, 7, 231, 18),
                          ),
                          child: Image.asset(
                            'assets/images/traffic/traffic.png',
                            width: MediaQuery.of(context).size.width * 0.09,
                            height: MediaQuery.of(context).size.width * 0.09,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () => _showEventDetails(event),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // color: Color.fromARGB(255, 7, 231, 18),
                          ),
                          child: Image.asset(
                            'assets/images/traffic/greetraffic.png',
                            width: MediaQuery.of(context).size.width * 0.09,
                            height: MediaQuery.of(context).size.width * 0.09,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      );
                    }
                  },
                ),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.width * 0.175,
            right: MediaQuery.of(context).size.width * -0.07, // Move down
            child: GestureDetector(
              onTap: toggleFloatingButtons,
              child: Image.asset(
                'assets/images/traffic/warning.png',
                width: 140, // Set the width of the image
                height: 140,
                fit: BoxFit.contain, // Set the height of the image
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.width * 0.13,
            left: MediaQuery.of(context).size.width * -0.04, // Move down
            child: GestureDetector(
              onTap: currentLocation != null
                  ? moveToCurrentLocation
                  : _getCurrentLocation,
              child: Image.asset(
                'assets/images/traffic/navigation.png',
                width: 160, // Set the width of the image
                height: 160,
                fit: BoxFit.contain, // Set the height of the image
              ),
            ),
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.02),
        child: BottomNavBarCurvedFb1(
          onLocationButtonPressed: () {
            moveToCurrentLocation();
          },
          onServicesButtonPressed: () {
            (); // Toggle the visibility of floating buttons
          },
          onReportButtonPressed: () {
            toggleFloatingButtons(); // Toggle the visibility of floating buttons
          },
          isHomeScreen: true,
        ),
      ),
      floatingActionButton: showFloatingButtons
          ? Center(
              widthFactor: 1.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // traffic button
                      print('current locations: $currentLocation');
                      _sendEvent('Traffic');
                      hideFloatingButtons();
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(tr('TrafficEvent')),
                          content: Text(tr("TrafficSend")),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Container(
                                color: Colors.green,
                                padding: const EdgeInsets.all(14),
                                child: const Text("Ok",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      child: Text(
                        tr('TrafficText'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        color: Color.fromARGB(255, 76, 230, 89),
                      ),
                    ),
                  ),
                  SizedBox(height: 14),
                  TextButton(
                    onPressed: () {
                      // traffic button
                      print('current locations: $currentLocation');
                      _sendEvent('DangerZone');
                      hideFloatingButtons();
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(tr('DangerEvent')),
                          content: Text(tr("TrafficSend")),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Container(
                                color: Colors.green,
                                padding: const EdgeInsets.all(14),
                                child: const Text("Ok",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      child: Text(
                        tr('dangerZoneText'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        color: Color.fromARGB(255, 32, 138, 209),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
