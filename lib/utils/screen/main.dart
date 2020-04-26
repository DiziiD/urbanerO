import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:urbaner/requests/google_maps_requests.dart';
import 'package:geolocator/geolocator.dart';
import 'package:urbaner/utils/core.dart';



void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

@override
Widget build(BuildContext context) {
  return MaterialApp(
   home: Scaffold(
      body: Map()
  )
  );
  }
}

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

  class _MapState extends State<Map> {
    GoogleMapController mapController;
    static LatLng _center;
    LatLng _lastPosition = _center;
    GoogleMapsPlaces googlePlaces;
    GoogleMapsServives googleMapsServices = GoogleMapsServives();
    TextEditingController locationController = TextEditingController();
    TextEditingController destinationController = TextEditingController();
    final Set<Marker> _markers = {};
    final Set<Polyline> poly = {};

    @override
    void initState() {
    super.initState();
    _getUserLocation();
   // locationController.text = "current location";

    }

    @override
    Widget build(BuildContext context) {
      return _center == null? Container(
        alignment: Alignment.center,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _center,
                zoom: 10.0),
            onMapCreated: onCreated,
            myLocationEnabled: true,
            mapType: MapType.normal,
            compassEnabled: true,
            markers: _markers,
            onCameraMove: _onCameraMove,
          ),

    Positioned (
      top: 50.0,
      right: 15.0,
      left: 15.0,
      child: Container (
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(1.0, 5.0),
              blurRadius: 10,
              spreadRadius: 3)
          ]
      ),

      child: TextField(
      cursorColor: Colors.black,
        controller: locationController,
        decoration: InputDecoration (
          icon: Container(margin: EdgeInsets.only(left: 20, top: 5,), width: 10, height: 10, child: Icon(Icons.location_on, color:
            Colors.black,),),
      hintText: "pick up",
      border: InputBorder.none,
      contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
          ),)
        ),
      ),

     Positioned(
       top: 105.0,
       right: 15.0,
       left: 15.0,
       child: Container (
         height: 50.0,
         width: double.infinity,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(3.0),
           color: Colors.white,
           boxShadow: [
             BoxShadow(
               color: Colors.grey,
               offset: Offset(1.0, 5.0),
               blurRadius: 10,
               spreadRadius: 3)
               ],
             ),
      child: TextField(
      cursorColor: Colors.blue.shade900,
      decoration: InputDecoration(
        icon: Container(margin: EdgeInsets.only(left: 20, top: 5), width: 10, height: 10, child: Icon(Icons.local_taxi, color: Colors.blue.shade900,),),
        hintText: "destination?",
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
      ),

         ),
       ),
     )




        ],
      );
    }


    void onCreated(GoogleMapController controller) {
      setState(() {
        mapController = controller;
      });
    }

    void _onCameraMove(CameraPosition position) {
      setState(() {
        _lastPosition = position.target;
      });
    }

    void _onAddMarkerPressed() {
      setState(() {
        _markers.add(Marker(markerId: MarkerId(_lastPosition.toString()),
            position: _lastPosition,
            infoWindow: InfoWindow(
                title: "marker here",
                snippet: "Remember here"
            ),
            icon: BitmapDescriptor.defaultMarker
        ));
      });
    }

    List decolePoly(String poly) {
      var list=poly.codeUnits;
      var lList=new List();
      int index=0;
      int len=poly.length;
      int c=0;
      do {
        var shift = 0;
        int result = 0;

        do {
          c = list[index] - 63;
          result |= (c & 0x1F) << (shift * 5);
          index++;
          shift++;
        } while (c >= 32);
        if (result & 1 == 1) {
          result + ~result;
        }
        var result1 = (result >> 1) * 0.00001;
        lList.add(result1);
      } while(index<len);

      for(var i=2; i<lList.length;i++)
        lList[i]+=lList[i-2];

      print(lList.toString());

      return lList;

        }

  void _getUserLocation() async{
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy:LocationAccuracy.high);
     List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
      setState(() {
       _center = LatLng(position.latitude, position.longitude);
       locationController.text = placemark[0].name;
      });
    }
    }















