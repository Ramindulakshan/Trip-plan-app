import 'package:flutter/material.dart';

import '../../models/travel_group.dart';
import '../../models/trip.dart';
import '../auth/login_screen.dart';
import '../groups/add_group_screen.dart';
import '../groups/groups_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../trips/add_trip_screen.dart';
import '../trips/trips_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  final List<Trip> _trips = [];
  final List<TravelGroup> _groups = [];

  Future<void> _addTrip() async {
    final trip = await Navigator.of(context).push<Trip>(
      MaterialPageRoute(builder: (_) => AddTripScreen(groups: _groups)),
    );
    if (trip != null) {
      setState(() => _trips.add(trip));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Trip added successfully')),
        );
      }
    }
  }

  Future<void> _addGroup() async {
    final group = await Navigator.of(context).push<TravelGroup>(
      MaterialPageRoute(builder: (_) => const AddGroupScreen()),
    );
    if (group != null) {
      setState(() => _groups.add(group));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Group added successfully')),
        );
      }
    }
  }

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeScreen(
        trips: _trips,
        groups: _groups,
        onAddTrip: _addTrip,
        onAddGroup: _addGroup,
        onViewTrips: () => setState(() => _selectedIndex = 1),
      ),
      TripsScreen(trips: _trips, onAddTrip: _addTrip),
      GroupsScreen(groups: _groups, trips: _trips, onAddGroup: _addGroup),
      ProfileScreen(
        tripCount: _trips.length,
        groupCount: _groups.length,
        onLogout: _logout,
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.luggage_outlined),
            selectedIcon: Icon(Icons.luggage_rounded),
            label: 'Trips',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups_rounded),
            label: 'Groups',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
