import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart'; // Add this import for SystemNavigator

import '../../map/AppConstants.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/map_buttons.dart';
import 'home.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  get mapBoxAccessToken => AppConstants.mapBoxAccessToken;
  get mapBoxStyleId => AppConstants.mapBoxStyleId;
  get myLocation => AppConstants.myLocation;
  bool isExpanded = false;

  // transparent color
  Color fabButtonColor = Color.fromARGB(149, 147, 184, 179);

  // current loc
  LatLng? currentLocation;

  MapController _mapController = MapController();

  // fetch current loc
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

      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        _mapController.move(currentLocation!, _mapController.zoom);
      });
    } catch (e) {
      print("Error getting current location: $e");
    }
  }

  // Check internet connectivity and close the app if there is no internet
  Future<bool> _checkInternetAndShowDialog() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    bool hasInternet = connectivityResult != ConnectivityResult.none;
    if (!hasInternet) {
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent closing the dialog by tapping outside
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Internet Connection'),
            content: Text('Please connect to the internet and try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  SystemNavigator.pop(); // Close app
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
    return hasInternet;
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _checkInternetAndShowDialog();
    });
  }

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          drawer: const MyDrawer(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            excludeHeaderSemantics: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: Colors.black,
                    size: 40,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ),
          floatingActionButton: GestureDetector(
            trackpadScrollCausesScale: true,
            onTap: toggleExpand,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isExpanded ? 150.0 : 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(isExpanded ? 30.0 : 60.0),
                color: fabButtonColor,
              ),
              child: isExpanded
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.report_problem_outlined,
                            color: Colors.white),
                        Icon(Icons.car_crash, color: Colors.white),
                      ],
                    )
                  : Icon(Icons.add, color: Colors.white),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          body: Stack(
            children: [
              // loading on checking
                            FutureBuilder<bool>(
                future: _checkInternetAndShowDialog(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data == false) {
                    return Container(); // empty if no internet
                  }

                  // run if there is networK
                  return FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      center: currentLocation ?? myLocation,
                      zoom: 10.0,
                      minZoom: 3.0,
                      maxZoom: 18.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://api.mapbox.com/styles/v1/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                        additionalOptions: const {
                          'mapStyleId': AppConstants.mapBoxStyleId,
                          'accessToken': AppConstants.mapBoxAccessToken,
                          'id': 'mapbox.mapbox-streets-v8',
                        },
                      ),
                      CircleLayer(
                        // my loc
                        circles: [
                          CircleMarker(
                            useRadiusInMeter: true,
                            point: currentLocation ?? myLocation,
                            color: Color.fromARGB(255, 35, 114, 134)
                                .withOpacity(0.5),
                            borderColor: Color.fromARGB(255, 58, 99, 133),
                            borderStrokeWidth: 5,
                            radius: 180,
                          ),
                          CircleMarker(
                            useRadiusInMeter: true,
                            point: LatLng(46.782094, 8.056870),
                            color: Colors.red.withOpacity(0.5),
                            borderColor: Colors.red,
                            borderStrokeWidth: 2,
                            radius: 5000,
                          ),
                          CircleMarker(
                            useRadiusInMeter: true,
                            point: LatLng(46.897, 7.490),
                            color: Color.fromARGB(255, 16, 177, 16)
                                .withOpacity(0.5),
                            borderColor: Color.fromARGB(255, 16, 177, 16),
                            borderStrokeWidth: 2,
                            radius: 5000,
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      String phoneNumber = '55856615';
                      launch("tel:$phoneNumber");
                    },
                    child: Icon(Icons.phone),
                    backgroundColor: fabButtonColor,
                  ),
                ),
              ),
              // curr loc but
              Align(
                alignment: Alignment.centerRight,
                child: FractionallySizedBox(
                  heightFactor: 0.2,
                  child: Padding(
                    padding: EdgeInsets.only(top: 80.0, right: 16.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        if (currentLocation != null) {
                          _mapController.move(currentLocation!, 15);
                        }
                        print('My Location : $currentLocation');
                      },
                      child: Icon(Icons.my_location),
                      backgroundColor: fabButtonColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
