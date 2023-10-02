import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatefulWidget {
  EventDetails(
      {super.key,
      required this.title,
      required this.description,
      required this.banner_image,
      required this.date_time,
      required this.organiser_name,
      required this.organiser_icon,
      required this.venue_name,
      required this.venue_city,
      required this.venue_country});
  String title,
      description,
      banner_image,
      date_time,
      organiser_name,
      organiser_icon,
      venue_name,
      venue_city,
      venue_country;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  Widget dataTile(icon, title, subtitle) {
    return ListTile(
      leading: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: const Color(0xff5669FF).withOpacity(0.10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: icon),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
        backgroundColor: Colors.transparent,
        title: const Text(
          'Event Details',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.bookmark_rounded,
              color: Colors.white,
            ),
          )
        ],
      ),
      bottomSheet: Container(
          margin:
              const EdgeInsets.only(top: 20, left: 52, right: 52, bottom: 10),
          height: 60,
          decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.white,
                  blurRadius: 35.0,
                  spreadRadius: 50,
                  offset: Offset(0.0, -10))
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff5669FF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16))),
            onPressed: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Text(
                  'BOOK NOW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                )
              ],
            ),
          )),
      resizeToAvoidBottomInset: true,
      body: Builder(builder: (context) {
        DateTime dateTime = DateTime.parse(widget.date_time);
        int year = dateTime.year;
        int month = dateTime.month;
        int day = dateTime.day;
        String time = DateFormat.jm().format(dateTime);
        String monthName = monthNames[month - 1]; // Adjust for 0-based indexing
        String dayName = DateFormat('EEEE').format(dateTime);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.banner_image,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(fontSize: 35),
                    ),
                    dataTile(Image.network(widget.organiser_icon),
                        widget.organiser_name, 'Organizer'),
                    dataTile(
                        const Icon(
                          Icons.calendar_month_rounded,
                          size: 30,
                        ),
                        '$day $monthName, $year',
                        '$dayName, $time'),
                    dataTile(
                        const Icon(
                          Icons.location_on_rounded,
                          size: 30,
                        ),
                        widget.venue_name,
                        '${widget.venue_city}, ${widget.venue_country}'),
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        'About Event',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        widget.description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
