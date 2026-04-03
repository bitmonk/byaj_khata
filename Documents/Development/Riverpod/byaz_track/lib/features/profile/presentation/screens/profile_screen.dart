import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/core/language/language_controller.dart';
import 'package:byaz_track/features/profile/presentation/widgets/profile_tile_widget.dart';
import 'package:byaz_track/features/settings/presentation/controllers/profile_controller.dart';
import 'package:byaz_track/gen/assets.gen.dart';
import 'package:byaz_track/l10n/app_localizations.dart';
import 'package:byaz_track/core/routes/app_routes.dart';
import 'package:byaz_track/features/profile/presentation/widgets/logout_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileController = Get.find<ProfileController>();
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
                            'Parbat Tamang',
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
                                LanguageController.instance.isNepali
                                    ? '9815921293'.toNepali()
                                    : '9815921293',
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
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => Obx(
                                () => LogoutConfirmationDialog(
                                  isLoading:
                                      profileController.logoutState.value ==
                                      TheStates.loading,
                                  onConfirm: () async {
                                    profileController.logout();
                                  },
                                ),
                              ),
                        );
                      },
                      icon: const Icon(Icons.logout),
                    ),
                  ],
                ),
                const SizedBox(height: 48),

                // PREFERENCES
                _buildSectionHeader(
                  context,
                  AppLocalizations.of(context)?.preferences ?? 'PREFERENCES',
                ),
                const SizedBox(height: 16),
                _buildSectionContainer(
                  child: Column(
                    children: [
                      ProfileTileWidget(
                        leadingIcon: Icons.dark_mode,
                        title: AppLocalizations.of(context)?.theme ?? 'Theme',
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              Theme.of(context).brightness == Brightness.light
                                  ? AppLocalizations.of(context)?.light ??
                                      'Light'
                                  : AppLocalizations.of(context)?.dark ??
                                      'Dark',
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
                        title:
                            AppLocalizations.of(context)?.language ??
                            'Language',
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              LanguageController.instance.locale.languageCode ==
                                      'en'
                                  ? 'English'
                                  : 'नेपाली',
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
                        title:
                            AppLocalizations.of(context)?.defaultInterestType ??
                            'Default Interest Type',
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
                        onTap: () => Get.toNamed(AppRoutes.interestType),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // CALCULATION DEFAULTS
                _buildSectionHeader(
                  context,
                  AppLocalizations.of(context)?.calculationDefaults ??
                      'Calculation Defaults',
                ),
                const SizedBox(height: 16),
                _buildSectionContainer(
                  child: Column(
                    children: [
                      ProfileTileWidget(
                        leadingIcon: Icons.trending_up,
                        title:
                            AppLocalizations.of(context)?.defaultRate ??
                            'Default Rate',
                        trailing: Text(
                          '${LanguageController.instance.isNepali ? (12).toNepali() : '12'}% ${AppLocalizations.of(context)?.perAnnum ?? 'p.a.'}',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () => Get.toNamed(AppRoutes.defaultRate),
                      ),

                      Divider(
                        height: 1,
                        indent: 56,
                        endIndent: 16,
                        color: divider,
                      ),
                      ProfileTileWidget(
                        leadingIcon: Icons.history,
                        title:
                            AppLocalizations.of(context)?.compoundFrequency ??
                            'Compound Frequency',
                        trailing: Text(
                          AppLocalizations.of(context)?.monthly ?? 'Monthly',
                          style: context.textTheme.bodyMedium,
                        ),
                        onTap: () => Get.toNamed(AppRoutes.compoundFrequency),
                      ),
                      Divider(
                        height: 1,
                        indent: 56,
                        endIndent: 16,
                        color: divider,
                      ),
                      ProfileTileWidget(
                        leadingIcon: Icons.calendar_month,
                        title:
                            '${AppLocalizations.of(context)?.nepaliCalendar ?? 'Nepali Calendar'} (${AppLocalizations.of(context)?.bS ?? 'B.S.'})',
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
                _buildSectionHeader(
                  context,
                  AppLocalizations.of(context)?.dataAndSecurity ??
                      'Data & Security',
                ),
                const SizedBox(height: 16),
                _buildSectionContainer(
                  child: Column(
                    children: [
                      ProfileTileWidget(
                        leadingIcon: Icons.cloud_upload_outlined,
                        title:
                            AppLocalizations.of(context)?.autoBackup ??
                            'Auto Backup',
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
                        title:
                            AppLocalizations.of(context)?.biometricLock ??
                            'Biometric Lock',
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
                      ProfileTileWidget(
                        leadingIcon: Icons.download_outlined,
                        title:
                            '${AppLocalizations.of(context)?.exportData ?? 'Export Data'} (Excel/PDF)',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // DANGER ZONE
                _buildSectionHeader(
                  context,
                  AppLocalizations.of(context)?.dangerZone ?? 'Danger Zone',
                  isDanger: true,
                ),
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
                          AppLocalizations.of(context)?.resetAllData ??
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
                        'ByajTracker v1.0.0',
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
        letterSpacing: 0,
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
