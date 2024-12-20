import 'package:doctor_appointment/presentation/screens/booking_screen.dart';
import 'package:doctor_appointment/presentation/screens/calendar_screen.dart';
import 'package:doctor_appointment/presentation/screens/doctor_screen.dart';
import 'package:doctor_appointment/presentation/screens/favorites_screen.dart';
import 'package:doctor_appointment/presentation/screens/home_screen.dart';
import 'package:doctor_appointment/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
 
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = const [
    //HomeScreen(),
    // DoctorScreen(),
    BookingScreen(),
    CalendarScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

        //   body: PageStorage(
        //   bucket: PageStorageBucket(),
        //   child: IndexedStack(
        //     index: _selectedIndex,
        //     children: _pages,
        //   ),
        // ),

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (BuildContext context, child) =>  MaterialApp(
        home: Scaffold(
          body: _pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed, 
            onTap: _onItemTapped,
            showSelectedLabels: false,
            showUnselectedLabels: false,            
            selectedItemColor: Colors.blue,
            iconSize: 28.sp,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),                
                label: 'Home',              
              ),
              //add favorite icon              
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined),
                activeIcon: Icon(Icons.calendar_month),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                activeIcon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
