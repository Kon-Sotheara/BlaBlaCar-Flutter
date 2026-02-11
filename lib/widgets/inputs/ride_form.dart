import 'package:blabla/screens/RequestedSeat/requested_seat.dart';
import 'package:blabla/screens/ride/ride_screen.dart';
import 'package:blabla/service/locations_service.dart';
import 'package:blabla/utils/animations_util.dart';
import 'package:flutter/material.dart';
import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/screens/location/location_search_screen.dart';
import 'package:blabla/widgets/inputs/location_picker_field.dart';
import 'package:blabla/widgets/inputs/date_picker_field.dart';
import 'package:blabla/widgets/inputs/passager_count.dart';
import 'package:blabla/widgets/actions/bla_buton.dart';
import 'package:blabla/widgets/display/bla_divider.dart';
import 'package:blabla/theme/theme.dart';

class RideForm extends StatefulWidget {
  const RideForm({super.key, this.initRidePref});

  final RidePref? initRidePref;

  @override
  State<RideForm> createState() => _RideFormState();
}

class _RideFormState extends State<RideForm> {
  Location? departure;
  Location? arrival;
  late DateTime departureDate;
  late int requestedSeats;

  List<Location> searchHistory = [];

  @override
  void initState() {
    super.initState();
    if (widget.initRidePref != null) {
      departure = widget.initRidePref?.departure;
      arrival = widget.initRidePref?.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;

      // Add initial locations to history
      if (departure != null) searchHistory.add(departure!);
      if (arrival != null) searchHistory.add(arrival!);
    } else {
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  void switchLocation() {
    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  void _addToHistory(Location loc) {
    searchHistory.removeWhere(
      (h) =>
          h.name.toLowerCase() == loc.name.toLowerCase() &&
          h.country.name.toLowerCase() == loc.country.name.toLowerCase(),
    );
    searchHistory.insert(0, loc);
    if (searchHistory.length > 10) searchHistory.removeLast();
  }

  Future<void> _selectDeparture() async {
    final Location? result = await Navigator.push(
      context,
      // MaterialPageRoute(
      //   builder: (_) => LocationSearchScreen(
      //     allLocations: LocationsService.availableLocations,
      //     history: searchHistory,
      //   ),
      // ),
      AnimationUtils.createBottomToTopRoute(
        LocationSearchScreen(
          allLocations: LocationsService.availableLocations,
          history: searchHistory,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        departure = result;
        _addToHistory(result);
      });
    }
  }

  Future<void> _selectArrival() async {
    final Location? result = await Navigator.push(
      context,
      // MaterialPageRoute(
      //   builder: (_) => LocationSearchScreen(
      //     allLocations:  LocationsService.availableLocations,
      //     history: searchHistory,
      //   ),
      AnimationUtils.createBottomToTopRoute(
        LocationSearchScreen(
          allLocations: LocationsService.availableLocations,
          history: searchHistory,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        arrival = result;
        _addToHistory(result);
      });
    }
  }

  Future<void> _selectRequestedSeat() async {
    final result = await Navigator.push(
      context,
      AnimationUtils.createBottomToTopRoute(
        RequestedSeat(requestedSeat: requestedSeats),
      ),
    );

    setState(() {
      requestedSeats = result;
    });
  }

  void _onSearch() async {
    // If departure is empty, open departure picker
    if (departure == null) {
      await _selectDeparture();
      return; // stop here until user selects
    }

    // If arrival is empty, open arrival picker
    if (arrival == null) {
      await _selectArrival();
      return; // stop here until user selects
    }

    // All fields are valid, proceed to RideScreen
    final ridePref = RidePref(
      departure: departure!,
      arrival: arrival!,
      departureDate: departureDate,
      requestedSeats: requestedSeats,
    );

    // Add to history
    _addToHistory(departure!);
    _addToHistory(arrival!);

    // Navigate to RideScreen (replace with your actual screen)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RideScreen(ridePref: ridePref)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        height: 261,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: LocationPickerField(
                    label: 'Location from',
                    seletedLocation: departure,
                    onTap: _selectDeparture,
                  ),
                ),
                if (departure != null)
                  IconButton(
                    icon: Icon(Icons.swap_vert, color: BlaColors.primary),
                    onPressed: switchLocation,
                  ),
              ],
            ),
            BlaDivider(),
            LocationPickerField(
              label: 'Going to',
              seletedLocation: arrival,
              onTap: _selectArrival,
            ),
            BlaDivider(),
            DatePickerField(date: departureDate),
            BlaDivider(),
            PassagerCount(
              requestedSeat: requestedSeats,
              onTap: _selectRequestedSeat,
            ),
            SizedBox(
              width: double.infinity,
              child: BlaButton(
                label: 'Search',
                buttonType: ButtonType.primary,
                isFlat: true,
                onTap: _onSearch,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
