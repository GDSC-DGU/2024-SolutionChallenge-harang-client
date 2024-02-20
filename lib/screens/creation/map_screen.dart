import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocode;

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Location location = Location();
  final Set<Marker> _markers = {};
  LatLng _currentPosition =
      const LatLng(37.5665, 126.9780); // 서울의 좌표를 초기 위치로 설정

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // 위치 서비스 활성화 확인
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // 위치 권한 상태 확인
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final LocationData locationData = await location.getLocation();
      setState(() {
        _currentPosition =
            LatLng(locationData.latitude!, locationData.longitude!);
        _updateMarker(_currentPosition);
      });
    } catch (e) {
      print("Could not get the location: $e");
    }
  }

  void _updateMarker(LatLng position) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: const MarkerId('selectedLocation'),
        position: position,
      ));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<geocode.Placemark> placemarks = await geocode
          .placemarkFromCoordinates(position.latitude, position.longitude);
      geocode.Placemark place = placemarks.first;
      print("위도: ${position.latitude}, 경도: ${position.longitude}");
      print("주소: ${place.street}, ${place.locality}, ${place.country}");
    } catch (e) {
      print("주소를 찾을 수 없습니다: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition,
                    zoom: 18.0,
                  ),
                  markers: _markers,
                  onTap: _updateMarker,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
              ),
              ElevatedButton(
                onPressed: () => _getAddressFromLatLng(_currentPosition),
                child: const Text('Find My Location'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
