import 'dart:convert';

import 'package:cleanarchitec/features/chat/data/model/userModel.dart';
import 'package:cleanarchitec/features/chat/presentation/screens/chatDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../../../core/utils/utils.dart';
import '../../../chat/domain/entity/userEntity.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Datum> userList = [];
  List<Marker> filteredMarkers = [];
  String searchOccupation = '';
  bool showDetail = false;
  CameraPosition? initialCameraPosition;
  Datum? user;
  bool loader = false;

  void _onMarkerTapped(Datum tappedUser) {
    if (tappedUser.id == userId) {
      showSnackBar(context: context, content: "This is Me ");
      showDetail = false;
    } else {
      setState(() {
        showDetail = true;
        user = tappedUser;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          loader
              ? const Center(
                  child: Center(
                    child: SpinKitDancingSquare(
                      color: Colors.red,
                    ),
                  ),
                )
              : GoogleMap(
                  mapType: MapType.terrain,
                  initialCameraPosition: initialCameraPosition!,
                  markers: Set<Marker>.from(filteredMarkers),
                ),
          showDetail != false
              ? Visibility(
                  visible: user != null,
                  child: Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Card(
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        child: Stack(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.green,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: ClipOval(
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                              "assets/images/occupation.png",
                                          image: user?.username ?? "",
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.network(
                                                "http://192.168.0.102:3000/${user?.image}",
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            "${user?.username ?? ""}",
                                            style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0,
                                              left: 4,
                                              right: 4,
                                              bottom: 4),
                                          child: Text(
                                            user?.email ?? "",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0,
                                              left: 4,
                                              right: 4,
                                              bottom: 4),
                                          child: Text(
                                            user?.phone ?? "",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 14.0, right: 10),
                                child: Text(
                                  "Dhaka bangladesh",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                height: 17,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        width: double.infinity,
                                        child: Card(
                                          color: Colors.white,
                                          surfaceTintColor: Colors.white,
                                          elevation: 5,
                                          //color: kPrimaryDarkenColor,
                                          margin: EdgeInsets.zero,
                                          child: InkWell(
                                            onTap: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          ChatDetails(
                                                            userModel: user!,
                                                          )));
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "Send Message",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        width: double.infinity,
                                        child: Card(
                                          color: Colors.white,
                                          surfaceTintColor: Colors.white,
                                          elevation: 5,
                                          //color: kPrimaryDarkenColor,
                                          margin: EdgeInsets.zero,
                                          child: InkWell(
                                            onTap: () {
                                              _makePhoneCall(user!.phone!);
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "Call",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  // Icon(
                                                  //   Icons.send_outlined,
                                                  //   color: kPrimaryDarkenColor,
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    showDetail = false;
                                  });
                                },
                                child: const Icon(
                                  Icons.clear,
                                  color: Colors.grey,
                                )),
                          ),
                        ]),
                      )),
                )
              : Container(),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _loadUserData() async {
    var response = await http.get(
        Uri.parse("http://192.168.0.102:3000/api/user/users"),
        headers: {"Authorization": "Bearer $accessToken"});
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      print("Res__${response.body}");
      List<dynamic> userDataList = responseData['data'];
      userList =
          userDataList.map((userData) => Datum.fromJson(userData)).toList();
    }

    // Initialize the markers
    filteredMarkers = userList
        .map((user) => Marker(
              markerId: MarkerId('${user.id}'),
              position: LatLng(user.lattitude!, user.longitude!),
              onTap: () {
                setState(() {
                  _onMarkerTapped(user);
                });
              },
            ))
        .toList();
    setState(() {});
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      loader = true;
    });
    final PermissionStatus permissionStatus =
        await Permission.location.request();
    if (permissionStatus == PermissionStatus.granted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        initialCameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14,
        );
        loader = false;
      });
    } else {
      setState(() {
        initialCameraPosition = const CameraPosition(
          target: LatLng(0.0, 0.0), // Default to center of the world
          zoom: 14,
        );
      });
    }
  }
}
