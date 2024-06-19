import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapHelper {
  static Future<Widget> buildMap(
    BuildContext context, {
    required MapController mapController,
    GeoPoint? initialPosition,
    ZoomOption? zoomOption,
    UserTrackingOption? userTrackingOption,
    MarkerOption? markerOption,
    RoadOption? roadConfiguration,
    List<UserLocationMaker>? markers,
    Icon? userLocationIcon,
    OSMOption? osmOption,
  }) async =>
      Stack(
        children: [
          OSMFlutter(
            controller: mapController,
            onMapIsReady: (controller) {
              addMarkerToMap(
                mapController, /* pass latitude and longitude here */
              );
            },
            osmOption: osmOption ??
                OSMOption(
                  zoomOption: zoomOption ?? const ZoomOption(initZoom: 20),
                  markerOption: MarkerOption(
                    defaultMarker: const MarkerIcon(
                      icon: Icon(
                        Icons.pin_drop_rounded, //TODO: use icons provided by designers.
                        color: Colors.red,
                        size: 56,
                      ),
                    ),
                  ),
                  roadConfiguration: roadConfiguration ??
                      const RoadOption(
                        roadColor: Colors.yellow,
                        roadBorderColor: Colors.blue,
                      ),
                  userLocationMarker: UserLocationMaker(
                    personMarker: const MarkerIcon(
                      icon: Icon(
                        Icons.access_alarm, //TODO: use icons provided by designers.
                        color: Colors.grey,
                        size: 48,
                      ),
                    ),
                    directionArrowMarker: const MarkerIcon(
                      icon: Icon(
                        Icons.double_arrow, //TODO: use icons provided by designers.
                        size: 48,
                      ),
                    ),
                  ),
                ),
          ),
        ],
      );

  static void addMarkerToMap(MapController mapController) {
    mapController.addMarker(
      mapController.initPosition!,
      markerIcon: const MarkerIcon(
        icon: Icon(
          Icons.pin_drop_rounded, //TODO: use icons provided by designers.
          color: Colors.black,
          size: 56,
        ),
      ),
    );
  }
}
