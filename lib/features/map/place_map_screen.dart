import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:place_reviewer/navigation_service.dart';
import 'package:place_reviewer/utilities/network_response_result.dart';

import '../../di/injection.dart';
import '../../domain/entities/place_marker.dart';
import '../explore/explore_bloc.dart';

class PlaceMapScreen extends StatefulWidget {
  const PlaceMapScreen({Key? key}) : super(key: key);

  @override
  State<PlaceMapScreen> createState() => PlaceMapState();
}

class PlaceMapState extends State<PlaceMapScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.025489913030068, 105.84649955405581),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799, target: LatLng(37.43296265331129, -122.08832357078792), tilt: 59.440717697143555, zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        BlocProvider(
            create: (_) => getIt<LocationCubit>(),
            child: BlocConsumer<LocationCubit, ResponseResult<LocationData>>(listener: (context, response) async {
              var location = response.onSucceed;
              var currentLocation = CameraPosition(
                target: LatLng(location.latitude ?? 0.0, location.longitude ?? 0.0),
                zoom: 16,
              );
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(currentLocation));
            }, builder: (context, response) {
              return CustomGoogleMapMarkerBuilder(customMarkers: _markers, builder: (context, markers){
                return GoogleMap(
                  mapType: MapType.normal,
                  markers: markers ?? Set(),
                  initialCameraPosition: _kGooglePlex,
                  myLocationEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    context.read<LocationCubit>().getLocation();
                    addMarker('https://statics.vinpearl.com/cau-the-huc%20(10)_1676479397.jpg');
                  },
                );
              });
            }))
      ],
    ));
  }

  List<MarkerData> _markers = <MarkerData>[];

  Future<void> addMarker(String imageUrl) async {
    LatLng _lastMapPositionPoints = LatLng(double.parse("21.03072507794615"), double.parse("105.85282663785777"));
    var newList = <MarkerData>[];
    var places = <PlaceMarker>[];
    places.add(PlaceMarker('Trung tâm hội nghị Quốc Gia', 'https://baan.vn/wp-content/uploads/2019/07/qh3.png',21.00585327075256, 105.78766896939624));
    places.add(PlaceMarker('Nhà tù Hỏa Lò', 'https://ik.imagekit.io/tvlk/blog/2022/11/go-and-share-nha-tu-hoa-lo-1.jpg?tr=dpr-2,w-675',21.025489913030068, 105.84649955405581));
    places.add(PlaceMarker('Bốt Hàng Đậu', 'https://luhanhvietnam.com.vn/du-lich/vnt_upload/news/03_2020/bot-hang-dau-ha-noi-6.jpg',21.04045213750783, 105.84755035220991));
    places.add(PlaceMarker('Cầu Long Biên', 'https://photo-cms-tpo.epicdn.me/w890/Uploaded/2023/lxwptqjwq/2014_02_25/cauLB2_SXNT.jpg',21.041964122150205, 105.8544918675506));
    places.add(PlaceMarker('Chợ Đồng Xuân', 'https://ik.imagekit.io/tvlk/blog/2022/09/cho-dong-xuan-1-1024x654.jpg?tr=dpr-2,w-675',21.038174985703584, 105.84949095405607));
    places.add(PlaceMarker('Cầu Thê Húc', 'https://statics.vinpearl.com/cau-the-huc%20(10)_1676479397.jpg',21.03091706385999, 105.85281486755035));
    places.add(PlaceMarker('Ga Hà Nội', 'https://afamilycdn.com/150157425591193600/2022/8/31/576a0274-2-1661770390854632906539-1661885045498-1661885046178788573544.jpg',21.02450052869168, 105.84108256755032));
    for (var element in places) {
      newList.add(MarkerData(marker: Marker(
        markerId: MarkerId(element.name),
        position: LatLng(element.latitude, element.longtitude),
        infoWindow: InfoWindow(
          title: element.name,
          onTap: (){
            getIt<NavigationService>().navigateToWithArgument('detail', element);
          }
        ),
      ), child: CachedNetworkImage(
        imageUrl: element.image,
        imageBuilder: (context, imageProvider) =>
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 4, color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.red,
                image: DecorationImage(
                    image: imageProvider, fit: BoxFit.cover),
              ),
            ),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      )));
    }
    setState(() {
      // adding a new marker to map
      _markers = newList;
    });
  }
}
