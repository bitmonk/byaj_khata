import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

enum InterestChartRange { sixMonths, oneYear }

class InterestGrowthChart extends StatefulWidget {
  const InterestGrowthChart({super.key});

  @override
  State<InterestGrowthChart> createState() => _InterestGrowthChartState();
}

class _InterestGrowthChartState extends State<InterestGrowthChart> {
  bool showAvg = false;
  InterestChartRange selectedRange = InterestChartRange.sixMonths;

  List<FlSpot> get trendSpots {
    if (selectedRange == InterestChartRange.oneYear) {
      return const [
        FlSpot(0, 2.5),
        FlSpot(1, 3.2),
        FlSpot(2, 3.1),
        FlSpot(3, 3.8),
        FlSpot(4, 4.2),
        FlSpot(5, 4.0),
        FlSpot(6, 4.5),
        FlSpot(7, 4.1),
        FlSpot(8, 3.9),
        FlSpot(9, 4.2),
        FlSpot(10, 4.4),
        FlSpot(11, 4.8),
      ];
    }

    return const [
      FlSpot(0, 3),
      FlSpot(2.6, 2),
      FlSpot(4.9, 5),
      FlSpot(6.8, 3.1),
      FlSpot(8, 4),
      FlSpot(9.5, 3),
      FlSpot(11, 4),
    ];
  }

  // List<FlSpot> get averageSpots {
  //   if (selectedRange == InterestChartRange.oneYear) {
  //     return const [
  //       FlSpot(0, 3.8),
  //       FlSpot(1, 3.8),
  //       FlSpot(2, 3.8),
  //       FlSpot(3, 3.8),
  //       FlSpot(4, 3.8),
  //       FlSpot(5, 3.8),
  //       FlSpot(6, 3.8),
  //       FlSpot(7, 3.8),
  //       FlSpot(8, 3.8),
  //       FlSpot(9, 3.8),
  //       FlSpot(10, 3.8),
  //       FlSpot(11, 3.8),
  //     ];
  //   }

  //   return const [
  //     FlSpot(0, 3.44),
  //     FlSpot(2.6, 3.44),
  //     FlSpot(4.9, 3.44),
  //     FlSpot(6.8, 3.44),
  //     FlSpot(8, 3.44),
  //     FlSpot(9.5, 3.44),
  //     FlSpot(11, 3.44),
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    final lineColorStart = isDark ? colorScheme.secondary : colorScheme.primary;
    final lineColorEnd = isDark ? colorScheme.primary : colorScheme.secondary;

    final gridColor = colorScheme.onSurface.withOpacity(0.15);
    final borderColor = colorScheme.onSurface.withOpacity(0.3);
    final titleColor = colorScheme.onSurface.withOpacity(0.7);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.green, width: 1),
      ),
      color: colorScheme.surface,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedRange == InterestChartRange.oneYear
                      ? 'Interest Growth'
                      : 'Interest Growth',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                ),
                ToggleButtons(
                  isSelected: [
                    selectedRange == InterestChartRange.sixMonths,
                    selectedRange == InterestChartRange.oneYear,
                  ],
                  onPressed: (index) {
                    setState(() {
                      selectedRange =
                          index == 0
                              ? InterestChartRange.sixMonths
                              : InterestChartRange.oneYear;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  selectedColor: Theme.of(context).colorScheme.onPrimary,
                  color: Theme.of(context).colorScheme.onSurface,
                  fillColor: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.13),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      child: Text(
                        '6m',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      child: Text(
                        '1y',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                // TextButton(
                //   style: TextButton.styleFrom(
                //     minimumSize: const Size(52, 28),
                //     padding: const EdgeInsets.symmetric(horizontal: 12),
                //     foregroundColor: colorScheme.primary,
                //   ),
                //   onPressed: () => setState(() => showAvg = !showAvg),
                //   child: Text(showAvg ? 'Raw' : 'Avg'),
                // ),
              ],
            ),
            const SizedBox(height: 8),
            AspectRatio(
              aspectRatio: 1.7,
              child: LineChart(
                mainData(
                  theme,
                  colorScheme,
                  lineColorStart,
                  lineColorEnd,
                  gridColor,
                  borderColor,
                  titleColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData mainData(
    ThemeData theme,
    ColorScheme colorScheme,
    Color startColor,
    Color endColor,
    Color gridColor,
    Color borderColor,
    Color titleColor,
  ) {
    final gradientColors = [startColor, endColor];
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: true),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine:
            (value) => FlLine(color: gridColor, strokeWidth: 0.5),
        getDrawingVerticalLine:
            (value) => FlLine(color: gridColor, strokeWidth: 0.5),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            interval: 3,
            getTitlesWidget: (value, meta) {
              return SideTitleWidget(
                axisSide: meta.axisSide,
                child: Text(
                  const {3: 'MAR', 6: 'JUN', 9: 'SEP'}[value.toInt()] ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 8,
                  ),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              final text =
                  const {1: '10k', 3: '30k', 5: '50k'}[value.toInt()] ?? '';
              return Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 8,
                ),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: borderColor),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: trendSpots,
          isCurved: true,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((c) => c.withOpacity(0.25)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // LineChartData avgData(
  //   ThemeData theme,
  //   ColorScheme colorScheme,
  //   Color startColor,
  //   Color endColor,
  //   Color gridColor,
  //   Color borderColor,
  //   Color titleColor,
  // ) {
  //   final avgColor = colorScheme.primary.withOpacity(0.75);

  //   return LineChartData(
  //     lineTouchData: const LineTouchData(enabled: false),
  //     gridData: FlGridData(
  //       show: true,
  //       drawVerticalLine: true,
  //       drawHorizontalLine: true,
  //       horizontalInterval: 1,
  //       verticalInterval: 1,
  //       getDrawingHorizontalLine:
  //           (value) => FlLine(color: gridColor, strokeWidth: 0.5),
  //       getDrawingVerticalLine:
  //           (value) => FlLine(color: gridColor, strokeWidth: 0.5),
  //     ),
  //     titlesData: FlTitlesData(
  //       show: true,
  //       rightTitles: const AxisTitles(
  //         sideTitles: SideTitles(showTitles: false),
  //       ),
  //       topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  //       bottomTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           reservedSize: 28,
  //           interval: 2,
  //           getTitlesWidget: (value, meta) {
  //             return SideTitleWidget(
  //               axisSide: meta.axisSide,
  //               child: Text(
  //                 const {2: 'MAR', 5: 'JUN', 8: 'SEP'}[value.toInt()] ?? '',
  //                 style: theme.textTheme.labelSmall?.copyWith(
  //                   color: titleColor,
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //       leftTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           interval: 1,
  //           reservedSize: 40,
  //           getTitlesWidget: (value, meta) {
  //             final text =
  //                 const {1: '10k', 3: '30k', 5: '50k'}[value.toInt()] ?? '';
  //             return Text(
  //               text,
  //               style: theme.textTheme.labelSmall?.copyWith(color: titleColor),
  //             );
  //           },
  //         ),
  //       ),
  //     ),
  //     borderData: FlBorderData(
  //       show: true,
  //       border: Border.all(color: borderColor),
  //     ),
  //     minX: 0,
  //     maxX: 11,
  //     minY: 0,
  //     maxY: 6,
  //     lineBarsData: [
  //       LineChartBarData(
  //         // spots: averageSpots,
  //         isCurved: true,
  //         color: avgColor,
  //         barWidth: 4,
  //         isStrokeCapRound: true,
  //         dotData: const FlDotData(show: false),
  //         belowBarData: BarAreaData(
  //           show: true,
  //           gradient: LinearGradient(
  //             colors: [avgColor.withOpacity(0.15), avgColor.withOpacity(0.04)],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
