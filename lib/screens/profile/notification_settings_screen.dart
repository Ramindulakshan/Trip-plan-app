import 'package:flutter/material.dart';

import '../../models/notification_settings.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({required this.settings, super.key});

  final NotificationSettings settings;

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  late NotificationSettings _settings;

  @override
  void initState() {
    super.initState();
    _settings = widget.settings;
  }

  void _save() => Navigator.of(context).pop(_settings);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
          tooltip: 'Cancel',
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
        actions: [TextButton(onPressed: _save, child: const Text('Save'))],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          SwitchListTile(
            key: const Key('tripRemindersSwitch'),
            secondary: const Icon(Icons.event_outlined),
            title: const Text('Trip reminders'),
            subtitle: const Text('Reminders about your upcoming trips'),
            value: _settings.tripReminders,
            onChanged: (value) => setState(
              () => _settings = _settings.copyWith(tripReminders: value),
            ),
          ),
          SwitchListTile(
            key: const Key('groupUpdatesSwitch'),
            secondary: const Icon(Icons.groups_outlined),
            title: const Text('Group updates'),
            subtitle: const Text('Activity and changes in your travel groups'),
            value: _settings.groupUpdates,
            onChanged: (value) => setState(
              () => _settings = _settings.copyWith(groupUpdates: value),
            ),
          ),
          SwitchListTile(
            key: const Key('generalNotificationsSwitch'),
            secondary: const Icon(Icons.notifications_outlined),
            title: const Text('General notifications'),
            subtitle: const Text('News and other Trip Plan updates'),
            value: _settings.generalNotifications,
            onChanged: (value) => setState(
              () => _settings = _settings.copyWith(generalNotifications: value),
            ),
          ),
        ],
      ),
    );
  }
}
