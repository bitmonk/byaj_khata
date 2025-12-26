// features/home/presentation/home.dart
import 'package:byaz_track/core/constants/app_colors.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/dashboard/presentation/widgets/feature_card.dart';
// import 'package:byaz_track/features/dashboard/presentation/widgets/square_feature_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(
          18,
        ).copyWith(top: context.devicePaddingTop + 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Optional: Greeting or Title
            Text(
              'Welcome Back!',
              style: context.text.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.headlineLarge?.color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'What would you like to do today?',
              style: context.text.bodyLarge?.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.bodyLarge?.color?.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),

            // 2x2 Grid of Square Cards
            GridView.count(
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              shrinkWrap:
                  true, // Important: makes GridView scrollable inside SingleChildScrollView
              physics: const BouncingScrollPhysics(),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1.0, // Ensures perfect squares
              children: [
                SquareFeatureCard(
                  title: 'Money Lent',
                  amount: '31231',
                  // icon: Icons.receipt_long_outlined,
                  onTap: () {},
                ),
                SquareFeatureCard(
                  title: 'To Receive',
                  amount: '192631',
                  // icon: Icons.calculate_outlined,
                  onTap: () {},
                ),
                SquareFeatureCard(
                  title: 'Total Borrowed',
                  amount: '65778',
                  // icon: Icons.calculate_outlined,
                  onTap: () {},
                ),
                SquareFeatureCard(
                  title: 'Total Payable',
                  amount: '9892',
                  // icon: Icons.calculate_outlined,
                  onTap: () {},
                ),
              ],
            ),

            // const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
