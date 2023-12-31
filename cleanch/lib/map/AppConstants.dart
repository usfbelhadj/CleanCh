import 'package:latlong2/latlong.dart';

class AppConstants {
  static const String mapBoxAccessToken =
      env.token;

  static const String mapBoxStyleId = env.mapStyle;

  static final myLocation = LatLng(51.5090214, -0.1982948);
}
