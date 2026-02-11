import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/theme/theme.dart';
import 'package:blabla/widgets/actions/bla_buton.dart';
import 'package:blabla/widgets/display/bla_divider.dart';
import 'package:blabla/widgets/inputs/date_picker_field.dart';
import 'package:blabla/widgets/inputs/location_picker_field.dart';
import 'package:blabla/widgets/inputs/passager_count.dart';
import 'package:flutter/material.dart';

class RideForm extends StatefulWidget {
  RideForm({
    super.key,
    this.departure,
    this.arrival,
    DateTime? date,
    int? requestedSeat,
  }) : date = date ?? DateTime.now(),
       requestedSeat = requestedSeat ?? 1;

  final Location? departure;
  final Location? arrival;
  final DateTime date;
  final int requestedSeat;

  @override
  State<RideForm> createState() => _RideFormState();
}

class _RideFormState extends State<RideForm> {
  late Location? departure;
  late Location? arrival;
  late DateTime departureDate;
  late int requestedSeats;

  @override
  void initState() {
    super.initState();
    departure = widget.departure;
    arrival = widget.arrival;
    departureDate = widget.date;
    requestedSeats = widget.requestedSeat;
  }

  void switchLocation() {
    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  // testing switch location
  // void fakeSelectDeparture() {
  //   setState(() {
  //     departure = Location(name: "Paris", country: Country.france); // fake location
  //   });
  // }

  // void fakeSelectArrival() {
  //   setState(() {
  //     arrival = Location(name: "Lyon", country: Country.france); // fake location
  //   });
  // }

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
                    label: 'location from',
                    seletedLocation: departure,
                    onTap: () {},
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
              onTap: () {},
            ),
            BlaDivider(),
            DatePickerField(date: DateTime.now()),
            BlaDivider(),
            PassagerCount(requestedSeat: 2),
            SizedBox(
              width: double.infinity,
              child: BlaButton(
                label: 'Search',
                buttonType: ButtonType.primary,
                isFlat: true,
                onTap: () {
                  // Implement search logic
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
