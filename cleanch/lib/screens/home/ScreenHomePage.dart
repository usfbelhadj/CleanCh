import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

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

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  Color fabButtonColor = Color.fromARGB(255, 59, 177, 161);

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
                color: Color.fromARGB(255, 59, 177, 161),
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
              FlutterMap(
                mapController: MapController(),
                options: MapOptions(
                  center: LatLng(
                      46.782094, 8.056870), // Initial map center coordinates
                  zoom: 7.5, // Initial zoom level
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
                    // My location
                    circles: [
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
                        color:
                            Color.fromARGB(255, 16, 177, 16).withOpacity(0.5),
                        borderColor: Color.fromARGB(255, 16, 177, 16),
                        borderStrokeWidth: 2,
                        radius: 5000,
                      ),
                    ],
                  )
                ],
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
            ],
          ),
        );
      },
    );
  }
}
