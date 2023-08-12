import 'package:flutter/material.dart';

import 'event_controller.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  void handelEvents(BuildContext context) async {
    String event = await events();

    print(event);
  }

  void addEvent(BuildContext context) async {
    String eve = await addEvents();

    print(eve);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: const Text('Event Screen'),
      ),
      body: Column(
        children: [
          Container(
              child: TextButton(
            child: Text('Get Events'),
            onPressed: () {
              handelEvents(context);
            },
          )),
          Container(
              child: TextButton(
            child: Text('Add Events'),
            onPressed: () {
              Navigator.pushNamed(context, '/addEvent');
              // addEvent(context);
            },
          )),
        ],
      ),
    );
  }
}
