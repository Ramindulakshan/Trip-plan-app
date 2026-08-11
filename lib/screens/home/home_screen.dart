import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/widgets/shared_widgets.dart';
import '../../models/travel_group.dart';
import '../../models/trip.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.trips,
    required this.groups,
    required this.onAddTrip,
    required this.onAddGroup,
    required this.onViewTrips,
    super.key,
  });

  final List<Trip> trips;
  final List<TravelGroup> groups;
  final VoidCallback onAddTrip;
  final VoidCallback onAddGroup;
  final VoidCallback onViewTrips;

  @override
  Widget build(BuildContext context) {
    final upcoming =
        trips.where((trip) => !trip.endDate.isBefore(DateTime.now())).toList()
          ..sort((a, b) => a.startDate.compareTo(b.startDate));
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
            sliver: SliverList.list(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hello, Alex 👋',
                            style: TextStyle(color: AppColors.muted),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Where to next?',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.sage,
                      child: Text(
                        'A',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.brown, Color(0xFF966B5C)],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Make memories together',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              trips.isEmpty
                                  ? 'Start with your first adventure.'
                                  : '${trips.length} ${trips.length == 1 ? 'trip' : 'trips'} ready to explore.',
                              style: const TextStyle(color: Color(0xFFEEDFD9)),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.flight_takeoff_rounded,
                        color: Colors.white,
                        size: 52,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: _SummaryCard(
                        icon: Icons.luggage_rounded,
                        value: '${trips.length}',
                        label: 'Trips',
                        color: AppColors.terracotta,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _SummaryCard(
                        icon: Icons.groups_rounded,
                        value: '${groups.length}',
                        label: 'Groups',
                        color: AppColors.sage,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                Text(
                  'Quick actions',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.add_location_alt_outlined,
                        label: 'Add trip',
                        onTap: onAddTrip,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.group_add_outlined,
                        label: 'Add group',
                        onTap: onAddGroup,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Upcoming trips',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    if (trips.isNotEmpty)
                      TextButton(
                        onPressed: onViewTrips,
                        child: const Text('View all'),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                if (upcoming.isEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(22),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0xFFF1DDD1),
                            child: Icon(
                              Icons.map_outlined,
                              color: AppColors.terracotta,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Text(
                              'No upcoming trips yet. Your next adventure starts here!',
                            ),
                          ),
                          IconButton(
                            onPressed: onAddTrip,
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ...upcoming.take(2).map((trip) => _HomeTripCard(trip: trip)),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: .16),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(label, style: const TextStyle(color: AppColors.muted)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE8DED0)),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.brown, size: 30),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

class _HomeTripCard extends StatelessWidget {
  const _HomeTripCard({required this.trip});
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFE7EFE5),
          child: Icon(Icons.place_outlined, color: AppColors.sage),
        ),
        title: Text(
          trip.name,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        subtitle: Text('${trip.destination}\n${formatDate(trip.startDate)}'),
        isThreeLine: true,
      ),
    );
  }
}
