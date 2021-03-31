import 'package:beammart_merchants/providers/profile_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../models/profile.dart';
import '../providers/add_business_profile_provider.dart';
import '../providers/auth_provider.dart';

class AddLocationMap extends StatefulWidget {
  static const String routeName = '/add-location';
  final GeoPoint? currentLocation;
  final String? businessName;
  final String? businessDescription;
  final String? city;
  final String? locationDescription;
  final String? mondayOpeningHour;
  final String? mondayClosingHour;
  final String? tuesdayOpeningHour;
  final String? tuesdayClosingHour;
  final String? wednesdayOpeningHour;
  final String? wednesdayClosingHour;
  final String? thursdayOpeningHour;
  final String? thursdayClosingHour;
  final String? fridayOpeningHour;
  final String? fridayClosingHour;
  final String? saturdayOpeningHour;
  final String? saturdayClosingHour;
  final String? sundayOpeningHour;
  final String? sundayClosingHour;
  final String? phoneNumber;

  const AddLocationMap({
    Key? key,
    this.currentLocation,
    this.businessName,
    this.city,
    this.locationDescription,
    this.businessDescription,
    this.mondayOpeningHour,
    this.mondayClosingHour,
    this.tuesdayOpeningHour,
    this.tuesdayClosingHour,
    this.wednesdayOpeningHour,
    this.wednesdayClosingHour,
    this.thursdayOpeningHour,
    this.thursdayClosingHour,
    this.fridayOpeningHour,
    this.fridayClosingHour,
    this.saturdayOpeningHour,
    this.saturdayClosingHour,
    this.sundayOpeningHour,
    this.sundayClosingHour,
    this.phoneNumber,
  }) : super(key: key);

  @override
  _AddLocationMapState createState() => _AddLocationMapState();
}

class _AddLocationMapState extends State<AddLocationMap> {
  final Set<Marker> _markers = {};
  Location location = new Location();
  double? _latitude;
  double? _longitude;
  bool _isMapCreated = false;
  GoogleMapController? _controller;
  CameraPosition? _cameraPosition;
  bool _saving = false;

  getCurrentLocation() async {
    final _locationData = await location.getLocation();
    final CameraPosition currentPosition = CameraPosition(
      target: LatLng(
        _locationData.latitude!,
        _locationData.longitude!,
      ),
      zoom: 50,
    );
    setState(() {
      _latitude = _locationData.latitude;
      _longitude = _locationData.longitude;
      _cameraPosition = currentPosition;
      _markers.add(
        Marker(
          markerId: MarkerId(_cameraPosition.toString()),
          position: LatLng(_locationData.latitude!, _locationData.longitude!),
          onTap: () {},
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
      );
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<ProfileProvider>(context);
    final _businessProfileProvider =
        Provider.of<AddBusinessProfileProvider>(context);
    return Scaffold(
      appBar: (widget.currentLocation != null)
          ? AppBar(
              title: Text("Edit Store Location"),
              actions: [
                (_latitude != null && _longitude != null)
                    ? TextButton(
                        onPressed: () {
                          setState(() {
                            _saving = true;
                          });
                          locationProvider.changeLocation(
                            locationProvider.profile!.userId!,
                            GeoPoint(_latitude!, _longitude!),
                          );
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Container()
              ],
            )
          : AppBar(
              title: Text('Add Location'),
              actions: [
                (_latitude != null && _longitude != null)
                    ? TextButton(
                        onPressed: () {
                          setState(() {
                            _saving = true;
                          });

                          if (_businessProfileProvider
                                  .profile.businessProfilePhoto !=
                              null) {
                            locationProvider.addBusinessProfile(
                              Profile(
                                businessName: _businessProfileProvider
                                    .profile.businessName,
                                businessDescription: _businessProfileProvider
                                    .profile.businessDescription,
                                userId: locationProvider.profile!.userId,
                                storeId: locationProvider.profile!.userId,
                                city: _businessProfileProvider.profile.city,
                                locationDescription: _businessProfileProvider
                                    .profile.locationDescription,
                                phoneNumber: _businessProfileProvider
                                    .profile.phoneNumber,
                                gpsLocation: GeoPoint(_latitude!, _longitude!),
                                mondayOpeningHours: _businessProfileProvider
                                    .profile.mondayOpeningHours,
                                mondayClosingHours: _businessProfileProvider
                                    .profile.mondayClosingHours,
                                tuesdayOpeningHours: _businessProfileProvider
                                    .profile.tuesdayOpeningHours,
                                tuesdayClosingHours: _businessProfileProvider
                                    .profile.tuesdayClosingHours,
                                wednesdayOpeningHours: _businessProfileProvider
                                    .profile.wednesdayOpeningHours,
                                wednesdayClosingHours: _businessProfileProvider
                                    .profile.wednesdayClosingHours,
                                thursdayOpeningHours: _businessProfileProvider
                                    .profile.thursdayOpeningHours,
                                thursdayClosingHours: _businessProfileProvider
                                    .profile.thursdayClosingHours,
                                fridayOpeningHours: _businessProfileProvider
                                    .profile.fridayOpeningHours,
                                fridayClosingHours: _businessProfileProvider
                                    .profile.fridayClosingHours,
                                saturdayOpeningHours: _businessProfileProvider
                                    .profile.saturdayOpeningHours,
                                saturdayClosingHours: _businessProfileProvider
                                    .profile.saturdayClosingHours,
                                sundayOpeningHours: _businessProfileProvider
                                    .profile.sundayOpeningHours,
                                sundayClosingHours: _businessProfileProvider
                                    .profile.sundayClosingHours,
                                isMondayOpen: _businessProfileProvider
                                    .profile.isMondayOpen,
                                isTuesdayOpen: _businessProfileProvider
                                    .profile.isTuesdayOpen,
                                isWednesdayOpen: _businessProfileProvider
                                    .profile.isWednesdayOpen,
                                isThursdayOpen: _businessProfileProvider
                                    .profile.isThursdayOpen,
                                isFridayOpen: _businessProfileProvider
                                    .profile.isFridayOpen,
                                isSaturdayOpen: _businessProfileProvider
                                    .profile.isSaturdayOpen,
                                isSundayOpen: _businessProfileProvider
                                    .profile.isSundayOpen,
                                businessProfilePhoto: _businessProfileProvider
                                    .profile.businessProfilePhoto,
                              ).toJson(),
                              locationProvider.profile!.userId!,
                            );
                            Navigator.popUntil(
                                context, ModalRoute.withName('/'));
                          }
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
      body: (_saving == false)
          ? Stack(
              children: [
                Positioned(
                  child: Container(
                    child: Text('Tap on the map to change your store location'),
                  ),
                ),
                (_cameraPosition != null)
                    ? GoogleMap(
                        onTap: (LatLng location) {
                          setState(() {
                            _markers.clear();
                            _markers.add(
                              Marker(
                                markerId: MarkerId(_cameraPosition.toString()),
                                position: LatLng(
                                    location.latitude, location.longitude),
                                onTap: () {},
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueAzure),
                              ),
                            );
                            _latitude = location.latitude;
                            _longitude = location.longitude;
                          });
                        },
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        initialCameraPosition: _cameraPosition!,
                        mapToolbarEnabled: false,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: true,
                        markers: _markers,
                        trafficEnabled: false,
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      )
              ],
            )
          : LinearProgressIndicator(),
    );
  }
}
