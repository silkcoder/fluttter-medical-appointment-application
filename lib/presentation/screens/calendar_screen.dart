import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Calendar',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,                  
                  color: Colors.blue[500],

                ),
              ),
              const SizedBox(height: 40),
              //show a larage tick icon
              Icon(
                Icons.calendar_today,
                size: 120,
                color: Colors.blue[500]
              ),
              const SizedBox(height: 20),
              Text('Your calendar is here',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/welcome');
                },
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}