import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/theme/theme.dart';
import 'package:blabla/widgets/actions/bla_buton.dart';
import 'package:flutter/material.dart';

class RequestedSeat extends StatefulWidget {
  const RequestedSeat({super.key, required this.requestedSeat});
  final int requestedSeat;

  @override
  State<RequestedSeat> createState() => _RequestedSeatState();
}

class _RequestedSeatState extends State<RequestedSeat> {
  late int requestedSeat;

  @override
  void initState() {
    super.initState();
    requestedSeat = widget.requestedSeat;
  }

  Color get removeColor =>
      requestedSeat > 1 ? BlaColors.primary : BlaColors.greyLight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.clear, size: 25, color: BlaColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(15),
            child: Text(
              'Number of seats to book',
              style: BlaTextStyles.heading.copyWith(
                color: BlaColors.neutralDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.remove_circle_outline_outlined,
                  size: 50,
                  color: removeColor,
                ),
                onPressed: () {
                  if (requestedSeat > 1) {
                    setState(() {
                      requestedSeat--;
                    });
                  }
                },
              ),
              Text(requestedSeat.toString(), style: BlaTextStyles.heading),
              IconButton(
                icon: Icon(
                  Icons.add_circle_outline_outlined,
                  size: 50,
                  color: BlaColors.primary,
                ),
                onPressed: () {
                  setState(() {
                    requestedSeat++;
                  });
                },
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: Center(
              child: BlaButton(
                label: 'Confirm',
                onTap: () {
                  Navigator.pop(context, requestedSeat);
                },
                buttonType: ButtonType.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
