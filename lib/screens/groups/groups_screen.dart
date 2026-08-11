import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/widgets/shared_widgets.dart';
import '../../models/travel_group.dart';
import '../../models/trip.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({
    required this.groups,
    required this.trips,
    required this.onAddGroup,
    super.key,
  });
  final List<TravelGroup> groups;
  final List<Trip> trips;
  final VoidCallback onAddGroup;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 12, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Travel Groups',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                IconButton.filled(
                  onPressed: onAddGroup,
                  icon: const Icon(Icons.group_add_outlined),
                  tooltip: 'Add group',
                ),
              ],
            ),
          ),
          Expanded(
            child: groups.isEmpty
                ? EmptyState(
                    icon: Icons.groups_outlined,
                    title: 'Travel is better together',
                    message:
                        'Create a group for friends or family, then connect it to your trips.',
                    buttonLabel: 'Create a group',
                    onPressed: onAddGroup,
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: groups.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final group = groups[index];
                      final tripCount = trips
                          .where((trip) => trip.groupName == group.name)
                          .length;
                      return Card(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => _showDetails(context, group, tripCount),
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 27,
                                  backgroundColor: Color(0xFFE7EFE5),
                                  child: Icon(
                                    Icons.groups_rounded,
                                    color: AppColors.sage,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        group.name,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${group.members.length} ${group.members.length == 1 ? 'member' : 'members'}  •  $tripCount ${tripCount == 1 ? 'trip' : 'trips'}',
                                        style: const TextStyle(
                                          color: AppColors.muted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.chevron_right_rounded),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showDetails(BuildContext context, TravelGroup group, int tripCount) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              group.name,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
            if (group.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(group.description),
            ],
            const SizedBox(height: 20),
            Text(
              'Members (${group.members.length})',
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            if (group.members.isEmpty)
              const Text(
                'No members added yet.',
                style: TextStyle(color: AppColors.muted),
              ),
            ...group.members.map(
              (member) => ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: const CircleAvatar(child: Icon(Icons.person_outline)),
                title: Text(member),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$tripCount linked ${tripCount == 1 ? 'trip' : 'trips'}',
              style: const TextStyle(color: AppColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}
