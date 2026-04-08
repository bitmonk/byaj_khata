import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/core/utils/byaj_helper.dart';
import 'package:byaz_track/features/create_loan/data/model/loan_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:nepali_utils/nepali_utils.dart';

class InterestAccumulatedCard extends StatelessWidget {
  final LoanModel loan;
  const InterestAccumulatedCard({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final borderColor =
        isDark ? AppColorsDark.dividerColor : const Color(0xFFC3D0C3);
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

    // Calculate dynamic data
    final startNepali = loan.startDate.toNepaliSafe();
    final endNepali = NepaliDateTime.now();
    final isMonthly = loan.interestType == "0";

    final result = ByajHelper.calculateInterest(
      principal: loan.principalAmount.toDouble(),
      rate: loan.rateValue,
      isMonthly: isMonthly,
      start: startNepali,
      end: endNepali,
    );

    final duration = result.duration;
    // Fractional months for display
    final daysInCurrentMonth = ByajHelper.getDaysInMonth(
      endNepali.year,
      endNepali.month,
    );
    final totalMonthsFractional =
        duration.totalMonths + (duration.days / daysInCurrentMonth);
    final totalMonthsFormatted = totalMonthsFractional.toStringAsFixed(1);

    // Generate spots for the chart
    final List<FlSpot> spots = [];
    final totalMonthsFull = duration.totalMonths;

    for (int i = 0; i <= totalMonthsFull; i++) {
      double monthInterest;
      if (isMonthly) {
        monthInterest = (loan.principalAmount * i * loan.rateValue) / 100;
      } else {
        monthInterest =
            (loan.principalAmount * (i / 12.0) * loan.rateValue) / 100;
      }
      spots.add(FlSpot(i.toDouble(), monthInterest));
    }

    // Add final spot for the current date (fractional interest for a smooth curve)
    if (duration.days > 0) {
      spots.add(FlSpot(totalMonthsFractional, result.interest));
    }

    // If no months have passed yet, ensure we have at least two points to draw a line
    if (spots.length == 1) {
      spots.add(
        FlSpot(totalMonthsFractional > 0 ? totalMonthsFractional : 1.0, 0),
      );
    }

    final maxX = spots.last.x;
    final maxY = spots.last.y == 0 ? 100.0 : spots.last.y * 1.2;

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
                      'रू ${result.interest.toStringAsFixed(0)}',
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
                  '+$totalMonthsFormatted Months',
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
                'Current Status',
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
                      interval: (maxX / 5).clamp(1, double.infinity),
                      getTitlesWidget: (value, meta) {
                        String text;
                        if (value == 0) {
                          text = 'Start';
                        } else if ((value - maxX).abs() < 0.1) {
                          text = 'Now';
                        } else {
                          text = '';
                        }

                        if (text.isEmpty) return const SizedBox.shrink();

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
                maxX: maxX,
                minY: 0,
                maxY: maxY,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    curveSmoothness: 0.35,
                    isStepLineChart: false,
                    color: chartLineColor,
                    barWidth: 3.5,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        // Only show dots at integer months and the final point
                        if (spot.x % 1.0 != 0 && spot.x != maxX) {
                          return FlDotCirclePainter(radius: 0, strokeWidth: 0);
                        }
                        return FlDotCirclePainter(
                          radius: 3,
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
                    getTooltipColor:
                        (spot) =>
                            isDark ? const Color(0xFF2C2C2C) : Colors.white,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          'Month ${spot.x.toStringAsFixed(1)}\nरू ${spot.y.toStringAsFixed(0)}',
                          theme.textTheme.labelSmall!.copyWith(
                            color: textColorPrimary,
                            fontWeight: FontWeight.bold,
                          ),
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
