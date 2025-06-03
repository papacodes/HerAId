import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:oats_package/data/constants/assist_values.dart';
import 'package:oats_package/views/base/sub_viewmodel.dart';
import 'package:oats_theme/oats_theme.dart';

abstract class MapSubViewModel extends SubViewModel {
  late final MapController mapController;

  final List<Marker> markers = [];

  MapSubViewModel() {
    mapController = MapController();
  }

  @protected
  void addMarkerFromIcon({
    required double? latitude,
    required double? longitude,
    required TintedSvgIcon icon,
    double width = 32,
    double height = 32,
    double bottomOffset = 0,
  }) {
    if (latitude != null && longitude != null) {
      final markerWidget = Container(
        margin: EdgeInsets.only(bottom: bottomOffset),
        child: ThemeWidget(
          builder: (theme) => SvgPicture.asset(
            icon.path,
            width: width,
            height: height,
            colorFilter: icon.getColorFilter(theme),
          ),
        ),
      );

      markers.add(
        Marker(
          point: LatLng(latitude, longitude),
          child: markerWidget,
          width: width,
          height: height + bottomOffset,
        ),
      );

      notifyListeners();
    }
  }

  @protected
  List<LatLng> getPointsFromPolylinePoints(String polylinePoints) {
    var geoPointList = <LatLng>[];
    var index = 0;
    var latitude = 0.0;
    var longitude = 0.0;

    while (index < polylinePoints.length) {
      // Decode latitude
      var result = 0;
      var shift = 0;
      int b;
      do {
        b = polylinePoints.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      var dLatitude = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      latitude += dLatitude;

      // Decode longitude
      result = 0;
      shift = 0;
      do {
        b = polylinePoints.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      var dLongitude = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      longitude += dLongitude;

      geoPointList.add(LatLng(latitude / 1e5, longitude / 1e5));
    }

    return geoPointList;
  }

  @protected
  void moveToLocation({
    required double? latitude,
    required double? longitude,
    bool animated = true,
  }) async {
    if (latitude != null && longitude != null) {
      mapController.move(LatLng(latitude, longitude), AssistValues.initialZoom);
    }
  }

  @protected
  void moveToFitPoints(List<LatLng> points, {EdgeInsets? padding}) {
    if (points.isEmpty) {
      return;
    }

    var minLat = points.first.latitude;
    var maxLat = points.first.latitude;
    var minLng = points.first.longitude;
    var maxLng = points.first.longitude;

    for (final point in points) {
      if (point.latitude < minLat) {
        minLat = point.latitude;
      }
      if (point.latitude > maxLat) {
        maxLat = point.latitude;
      }
      if (point.longitude < minLng) {
        minLng = point.longitude;
      }
      if (point.longitude > maxLng) {
        maxLng = point.longitude;
      }
    }

    final bounds = LatLngBounds(
      LatLng(minLat, minLng),
      LatLng(maxLat, maxLng),
    );
    final cameraFit = CameraFit.bounds(
      bounds: bounds,
      padding: padding ?? const EdgeInsets.all(20),
    );

    mapController.fitCamera(cameraFit);
  }
}
