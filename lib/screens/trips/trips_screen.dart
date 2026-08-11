import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/widgets/shared_widgets.dart';
import '../../models/trip.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({required this.trips, required this.onAddTrip, super.key});

  final List<Trip> trips;
  final VoidCallback onAddTrip;

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
                    'My Trips',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                IconButton.filled(
                  onPressed: onAddTrip,
                  icon: const Icon(Icons.add),
                  tooltip: 'Add trip',
                ),
              ],
            ),
          ),
          Expanded(
            child: trips.isEmpty
                ? EmptyState(
                    icon: Icons.luggage_outlined,
                    title: 'No trips planned',
                    message:
                        'Create a trip and keep your destination, dates, and travel group together.',
                    buttonLabel: 'Add your first trip',
                    onPressed: onAddTrip,
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: trips.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final trip = trips[index];
                      final isPast = trip.endDate.isBefore(DateTime.now());
                      return Card(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => _showDetails(context, trip),
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Row(
                              children: [
                                Container(
                                  width: 54,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1DDD1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Icon(
                                    Icons.flight_rounded,
                                    color: AppColors.terracotta,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        trip.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 17,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        trip.destination,
                                        style: const TextStyle(
                                          color: AppColors.muted,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${formatDate(trip.startDate)} – ${formatDate(trip.endDate)}',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Chip(
                                  label: Text(isPast ? 'Past' : 'Upcoming'),
                                  visualDensity: VisualDensity.compact,
                                ),
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

  void _showDetails(BuildContext context, Trip trip) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              trip.name,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 16),
            _DetailRow(icon: Icons.place_outlined, text: trip.destination),
            _DetailRow(
              icon: Icons.calendar_month_outlined,
              text:
                  '${formatDate(trip.startDate)} – ${formatDate(trip.endDate)}',
            ),
            if (trip.groupName != null)
              _DetailRow(icon: Icons.groups_outlined, text: trip.groupName!),
            if (trip.description.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(trip.description, style: const TextStyle(height: 1.5)),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Icon(icon, size: 20, color: AppColors.terracotta),
        const SizedBox(width: 10),
        Expanded(child: Text(text)),
      ],
    ),
  );
}
