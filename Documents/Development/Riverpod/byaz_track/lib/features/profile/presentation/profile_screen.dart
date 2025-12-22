import 'package:byaz_track/core/constants/app_colors.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/language_screen/presentation/screens/language_screen_screen.dart';
import 'package:byaz_track/features/theme_example/theme_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            // Header with gradient background
            _buildHeader(context),

            // Tabs
            // _buildTabs(),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [_buildBusinessInfoTab(), _buildSettingsTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.blueEnd, // Pink
            AppColors.blueStart, // Deeper pink/magenta
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              // Profile Image
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1600880292203-757bb62b4baf?w=400',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Business Name
              const Text(
                'Parbat Tamang',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // const SizedBox(height: 4),

              // // Location
              // const Text(
              //   'Gold Coast, AUS',
              //   style: TextStyle(color: Colors.white70, fontSize: 14),
              // ),
              const SizedBox(height: 24),

              // Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStat('20', 'Total Payments'),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white30,
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                  ),
                  _buildStat('13', 'Total Receivables'),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  // Widget _buildTabs() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.05),
  //           blurRadius: 4,
  //           offset: const Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: TabBar(
  //       controller: _tabController,
  //       labelColor: const Color(0xFFE91E8C),
  //       unselectedLabelColor: Colors.grey,
  //       indicatorColor: const Color(0xFFE91E8C),
  //       indicatorWeight: 3,
  //       labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  //       tabs: const [Tab(text: 'Business Info'), Tab(text: 'Settings')],
  //     ),
  //   );
  // }

  Widget _buildBusinessInfoTab() {
    return const Center(
      child: Text(
        'Business Info Content',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  Widget _buildSettingsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Account Settings Section
        // const Padding(
        //   padding: EdgeInsets.symmetric(vertical: 8),
        //   child: Text(
        //     'Account Settings',
        //     style: TextStyle(
        //       fontSize: 14,
        //       color: Colors.grey,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        // ),
        _buildMenuItem(
          icon: Icons.color_lens,
          title: 'Appearance',
          onTap: () => Get.to(() => const ThemeScreen()),
        ),
        _buildMenuItem(
          icon: Icons.text_fields_sharp,
          title: 'Language',
          onTap: () => Get.to(() => const LanguageScreen()),
        ),

        _buildMenuItem(
          icon: Icons.lock_outline,
          title: 'Change password',
          onTap: () {},
        ),

        _buildMenuItem(
          icon: Icons.notifications_outlined,
          title: 'Push Notifications',
          onTap: () {},
        ),

        // const SizedBox(height: 24),

        // More Section
        // const Padding(
        //   padding: EdgeInsets.symmetric(vertical: 8),
        //   child: Text(
        //     'More',
        //     style: TextStyle(
        //       fontSize: 14,
        //       color: Colors.grey,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        // ),
        _buildMenuItem(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy policy',
          onTap: () {},
        ),

        _buildMenuItem(
          icon: Icons.description_outlined,
          title: 'Terms and conditions',
          onTap: () {},
        ),

        _buildMenuItem(icon: Icons.help_outline, title: 'FAQ', onTap: () {}),

        _buildMenuItem(
          icon: Icons.support_agent_outlined,
          title: 'Help',
          onTap: () {},
        ),

        // const SizedBox(height: 32),

        // Logout Button
        // _buildActionButton(
        //   title: 'Logout',
        //   color: const Color(0xFFE91E8C),
        //   onTap: () {
        //     // Handle logout
        //   },
        // ),

        // const SizedBox(height: 16),

        // // Delete Account Button
        // _buildActionButton(
        //   title: 'Delete Account',
        //   color: const Color(0xFFE91E8C),
        //   onTap: () {
        //     // Handle delete account
        //   },
        // ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Icon(icon, size: 24, color: Colors.grey[700]),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: context.text.titleLarge?.copyWith(
                    color: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.color?.withValues(alpha: 0.7),
                  ),
                ),
              ),
              Icon(Icons.chevron_right, size: 24, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.centerLeft,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
