import 'package:byaz_track/core/extension/extensions.dart';
import 'package:fl_chart/fl_chart.dart';

class InterestAccumulatedCard extends StatelessWidget {
  const InterestAccumulatedCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final borderColor =
        isDark
            ? AppColorsDark.dividerColor
            : const Color(0xFFC3D0C3); // Faint greenish gray
    final textColorPrimary =
        isDark ? AppColorsDark.textPrimary : const Color(0xFF1E1E1E);
    final textColorSecondary =
        isDark ? AppColorsDark.textSecondary : const Color(0xFF5A5A5A);
    final pillBgColor =
        isDark
            ? AppColorsDark.success100.withOpacity(0.1)
            : const Color(0xFFEEF5E5);
    final pillTextColor =
        isDark ? AppColorsDark.success500 : const Color(0xFF0D5C46);
    final chartLineColor =
        isDark ? AppColorsDark.success500 : const Color(0xFF388E3C);
    final chartFillColor =
        isDark
            ? AppColorsDark.success500.withOpacity(0.2)
            : const Color(0xFFB9DDA4).withOpacity(0.5);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(24),
        color: isDark ? theme.colorScheme.surface : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Accumulated Interest',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: textColorSecondary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'रू 1,42,333',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: textColorPrimary,
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: pillBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '+14.2 Months',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: pillTextColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Growth Trend',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: textColorSecondary,
                ),
              ),
              Text(
                'Last 6 Months',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: textColorPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 120,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        String text;
                        switch (value.toInt()) {
                          case 0:
                            text = 'Magh';
                            break;
                          case 1:
                            text = 'Fal';
                            break;
                          case 2:
                            text = 'Cha';
                            break;
                          case 3:
                            text = 'Bai';
                            break;
                          case 4:
                            text = 'Jes';
                            break;
                          case 5:
                            text = 'Asa';
                            break;
                          default:
                            text = '';
                            break;
                        }
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 8,
                          child: Text(
                            text,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: textColorSecondary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 5,
                minY: 0,
                maxY: 6,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 1),
                      FlSpot(1, 1.8),
                      FlSpot(2, 2.6),
                      FlSpot(3, 3.4),
                      FlSpot(4, 4.3),
                      FlSpot(5, 4.8),
                    ],
                    isCurved: false,
                    color: chartLineColor,
                    barWidth: 3.5,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: chartLineColor,
                          strokeWidth: 0,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: chartFillColor,
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((LineBarSpot touchedSpot) {
                        final textStyle = TextStyle(
                          color: isDark ? Colors.white : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        );
                        return LineTooltipItem(
                          touchedSpot.y.toString(),
                          textStyle,
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
