import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/profile/presentation/widgets/profile_tile_widget.dart';
import 'package:byaz_track/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final divider =
        Theme.of(context).dividerTheme.color ?? colorScheme.outlineVariant;
    return Scaffold(
      backgroundColor: colorScheme.surface,

      body: Padding(
        padding: EdgeInsets.only(top: context.devicePaddingTop),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 24.0,
            ).copyWith(bottom: context.devicePaddingBottom + 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Row(
                  children: [
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 36,
                          backgroundColor: Color(0xFFE2CCB1),
                          child: Icon(
                            Icons.person,
                            size: 48,
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ryan Lama',
                            style: context.textTheme.headlineMedium?.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '9815921293',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'ryanlama@gmail.com',
                            style: context.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),

                // PREFERENCES
                _buildSectionHeader(context, 'PREFERENCES'),
                const SizedBox(height: 16),
                _buildSectionContainer(
                  child: Column(
                    children: [
                      ProfileTileWidget(
                        leadingIcon: Icons.dark_mode,
                        title: 'Theme',
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              Theme.of(context).brightness == Brightness.light
                                  ? 'Light'
                                  : 'Dark',
                              style: context.textTheme.bodyMedium,
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.chevron_right,
                              color: context.textTheme.bodyMedium?.color,
                              size: 20,
                            ),
                          ],
                        ),
                        onTap: () => Get.toNamed(AppRoutes.theme),
                      ),
                      Divider(
                        height: 1,
                        indent: 56,
                        endIndent: 16,
                        color: divider,
                      ),
                      ProfileTileWidget(
                        leadingIcon: Icons.translate,
                        title: 'Language',
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'English',
                              style: context.textTheme.bodyMedium,
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.chevron_right,
                              color: context.textTheme.bodyMedium?.color,
                              size: 20,
                            ),
                          ],
                        ),
                        onTap: () => Get.toNamed(AppRoutes.language),
                      ),
                      Divider(
                        height: 1,
                        indent: 56,
                        endIndent: 16,
                        color: divider,
                      ),
                      ProfileTileWidget(
                        leadingIcon: Icons.percent,
                        title: 'Default Interest Type',
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Simple', style: context.textTheme.bodyMedium),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.chevron_right,
                              color: context.textTheme.bodyMedium?.color,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // CALCULATION DEFAULTS
                _buildSectionHeader(context, 'CALCULATION DEFAULTS'),
                const SizedBox(height: 16),
                _buildSectionContainer(
                  child: Column(
                    children: [
                      ProfileTileWidget(
                        leadingIcon: Icons.trending_up,
                        title: 'Default Rate',
                        trailing: Text(
                          '12% p.a.',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                        indent: 56,
                        endIndent: 16,
                        color: divider,
                      ),
                      ProfileTileWidget(
                        leadingIcon: Icons.history,
                        title: 'Compound Frequency',
                        trailing: Text(
                          'Monthly',
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                      Divider(
                        height: 1,
                        indent: 56,
                        endIndent: 16,
                        color: divider,
                      ),
                      ProfileTileWidget(
                        leadingIcon: Icons.calendar_month,
                        title: 'Nepali Calendar (B.S.)',
                        trailing: SizedBox(
                          height: 24,
                          child: Switch(
                            value: true,
                            onChanged: (val) {},
                            activeColor: Colors.white,
                            activeTrackColor: colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // DATA & SECURITY
                _buildSectionHeader(context, 'DATA & SECURITY'),
                const SizedBox(height: 16),
                _buildSectionContainer(
                  child: Column(
                    children: [
                      ProfileTileWidget(
                        leadingIcon: Icons.cloud_upload_outlined,
                        title: 'Auto Backup',
                        trailing: SizedBox(
                          height: 24,
                          child: Switch(
                            value: true,
                            onChanged: (val) {},
                            activeColor: Colors.white,
                            activeTrackColor: colorScheme.primary,
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                        indent: 56,
                        endIndent: 16,
                        color: divider,
                      ),
                      ProfileTileWidget(
                        leadingIcon: Icons.fingerprint,
                        title: 'Biometric Lock',
                        trailing: SizedBox(
                          height: 24,
                          child: Switch(
                            value: false,
                            onChanged: (val) {},
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: divider,
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                        indent: 56,
                        endIndent: 16,
                        color: divider,
                      ),
                      const ProfileTileWidget(
                        leadingIcon: Icons.download_outlined,
                        title: 'Export Data (Excel/PDF)',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // DANGER ZONE
                _buildSectionHeader(context, 'DANGER ZONE', isDanger: true),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      color: colorScheme.error.withOpacity(0.05),
                      border: Border.all(
                        color: colorScheme.error.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete_outline, color: colorScheme.error),
                        const SizedBox(width: 8),
                        Text(
                          'Reset All Data',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: colorScheme.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 48),

                // FOOTER
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Assets.images.byajKhata.image(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'ByajTracker v2.4.1',
                        style: context.textTheme.labelLarge?.copyWith(
                          color: context.textTheme.bodyMedium?.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title, {
    bool isDanger = false,
  }) {
    return Text(
      title,
      style: context.textTheme.labelLarge?.copyWith(
        color:
            isDanger
                ? Theme.of(context).colorScheme.error
                : Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withOpacity(0.7),
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildSectionContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
        ),
      ),
      child: child,
    );
  }
}
