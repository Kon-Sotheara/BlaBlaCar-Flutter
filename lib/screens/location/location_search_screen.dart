import 'package:flutter/material.dart';
import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/screens/location/widgets/location_tile.dart';

class LocationSearchScreen extends StatefulWidget {
  final List<Location> allLocations;
  final List<Location> history;

  const LocationSearchScreen({
    super.key,
    required this.allLocations,
    required this.history,
  });

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    // Filter locations by search query
    final filtered = widget.allLocations
        .where((loc) => loc.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    // Filter history by search query
    final filteredHistory = widget.history
        .where((loc) => loc.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search location',
            border: InputBorder.none,
          ),
          onChanged: (val) => setState(() => query = val),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          // Show filtered history first
          if (filteredHistory.isNotEmpty)
            ...filteredHistory.map(
              (loc) => LocationTile(
                location: loc,
                type: TileType.history,
                onTap: () {
                  Navigator.pop(context, loc); // Return selection to parent
                },
              ),
            ),

          // Show filtered search results
          if (query.isNotEmpty)
            ...filtered.map(
              (loc) => LocationTile(
                location: loc,
                type: TileType.search,
                onTap: () {
                  Navigator.pop(context, loc); // Return selection to parent
                },
              ),
            ),

          // No results
          if (query.isNotEmpty && filtered.isEmpty && filteredHistory.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'No locations found',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
