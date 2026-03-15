import '../models/app_location.dart';

abstract class LocationServiceContract {
  Future<void> requestPermissionOnAppStart();

  Future<AppLocation> determineLocation();
}
