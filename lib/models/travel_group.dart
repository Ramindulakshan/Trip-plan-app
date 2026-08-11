class TravelGroup {
  const TravelGroup({
    required this.id,
    required this.name,
    this.description = '',
    this.members = const [],
  });

  final String id;
  final String name;
  final String description;
  final List<String> members;
}
