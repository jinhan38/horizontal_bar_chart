class BarChartModel {
  double score;

  String date;

  BarChartModel(this.score, this.date);

  BarChartModel copy() {
    return BarChartModel(score, date);
  }

  @override
  String toString() {
    return "BarChartModel(score : $score, date : $date)";
  }

  @override
  bool operator ==(Object other) {
    if (other is BarChartModel) {
      return score == other.score && date == other.date;
    }
    return false;
  }
}
