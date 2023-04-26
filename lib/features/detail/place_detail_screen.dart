import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:place_reviewer/domain/entities/place_marker.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PlaceDetailScreen extends StatefulWidget {
  const PlaceDetailScreen({super.key});

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as PlaceMarker;
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Text(
              data.name,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CachedNetworkImage(
                imageUrl: data.image,
                imageBuilder: (context, imageProvider) => Container(
                  width: double.infinity,
                  height: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              TabBar(tabs: [
                Tab(
                  text: 'Thông tin chi tiết',
                ),
                Tab(
                  text: 'Đánh giá',
                )
              ], labelColor: Colors.blue, unselectedLabelColor: Colors.black45, controller: _tabController, indicatorSize: TabBarIndicatorSize.tab),
              Expanded(
                  child: TabBarView(
                children: [Icon(Icons.directions_car), RatingScreen()],
                controller: _tabController,
              ))
            ],
          ),
        ));
  }
}

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  var data = [_ChartData('5', 12), _ChartData('4', 15), _ChartData('3', 30), _ChartData('2', 6.4), _ChartData('1', 14)];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '2.0',
                        style: TextStyle(fontSize: 42, fontWeight: FontWeight.w400),
                      ),
                      RatingBarIndicator(
                        rating: 3,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        itemCount: 5,
                        itemSize: 15.0,
                        unratedColor: Colors.orange.withAlpha(50),
                        direction: Axis.horizontal,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '1.2345.6',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
                Expanded(
                    child: Container(
                      height: 120,
                      child: SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          primaryXAxis: CategoryAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                              axisLine: AxisLine(width: 0),
                              majorTickLines: MajorTickLines(width: 0),
                              minorTicksPerInterval: 0,
                              labelStyle: TextStyle(color: Colors.black)),
                          primaryYAxis: NumericAxis(isVisible: false, axisLine: AxisLine(color: Colors.red)),
                          series: <ChartSeries<_ChartData, String>>[
                            BarSeries<_ChartData, String>(
                                dataSource: data,
                                xValueMapper: (_ChartData data, _) => data.x,
                                yValueMapper: (_ChartData data, _) => data.y,
                                name: 'Gold',
                                width: 0.5,
                                trackBorderColor: Colors.black45,
                                trackBorderWidth: 0,
                                isTrackVisible: true,
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Colors.blue),
                          ]),
                    )),
              ],
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://top5kythu.com/wp-content/uploads/Rose-blackpink-1.png',
                    imageBuilder: (context, imageProvider) => Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text('Rose')
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: 3,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    itemCount: 5,
                    itemSize: 15.0,
                    unratedColor: Colors.orange.withAlpha(50),
                    direction: Axis.horizontal,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('09/11/2022')
                ],
              ),
              Text(
                'This game is excellent when it comes to the bread and butter of video games, the gameplay loop. The mechanics are really fun, and the learning curve is perfect. That being said, the game drops in threr stars for me because of the absolutely incessant ads. There is one ad after EVERY SINGLE FIGHT no exceptions. It makes me actively dread the end of a fight. Ads are often so long that quitting the game and coming back is quicker than sitting through them.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 26,
              ),
            ],
          ),);
        }, childCount: 10))
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
