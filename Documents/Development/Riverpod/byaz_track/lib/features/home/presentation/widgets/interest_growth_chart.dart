import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:byaz_track/features/home/presentation/controllers/home_controller.dart';
import 'package:intl/intl.dart';

enum InterestChartRange { sixMonths, oneYear }

class InterestGrowthChart extends StatefulWidget {
  const InterestGrowthChart({super.key});

  @override
  State<InterestGrowthChart> createState() => _InterestGrowthChartState();
}

class _InterestGrowthChartState extends State<InterestGrowthChart> {
  InterestChartRange selectedRange = InterestChartRange.sixMonths;
  final controller = Get.find<HomeController>();

  List<String> _getMonthLabels(int count) {
    final now = DateTime.now();
    final List<String> labels = [];
    for (int i = count - 1; i >= 0; i--) {
      // Calculate date for i months ago
      final date = DateTime(now.year, now.month - i, 1);
      labels.add(DateFormat('MMM').format(date).toUpperCase());
    }
    return labels;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    final lineColorStart = isDark ? colorScheme.secondary : colorScheme.primary;
    final lineColorEnd = isDark ? colorScheme.primary : colorScheme.secondary;

    final gridColor = colorScheme.onSurface.withOpacity(0.15);
    final borderColor = colorScheme.onSurface.withOpacity(0.3);

    return Obx(() {
      final stats = controller.stats.value;
      final spots =
          selectedRange == InterestChartRange.sixMonths
              ? stats.chartSpots6m
              : stats.chartSpots1y;

      final monthCount = selectedRange == InterestChartRange.sixMonths ? 6 : 12;
      final labels = _getMonthLabels(monthCount);

      // Find Max Y for scaling
      double maxY = 1000; // Default min height
      if (spots.isNotEmpty) {
        final maxSpotY = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);
        if (maxSpotY > 0) {
          maxY = (maxSpotY * 1.3).ceilToDouble(); // Add 30% headroom
          if (maxY < 100) maxY = 100; // Minimum scale for small amounts
        }
      }

      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: colorScheme.primary.withOpacity(0.5),
            width: 1,
          ),
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
                    'Interest Growth',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
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
                    selectedColor: theme.colorScheme.onPrimary,
                    color: theme.colorScheme.onSurface,
                    fillColor: theme.colorScheme.primary,
                    constraints: const BoxConstraints(
                      minHeight: 32,
                      minWidth: 48,
                    ),
                    children: [
                      Text(
                        '6M',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '1Y',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AspectRatio(
                aspectRatio: 1.7,
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(
                      enabled: true,
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((spot) {
                            return LineTooltipItem(
                              '${labels[spot.x.toInt()]}\nरू ${spot.y.toStringAsFixed(0)}',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      drawHorizontalLine: true,
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
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          interval:
                              selectedRange == InterestChartRange.oneYear
                                  ? 2
                                  : 1,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index < 0 || index >= labels.length) {
                              return const SizedBox();
                            }
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(
                                labels[index],
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 8,
                                  color: colorScheme.onSurface.withOpacity(0.7),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            if (value == 0) return const SizedBox();
                            String text = '';
                            if (value >= 100000) {
                              text = '${(value / 100000).toStringAsFixed(1)}L';
                            } else if (value >= 1000) {
                              text = '${(value / 1000).toStringAsFixed(0)}K';
                            } else {
                              text = value.toStringAsFixed(0);
                            }
                            return Text(
                              text,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                color: colorScheme.onSurface.withOpacity(0.7),
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
                    maxX: (monthCount - 1).toDouble(),
                    minY: 0,
                    maxY: maxY,
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        gradient: LinearGradient(
                          colors: [lineColorStart, lineColorEnd],
                        ),
                        barWidth: 4,
                        isStrokeCapRound: true,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              lineColorStart.withOpacity(0.2),
                              lineColorEnd.withOpacity(0.1),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
