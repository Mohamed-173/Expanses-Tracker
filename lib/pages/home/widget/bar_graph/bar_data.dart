// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expanses_tracker/pages/home/widget/bar_graph/bar_model.dart';

class BarData {
  final double satAmount;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  BarData({
    required this.satAmount,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
  });

  List<BarModel> barData = [];
  void initializeBarData() {
    barData = [
      BarModel(x: 0, y: satAmount),
      BarModel(x: 1, y: sunAmount),
      BarModel(x: 2, y: monAmount),
      BarModel(x: 3, y: tueAmount),
      BarModel(x: 4, y: wedAmount),
      BarModel(x: 5, y: thuAmount),
      BarModel(x: 6, y: friAmount),
    ];
  }
}
