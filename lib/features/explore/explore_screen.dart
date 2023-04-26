import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:place_reviewer/navigation_service.dart';
import 'package:place_reviewer/utilities/network_response_result.dart';

import '../../di/injection.dart';
import '../../domain/entities/place_marker.dart';
import 'explore_bloc.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenScreenState();
}

class _ExploreScreenScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              elevation: 5,
              child: Container(
                height: 36,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                        child: Text(
                      'Place reviewer',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )),
                    SizedBox(
                      width: 32,
                      child: Icon(
                        Icons.search,
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(
                      width: 32,
                      child: Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.black45,
                      ),
                    ),
                    GestureDetector(
                      child: CachedNetworkImage(
                        imageUrl: 'https://35express.org/wp-content/uploads/2021/02/tieu-su-cua-lisa-blackpink-35express.jpg',
                        imageBuilder: (context, imageProvider) => Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      onTap: () {
                        getIt<NavigationService>().navigateTo('personal');
                      },
                    )
                  ],
                ),
              ),
            ),
            BlocProvider(
                create: (_) => getIt<LocationCubit>()..getLocation(),
                child: BlocBuilder<LocationCubit, ResponseResult<LocationData>>(builder: (context, response) {
                  debugPrint("LOCATIONN $response");
                  return Expanded(
                    child: Container(
                      color: Colors.black12,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, position) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            child: InkWell(
                              onTap: () => getIt<NavigationService>().navigateToWithArgument(
                                  'detail',
                                  PlaceMarker('Trung tâm hội nghị Quốc Gia', 'https://baan.vn/wp-content/uploads/2019/07/qh3.png', 21.00585327075256,
                                      105.78766896939624)),
                              child: ItemPlace(),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }))
          ],
        ),
      ),
    );
  }
}

class ItemPlace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: 'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2022/9/6/1089755/Photo-1636025852946-.jpg',
                imageBuilder: (context, imageProvider) => Container(
                  width: 48.0,
                  height: 48.0,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'Jennie',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      '2 hours ago',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('Hồ Tây', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, bottom: 8, right: 16),
            child: Text(
              'Hồ Tây (với các tên gọi khác trong lịch sử như Đầm Xác Cáo, Hồ Kim Ngưu, Lãng Bạc, Dâm Đàm, Đoài Hồ) là hồ tự nhiên lớn nhất thành phố Hà Nội, hiện thuộc địa phận quận Tây Hồ. Đây là một hồ móng ngựa và là vết tích của dòng chảy cũ của sông Hồng. Hồ có diện tích hơn 500 ha với chu vi là khoảng 14,8 km.[2]',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          CachedNetworkImage(
            imageUrl: 'https://vivuhotay.com/wp-content/uploads/2021/03/duong-Trich-Sai-Meat-Plus-Ho-Tay.jpg',
            imageBuilder: (context, imageProvider) => Container(
              width: double.infinity,
              height: 160.0,
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Icon(Icons.remove_red_eye),
                    SizedBox(
                      width: 4,
                    ),
                    Text('100')
                  ],
                ),
              )),
              Container(
                height: 32,
                margin: EdgeInsets.only(right: 16),
                child: Center(
                  child: Text('100 bình luận'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
