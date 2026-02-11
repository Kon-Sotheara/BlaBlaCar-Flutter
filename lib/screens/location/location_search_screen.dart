import 'package:blabla/theme/theme.dart';
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
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  void clear() {
    _searchController.clear();
    setState(() {
      query = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter locations by search query
    final filtered = query.isNotEmpty
        ? widget.allLocations
              .where(
                (loc) => loc.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList()
        : [];

    // Filter history by search query
    final filteredHistory = query.isNotEmpty
        ? widget.history
              .where(
                (loc) => loc.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList()
        : [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: BlaColors.neutralLight,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          autofocus: true,
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Station Road or The Bridge Cafe',
            hintStyle: TextStyle(color: BlaColors.textNormal),
            border: InputBorder.none,
            suffixIcon: query.isNotEmpty
                ? IconButton(icon: const Icon(Icons.clear), onPressed: clear)
                : null,
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
