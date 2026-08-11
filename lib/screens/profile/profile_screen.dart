import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../models/notification_settings.dart';
import '../../models/user_profile.dart';
import 'edit_profile_screen.dart';
import 'notification_settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    required this.tripCount,
    required this.groupCount,
    required this.profile,
    required this.notificationSettings,
    required this.onProfileChanged,
    required this.onNotificationSettingsChanged,
    required this.onLogout,
    super.key,
  });
  final int tripCount;
  final int groupCount;
  final UserProfile profile;
  final NotificationSettings notificationSettings;
  final ValueChanged<UserProfile> onProfileChanged;
  final ValueChanged<NotificationSettings> onNotificationSettingsChanged;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Profile',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 28),
          Align(
            child: CircleAvatar(
              radius: 52,
              backgroundColor: AppColors.sage,
              child: Text(
                profile.avatarInitial,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            profile.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 4),
          Text(
            profile.email,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _Stat(value: '$tripCount', label: 'Trips'),
                  ),
                  const SizedBox(height: 42, child: VerticalDivider()),
                  Expanded(
                    child: _Stat(value: '$groupCount', label: 'Groups'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.edit_outlined),
                  title: const Text('Edit profile'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _editProfile(context),
                ),
                const Divider(height: 1, indent: 56),
                ListTile(
                  leading: const Icon(Icons.notifications_outlined),
                  title: const Text('Notifications'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _editNotificationSettings(context),
                ),
                const Divider(height: 1, indent: 56),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('About Trip Plan'),
                  subtitle: const Text('Version 1.0.0'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () => _confirmLogout(context),
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Log out'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
              minimumSize: const Size.fromHeight(52),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _editProfile(BuildContext context) async {
    final updatedProfile = await Navigator.of(context).push<UserProfile>(
      MaterialPageRoute(builder: (_) => EditProfileScreen(profile: profile)),
    );
    if (updatedProfile == null || !context.mounted) return;

    onProfileChanged(updatedProfile);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );
  }

  Future<void> _editNotificationSettings(BuildContext context) async {
    final updatedSettings = await Navigator.of(context)
        .push<NotificationSettings>(
          MaterialPageRoute(
            builder: (_) =>
                NotificationSettingsScreen(settings: notificationSettings),
          ),
        );
    if (updatedSettings == null || !context.mounted) return;

    onNotificationSettingsChanged(updatedSettings);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notification settings updated')),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text(
          'Your locally created trips and groups will be cleared.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Log out'),
          ),
        ],
      ),
    );
    if (shouldLogout == true) onLogout();
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        value,
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
      ),
      Text(label, style: const TextStyle(color: AppColors.muted)),
    ],
  );
}
