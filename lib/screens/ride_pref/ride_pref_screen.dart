import 'package:blabla/widgets/inputs/ride_form.dart';
import 'package:flutter/material.dart';

import '../../model/ride_pref/ride_pref.dart';
import '../../service/ride_prefs_service.dart';
import '../../theme/theme.dart';

import 'widgets/ride_pref_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

///
/// This screen allows user to:
/// - Enter his/her ride preference and launch a search on it
/// - Or select a last entered ride preferences and launch a search on it
///
class RidePrefScreen extends StatefulWidget {
  const RidePrefScreen({super.key});

  @override
  State<RidePrefScreen> createState() => _RidePrefScreenState();
}

class _RidePrefScreenState extends State<RidePrefScreen> {
  void onRidePrefSelected(RidePref ridePref) {
    // 1 - Navigate to the rides screen (with a buttom to top animation)
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1 - Background  Image
        _buildBackground(),

        // 2 - Foreground content
        _buildForeground(),
      ],
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover, // Adjust image fit to cover the container
      ),
    );
  }

  Widget _buildForeground() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16),
          Text(
            "Your pick of rides at low price",
            style: BlaTextStyles.heading.copyWith(color: Colors.white),
          ),
          SizedBox(height: 100),
          RideForm(
            initRidePref: RidePrefService.currentRidePref,
          ),
          SizedBox(height: BlaSpacings.m),

          // 2.2 Optionally display a list of past preferences
          Padding(
            padding: EdgeInsets.symmetric(horizontal: BlaSpacings.s),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: RidePrefService.ridePrefsHistory.length,
              itemBuilder: (ctx, index) {
                final ridePref = RidePrefService.ridePrefsHistory[index];

                return RidePrefHistoryTile(
                  ridePref: ridePref,
                  onTap: () => onRidePrefSelected(ridePref),
                );
              },
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
