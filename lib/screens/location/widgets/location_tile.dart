import 'package:blabla/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';
import 'package:blabla/model/ride/locations.dart';

enum TileType { history, search }

class LocationTile extends StatelessWidget {
  final Location location;
  final TileType type;
  final VoidCallback onTap;

  const LocationTile({
    super.key,
    required this.location,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isHistory = type == TileType.history;

    return Column(
      children: [
        ListTile(
          leading: isHistory
              ? const Icon(Icons.history, color: Colors.grey)
              : null,
          title: Text(
            location.name,
            style: TextStyle(
              fontWeight: isHistory ? FontWeight.w500 : FontWeight.bold,
            ),
          ),
          subtitle: Text(location.country.name),
          trailing: isHistory ? null : const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
        BlaDivider()
      ],
    );
  }
}
