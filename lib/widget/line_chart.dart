import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Statistik Pinjaman",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              mainData(),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: FlTitlesData(
        show: true,
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTitlesWidget: (value, meta) {
              const style = TextStyle(
                color: Color(0xFF68707A),
                fontSize: 12,
              );
              switch (value.toInt()) {
                case 0:
                  return const Text('Jan', style: style);
                case 2:
                  return const Text('Mar', style: style);
                case 4:
                  return const Text('Mei', style: style);
                case 6:
                  return const Text('Jul', style: style);
                default:
                  return const Text('');
              }
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(1, 2),
            FlSpot(2, 4),
            FlSpot(3, 3),
            FlSpot(4, 5),
            FlSpot(5, 3),
            FlSpot(6, 4),
          ],
          isCurved: true,
          color: const Color(0xFF4299E1),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: const Color(0xFF4299E1).withOpacity(0.15),
          ),
        ),
      ],
    );
  }
}
