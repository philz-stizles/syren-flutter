// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:get/get.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:syren/models/models.dart';
// import 'package:syren/utils/palette.dart';
// import 'package:syren/widgets/widgets.dart';

// class MapboxScreen extends StatelessWidget {
//   MapboxScreen(
//       {super.key,
//       this.initialLocation =
//           const PlaceLocationModel(latitude: 37.422, longitude: -122.084),
//       this.isSelecting = false});
//   late PlaceLocationModel initialLocation;
//   final bool isSelecting;

//   final mapCtrl = Get.put(MapController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Syren Tracker'),
//           actions: [
//             if (isSelecting)
//               IconButton(
//                 icon: const Icon(Icons.check), onPressed: () {},
//                 // onPressed: (mapCtrl.pickedLocation.value == null)
//                 //     ? null
//                 //     : () {
//                 //         Navigator.of(context)
//                 //             .pop(mapCtrl.pickedLocation.value);
//                 //       }
//               ),
//           ],
//         ),
//         body: Stack(children: [
//           // FlutterMap(
//           //   options: MapOptions(
//           //     center:
//           //         LatLng(initialLocation.latitude, initialLocation.longitude),
//           //     zoom: 16,
//           //   ),
//           //   // nonRotatedChildren: [
//           //   //   AttributionWidget.defaultWidget(
//           //   //     source: 'OpenStreetMap contributors',
//           //   //     onSourceTapped: null,
//           //   //   ),
//           //   // ],
//           //   children: [
//           //     TileLayer(
//           //       urlTemplate: dotenv.get('MAPBOX_URL'),
//           //       additionalOptions: {
//           //         'accessToken': dotenv.get('MAPBOX_TOKEN'),
//           //         'id': 'mapbox.mapbox-streets-v8'
//           //       },
//           //       // userAgentPackageName: 'com.example.app',
//           //     ),
//           //     MarkerLayer(
//           //       markers: [
//           //         Marker(
//           //             // width: 50,
//           //             // height: 50,
//           //             point: LatLng(
//           //                 initialLocation.latitude, initialLocation.longitude),
//           //             builder: (BuildContext context) {
//           //               return const Icon(
//           //                 Icons.location_on,
//           //                 color: Palette.red,
//           //                 size: 50,
//           //               );
//           //             })
//           //       ],
//           //     )
//           //   ],
//           //),
//           MapboxMap(
//             styleString:
//                 'mapbox://styles/philz-stizles/cld6dz62c000x01mla3wavdy4',
//             accessToken: dotenv.get('MAPBOX_TOKEN'),
//             onMapCreated: mapCtrl._onMapCreated,
//             myLocationEnabled: true,
//             trackCameraPosition: true,
//             initialCameraPosition: CameraPosition(
//               target:
//                   LatLng(initialLocation.latitude, initialLocation.longitude),
//               zoom: 9.0,
//             ),
//             onMapClick: (_, latlng) async {
//               await mapCtrl.mapController?.animateCamera(
//                 CameraUpdate.newCameraPosition(
//                   CameraPosition(
//                     bearing: 10.0,
//                     target: LatLng(
//                       latlng.latitude,
//                       latlng.longitude,
//                     ),
//                     tilt: 30.0,
//                     zoom: 12.0,
//                   ),
//                 ),
//               );
//             },
//           ),
//           Positioned(
//               top: 10,
//               right: 0,
//               left: 0,
//               bottom: 0,
//               // height: MediaQuery.of(context).size.height * 0.3,
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     TextFormField(
//                       controller: mapCtrl.searchCtrl,
//                       decoration: const InputDecoration(
//                           prefixIcon: Icon(Icons.search_outlined),
//                           filled: true,
//                           fillColor: Palette.white,
//                           hintText: 'Search locations...'),
//                     ),
//                     // Expanded(
//                     //     child: ListView.builder(
//                     //         itemCount: mapCtrl._predictionList.length,
//                     //         itemBuilder: (context, index) {
//                     //           var item = mapCtrl._predictionList[index];
//                     //           return ListTile(
//                     //             onTap: () async {
//                     //               await locationFromAddress(item.description!);
//                     //             },
//                     //             title: Text(item.description!),
//                     //           );
//                     //         })),
//                     PrimaryButton(title: 'Confirm Location', press: () {})
//                   ],
//                 ),
//               ))
//         ]));
//   }
// }

// class MapController extends GetxController {
//   // Services.

//   // Controllers.
//   //contrller for Google map.
//   TextEditingController searchCtrl = TextEditingController();
//   MapboxMapController? mapController;

//   // Observables.
//   // RxBool isSelecting = false.obs;
//   // Rx<LatLng?> pickedLocation = null.obs;
//   // RxString location = "Search Location".obs;
//   // List<Prediction> _predictionList = <Prediction>[].obs;
//   // RxList<PlaceSearchModel> _placeSearchList = <PlaceSearchModel>[].obs;

//   @override
//   void onInit() {
//     searchCtrl.addListener(() {
//       onChange();
//     });
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     searchCtrl.dispose();
//     super.onClose();
//   }

//   _onMapCreated(MapboxMapController controller) async {
//     mapController = controller;
//   }

//   void onChange() async {
//     // _placeSearchList.value =
//     //   await placeSrv.getAutocomplete(searchCtrl.text.trim());
//   }
// }
