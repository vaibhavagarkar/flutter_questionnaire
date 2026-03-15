import 'package:geolocator/geolocator.dart';

import '../../domain/models/app_location.dart';
import '../../domain/services/location_service_contract.dart';

class LocationService implements LocationServiceContract {
  @override
  Future<void> requestPermissionOnAppStart() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
  }

  @override
  Future<AppLocation> determineLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationException('Location services are disabled.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw const LocationException('Location permission is required.');
    }

    final position = await Geolocator.getCurrentPosition();
    return AppLocation(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}

class LocationException implements Exception {
  const LocationException(this.message);

  final String message;

  @override
  String toString() => message;
}
