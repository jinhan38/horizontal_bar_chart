import 'package:flutter/material.dart';

import 'BarChartModel.dart';
import 'bar_painter.dart';

typedef WidgetBuilder = Widget Function(BuildContext context, int index);

class BarChart extends StatefulWidget {
  List<BarChartModel> modelList;
  double itemWidth;
  bool initAnimation;
  int initPosition;
  bool initPositionScrollAnimation;
  Duration initPositionScrollDuration;
  Function(ScrollController controller)? controller;

  BarChart({
    required this.modelList,
    required this.itemWidth,
    this.initAnimation = true,
    this.initPosition = 0,
    this.initPositionScrollAnimation = true,
    this.initPositionScrollDuration = const Duration(milliseconds: 300),
    this.controller,
    Key? key,
  }) : super(key: key);

  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart>
    with SingleTickerProviderStateMixin {
  List<BarChartModel> modelOldList = [];

  List<BarChartModel> get modelList => widget.modelList;

  double get itemWidth => widget.itemWidth;

  bool get initAnimation => widget.initAnimation;

  int get initPosition => widget.initPosition;

  bool get initPositionScrollAnimation => widget.initPositionScrollAnimation;

  Duration get initPositionScrollDuration => widget.initPositionScrollDuration;

  Function(ScrollController controller)? get controller => widget.controller;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late ScrollController _scrollController;

  @override
  void initState() {
    for (var m in modelList) {
      modelOldList.add(m.copy());
    }
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _animation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.decelerate))
        .animate(_animationController);
    _animation.addListener(() {
      setState(() {});
    });

    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted && _scrollController.hasClients) {
        if (initPosition > 0) {
          if (initPositionScrollAnimation) {
            _scrollController.animateTo(initPosition * itemWidth,
                duration: initPositionScrollDuration,
                curve: Curves.fastOutSlowIn);
          } else {
            double listViewWidth = ((initPosition + 1) * itemWidth);
            double deviceWidth = MediaQuery.of(context).size.width;
            _scrollController.position.moveTo(listViewWidth - deviceWidth);
          }
        }

        if (initAnimation) {
          _animationController.forward();
        }
        if (controller != null) {
          controller!(_scrollController);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const ClampingScrollPhysics(),
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: modelList.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: itemWidth,
            child: Column(
              children: [
                _header(modelList[index].score),
                const SizedBox(height: 8),
                CustomPaint(
                  painter: BarPainter(
                      (modelList[index].score / 100) * _animation.value,
                      modelOldList[index] == modelList[index]
                          ? Colors.black
                          : Colors.greenAccent),
                  size: const Size(6, 200),
                ),
                const SizedBox(height: 8),
                FittedBox(child: Text(modelList[index].date)),
              ],
            ),
          );
        });
  }

  Widget _header(double score) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue,
      ),
      child: Text(
        score.toString(),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
