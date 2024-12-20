import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scheduled Appointments'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: Column(          
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                   //show card with image
                    return Card(
                      elevation: 0,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.grey, width: 0.3),
                      ),
                      child: ListTile(
                        leading: Image.asset('assets/images/profile_photo.jpeg'),
                        title: const Text('Dr. John Doe'),
                        subtitle: const Text('on 24th May 2021 at 10:00 AM'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}