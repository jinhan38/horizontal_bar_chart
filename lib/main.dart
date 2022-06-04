import 'package:flutter/material.dart';

import 'barChart/BarChartModel.dart';
import 'barChart/bar_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BarChartModel> data = [];

  @override
  void initState() {
    data.clear();
    for (int i = 0; i < 30; i++) {
      data.add(BarChartModel((60 + i).toDouble(), "날짜 : $i"));
    }
    super.initState();
  }

  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("화면"),
            ElevatedButton(
                onPressed: () {
                  _scrollController.animateTo(300,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear);
                },
                child: Text("이동")),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    data[29].score = data[29].score - 1;
                  });
                },
                child: Text("버튼 데이터 변경")),
            Expanded(
                child: BarChart(
              modelList: data,
              itemWidth: 40,
              initPosition: data.length - 1,
              initPositionScrollAnimation: false,
              controller: (controller) {
                _scrollController = controller;
              },
            )),
          ],
        ),
      ),
    );
  }
}
