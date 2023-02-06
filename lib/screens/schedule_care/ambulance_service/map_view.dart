import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_webservice/places.dart';
import 'package:syren/controllers/location_controller.dart';
import 'package:syren/models/models.dart';
import 'package:syren/services/places_service.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

class MapScreen extends StatelessWidget {
  late PlaceLocationModel initialLocation;
  final bool isSelecting;

  final mapCtrl = Get.put(MapController());

  MapScreen(
      {super.key,
      this.initialLocation =
          const PlaceLocationModel(latitude: 37.422, longitude: -122.084),
      this.isSelecting = false});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          title: const Text('Syren Tracker'),
          actions: [
            if (isSelecting)
              IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: (mapCtrl.pickedLocation.value == null)
                      ? null
                      : () {
                          Navigator.of(context)
                              .pop(mapCtrl.pickedLocation.value);
                        }),
          ],
        ),
        body: Stack(children: [
          GoogleMap(
            myLocationEnabled: true,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1,
              bottom: MediaQuery.of(context).size.height * 0.1,
            ),
            mapType: MapType.normal, //map type
            zoomGesturesEnabled: true, //enable Zoom in, out on map
            initialCameraPosition: CameraPosition(
                target:
                    LatLng(initialLocation.latitude, initialLocation.longitude),
                zoom: 16),
            onMapCreated: (controller) {
              //method called when map is created
              mapCtrl.googleMapCtrl = controller;
            },
            onTap: mapCtrl
                .selectLocation, //isSelecting ? mapCtrl.selectLocation : null,
            markers:
                //(mapCtrl.pickedLocation.value ==
                //         null) // (mapCtrl.pickedLocation.value == null && isSelecting)
                //     ? {}
                //:
                {
              Marker(
                  markerId: const MarkerId('m1'),
                  position: mapCtrl.pickedLocation.value ??
                      LatLng(
                          initialLocation.latitude, initialLocation.longitude))
            },
          ),
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              // height: MediaQuery.of(context).size.height * 0.3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFormField(
                      controller: mapCtrl.searchCtrl,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search_outlined),
                          filled: true,
                          fillColor: Palette.white,
                          hintText: 'Search locations...'),
                    ),
                    // Expanded(
                    //     child: ListView.builder(
                    //         itemCount: mapCtrl._predictionList.length,
                    //         itemBuilder: (context, index) {
                    //           var item = mapCtrl._predictionList[index];
                    //           return ListTile(
                    //             onTap: () async {
                    //               await locationFromAddress(item.description!);
                    //             },
                    //             title: Text(item.description!),
                    //           );
                    //         })),
                    PrimaryButton(title: 'Confirm Location', press: () {})
                  ],
                ),
              ))
        ])));
  }
}

class MapController extends GetxController {
  // Services.
  var placeSrv = Get.put(PlacesService());

  // Controllers.
  GoogleMapController? googleMapCtrl; //contrller for Google map.
  TextEditingController searchCtrl = TextEditingController();

  // Observables.
  Rxn<LatLng> pickedLocation = Rxn<LatLng>();
  RxString location = "Search Location".obs;
  List<Prediction> _predictionList = <Prediction>[].obs;
  RxList<PlaceSearchModel> _placeSearchList = <PlaceSearchModel>[].obs;

  @override
  void onInit() {
    searchCtrl.addListener(() {
      onChange();
    });
    super.onInit();
  }

  @override
  void onClose() {
    searchCtrl.dispose();
    super.onClose();
  }

  Future<List<Prediction>> searchLocation(String? search) async {
    if (search != null && search.isNotEmpty) {
      http.Response response = await http.get(Uri(
          host:
              '${dotenv.get('MAP_PLACES_BASE_URL')}?input=$search&types=(cities)&key=${dotenv.get('MAP_API_KEY')}'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        _predictionList = data['predictions'];
      } else {
        throw Exception('Failed to load data');
      }
    }

    return _predictionList;
  }

  void onChange() async {
    // _placeSearchList.value =
    //   await placeSrv.getAutocomplete(searchCtrl.text.trim());
  }

  void selectLocation(LatLng position) {
    pickedLocation.value = position;
    searchCtrl.text = position.toString();
  }
}
