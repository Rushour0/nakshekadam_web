import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/services/Firebase/firestore/firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ClientCard extends StatefulWidget {
  const ClientCard({Key? key}) : super(key: key);

  @override
  State<ClientCard> createState() => _ClientCardState();
}

List<String> clientType = [
  'Closed Clients',
  'Current Clients',
  'Pending Requests',
];

class _ClientCardState extends State<ClientCard> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      spacing: screenWidth * 0.02,
      children: clientType
          .asMap()
          .keys
          .map(
            (index) => ClientOverviewCard(
                type: clientType[index],
                color: COLOR_THEME['overview${index + 1}']!,
                count: 8,
                imagePath:
                    '$IMAGE_DIRECTORY/${clientType[index].toLowerCase().replaceAll(' ', '_')}.png'),
          )
          .toList(),
    );
  }
}

class ClientOverviewCard extends StatelessWidget {
  const ClientOverviewCard({
    Key? key,
    required this.type,
    required this.color,
    required this.count,
    required this.imagePath,
  }) : super(key: key);

  final String type;
  final String imagePath;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          screenHeight / 50,
        ),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.01,
              vertical: screenHeight * 0.01,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  count.toString(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: screenHeight * 0.045,
                    color: COLOR_THEME['secondary'],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  type,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: screenHeight * 0.0225,
                    color: COLOR_THEME['secondary'],
                    // fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.01,
              vertical: screenHeight * 0.01,
            ),
            child: Image.asset(
              imagePath,
              width: screenWidth * 0.075,
              height: screenHeight * 0.1,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}

class Graph extends StatefulWidget {
  const Graph({
    Key? key,
    this.types,
    this.colors,
  }) : super(key: key);

  final List<String>? types;
  final List<Color>? colors;

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenHeight * 0.05,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          screenHeight / 50,
        ),
        color: COLOR_THEME['graphBg'],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'REQUESTS PER DAY',
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: screenHeight * 0.035,
                color: COLOR_THEME['secondary'],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SfCartesianChart(
            backgroundColor: COLOR_THEME['graph'],

            // Set X axis to DateTime
            primaryXAxis: DateTimeAxis(
              dateFormat: DateFormat.MMMd(),
              intervalType: DateTimeIntervalType.days,
            ),
            primaryYAxis: NumericAxis(),

            // Providing the data source and mapping the data
            series: requestData
                .asMap()
                .keys
                .map<SplineSeries<RequestData, DateTime>>(
                  (index) => SplineSeries<RequestData, DateTime>(
                    animationDuration: 0,
                    dataSource: requestData[index],
                    xValueMapper: (RequestData value, _) => value.date,
                    yValueMapper: (RequestData value, _) => value.requests,
                    color: COLOR_THEME['overview${index + 1}'],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class RequestData {
  RequestData({
    required this.datetime,
    required this.requests,
  });
  final DateTime datetime;

  final int requests;

  DateTime get date => DateTime(
        datetime.year,
        datetime.month,
        datetime.day,
      );
}

List<List<RequestData>> requestData = [
  [
    RequestData(
      datetime: DateTime.now(),
      requests: 5,
    ),
    RequestData(
      datetime: DateTime.now().subtract(Duration(days: 1)),
      requests: 2,
    ),
    RequestData(
      datetime: DateTime.now().subtract(Duration(days: 2)),
      requests: 9,
    ),
    RequestData(
      datetime: DateTime.now().subtract(Duration(days: 3)),
      requests: 1,
    ),
    RequestData(
      datetime: DateTime.now().subtract(Duration(days: 4)),
      requests: 4,
    ),
    RequestData(
      datetime: DateTime.now().subtract(Duration(days: 5)),
      requests: 0,
    ),
    RequestData(
      datetime: DateTime.now().subtract(Duration(days: 6)),
      requests: 5,
    ),
  ],
  [
    RequestData(
      datetime: DateTime.now(),
      requests: 2,
    ),
    RequestData(
      datetime: DateTime.now().subtract(Duration(days: 1)),
      requests: 4,
    ),
    RequestData(
      datetime: DateTime.now().subtract(Duration(days: 2)),
      requests: 1,
    ),
    RequestData(
      datetime: DateTime.now().subtract(Duration(days: 3)),
      requests: 8,
    ),
    RequestData(
      datetime: DateTime.now().subtract(Duration(days: 4)),
      requests: 7,
    ),
    RequestData(
      datetime: DateTime.now().subtract(Duration(days: 5)),
      requests: 10,
    ),
    RequestData(
      datetime: DateTime.now().subtract(Duration(days: 6)),
      requests: 3,
    ),
  ],
  [
    RequestData(
      datetime: DateTime.now(),
      requests: 7,
    ),
    RequestData(
      datetime: DateTime.now().subtract(Duration(days: 1)),
      requests: 11,
    ),
    RequestData(
      datetime: DateTime.now().subtract(Duration(days: 2)),
      requests: 2,
    ),
    RequestData(
      datetime: DateTime.now().subtract(Duration(days: 3)),
      requests: 4,
    ),
    RequestData(
      datetime: DateTime.now().subtract(Duration(days: 4)),
      requests: 5,
    ),
    RequestData(
      datetime: DateTime.now().subtract(Duration(days: 5)),
      requests: 3,
    ),
    RequestData(
      datetime: DateTime.now().subtract(Duration(days: 6)),
      requests: 3,
    ),
  ]
];
