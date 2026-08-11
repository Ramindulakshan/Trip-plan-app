class NotificationSettings {
  const NotificationSettings({
    this.tripReminders = true,
    this.groupUpdates = true,
    this.generalNotifications = true,
  });

  final bool tripReminders;
  final bool groupUpdates;
  final bool generalNotifications;

  NotificationSettings copyWith({
    bool? tripReminders,
    bool? groupUpdates,
    bool? generalNotifications,
  }) {
    return NotificationSettings(
      tripReminders: tripReminders ?? this.tripReminders,
      groupUpdates: groupUpdates ?? this.groupUpdates,
      generalNotifications: generalNotifications ?? this.generalNotifications,
    );
  }
}
