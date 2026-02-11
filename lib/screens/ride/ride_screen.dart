import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/theme/theme.dart';
import 'package:blabla/utils/date_time_util.dart';
import 'package:flutter/material.dart';

class RideScreen extends StatelessWidget {
  final RidePref ridePref;

  const RideScreen({super.key, required this.ridePref});

  String get time => DateTimeUtils.formatTime(ridePref.departureDate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 243, 224, 224),
            margin: EdgeInsets.all(15),

          
            child: ListTile(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text("Ride Detail"),
            ),
          ),

          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 219, 228, 232),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Departure: ${ridePref.departure.name}'),
                  Text('Arrival: ${ridePref.arrival.name}'),
                  Text('Date: $time'),
                  Text('Seats: ${ridePref.requestedSeats}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
