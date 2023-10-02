import 'dart:convert';

import 'package:event_app/Data_Models/event_model.dart';
import 'package:event_app/Event_Details/event_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Search_Event/search_event.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static Future<List<EventModel>> getEvents() async {
    var url = Uri.parse(
        "https://sde-007.api.assignment.theinternetfolks.works/v1/event");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body)['content']['data'];
    return body.map((e) => EventModel.fromJson(e)).toList();
  }

  Widget buildEvents(events) {
    return ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          DateTime dateTime = DateTime.parse(event.date_time);
          int month = dateTime.month;
          int day = dateTime.day;
          List<String> monthNames = [
            'Jan',
            'Feb',
            'Mar',
            'Apr',
            'May',
            'Jun',
            'Jul',
            'Aug',
            'Sep',
            'Oct',
            'Nov',
            'Dec'
          ];
          String time = DateFormat.jm().format(dateTime);
          String monthName =
              monthNames[month - 1]; // Adjust for 0-based indexing
          String dayName = DateFormat('EEE').format(dateTime);
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => EventDetails(
                          title: event.title,
                          description: event.description,
                          banner_image: event.banner_image,
                          date_time: event.date_time,
                          organiser_name: event.organiser_name,
                          organiser_icon: event.organiser_icon,
                          venue_name: event.venue_name,
                          venue_city: event.venue_city,
                          venue_country: event.venue_country)));
            },
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              width: MediaQuery.of(context).size.width * 0.90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.13,
                      width: MediaQuery.of(context).size.width * 0.22,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(event.banner_image),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.63,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                '$dayName, $monthName $day',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff5669FF),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: Icon(
                                  Icons.circle,
                                  size: 6,
                                  color: Color(0xff5669FF),
                                ),
                              ),
                              Text(
                                time,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff5669FF),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 10),
                            child: Text(
                              event.title,
                              style: const TextStyle(
                                fontSize: 18,
                                height: 1.2,
                              ),
                            ),
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                child: Icon(
                                  Icons.location_on_rounded,
                                  size: 20,
                                  color: Color(0xffB0B1BC),
                                ),
                              ),
                              Text(
                                event.venue_name,
                                style: const TextStyle(
                                  color: Color(0xff747688),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: Icon(
                                  Icons.circle,
                                  size: 6,
                                  color: Color(0xff747688),
                                ),
                              ),
                              Text(
                                event.venue_city + ', ' + event.venue_country,
                                style: const TextStyle(
                                  color: Color(0xff747688),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const SearchEvent()),
                );
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_rounded)),
        ],
      ),
      body: Center(
        // FutureBuilder
        child: FutureBuilder<List<EventModel>>(
          future: getEvents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // until data is fetched, show loader
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              // once data is fetched, display it on screen (call buildPosts())
              final events = snapshot.data!;
              return buildEvents(events);
            } else {
              // if no data, show simple Text
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }
}
