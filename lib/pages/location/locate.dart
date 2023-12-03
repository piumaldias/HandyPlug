
import 'package:flutter/material.dart';
import 'package:search_map_location/search_map_location.dart';
import 'package:search_map_location/utils/google_search/place.dart';
import 'package:url_launcher/url_launcher.dart';

class GetLocation extends StatefulWidget {
  final Function(Place) onLocationSelected;

  const GetLocation({Key? key, required this.onLocationSelected})
      : super(key: key);

  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SearchLocation(
            apiKey: "AIzaSyBEfhdAQwHbYXy5qEIr0QaluAkbT4Rn8Mo",
            onSelected: (Place place) {
              // Pass the selected location back to the parent widget
              widget.onLocationSelected(place);
              // Close the bottom sheet
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
Future<void> launchMapUrl(String address,String store) async {
  String encodedAddress = Uri.encodeComponent(store+"," +address);
  Uri googleMapUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$encodedAddress");

  try {
    if (await canLaunchUrl(googleMapUrl)) {
      await launchUrl(googleMapUrl );
    }
  } catch (error) {
    throw("Cannot launch Google map");
  }
}