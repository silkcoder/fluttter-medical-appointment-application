import 'package:doctor_appointment/bloc/dashboard/dashboard_bloc.dart';
import 'package:doctor_appointment/presentation/screens/booking_screen.dart';
import 'package:doctor_appointment/presentation/widgets/bottom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController scrollController;

  void onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      context.read<DashboardBloc>().add(DashboardReloadedEvent());
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //new line
      body: SingleChildScrollView(
        controller: scrollController,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //show profile_photo.jpeg here as a circle avatar
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage:
                          const AssetImage('assets/images/profile_photo.jpeg'),
                    ),
                    Icon(Icons.notifications_outlined, size: 30.sp),
                  ],
                ),
                SizedBox(height: 9.h),
                Wrap(
                  children: [
                    Text(
                      'Hello',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      'Hamza !',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for doctors',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Image.asset('assets/images/filter.png'),
                  ],
                ),
                SizedBox(height: 30.h),
                Text(
                  'Services',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 30.h),
                //horizontal list view of services
                SizedBox(
                  height: 100.h,
                  child: BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      if (state is DashboardLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state is DashboardLoaded) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.departments.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(right: 10.w),
                              width: 100.w,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Text(state.departments[index].name),
                              ),
                            );
                          },
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  'Doctors',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 30.h),
                BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    if (state is DashboardLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is DashboardLoaded) {
                      return DoctorWidget(state: state);
                    }

                    return const SizedBox();
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

class DoctorWidget extends StatelessWidget {
  final DashboardLoaded state;

  const DoctorWidget({
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.hasReachedMax
              ? state.doctors.length
              : state.doctors.length + 1,
          itemBuilder: (context, index) {
            if (index >= state.doctors.length) return const BottomLoader();

            return Container(
              margin: EdgeInsets.only(bottom: 20.h),
              height: 110.h,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 6,
                    spreadRadius: 0.0002,
                    offset: Offset(1.0, 1.0),
                  )
                ],
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 30,
                    child: Container(
                      height: 80.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.grey[200],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.asset(
                          'assets/images/doctor2.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Container(
                    height: 80.h,
                    padding: EdgeInsets.only(left: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. ${state.doctors[index].name}',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff1E1F2E),
                          ),
                        ),
                        Text(
                          state.doctors[index].designation,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xff666666),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              size: 15.sp,
                              color: const Color(0xff666666),
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              state.doctors[index].timing,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Fee: ${state.doctors[index].fees}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xff666666),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 20,
                    child: SizedBox(
                      height: 80.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.star,
                                  size: 20.sp, color: const Color(0xffFFD33C)),
                              Text(state.doctors[index].rating.toString()),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              //navigate to booking screen without hideing the bottom navigation bar
                              
                              //go to booking screen
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => const BookingScreen()));

                              Navigator.pushNamed(
                                context,
                                '/doctor',
                                arguments: {'doctor': state.doctors[index]},
                              );
                            },
                            child: Container(
                                color: Colors.black,
                                width: 32.w,
                                height: 32.h,
                                child: Image.asset(
                                    'assets/icons/arrow-right.png')),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
