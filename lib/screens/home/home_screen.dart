import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/constants.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/screens/home/add_entry.dart';
import 'package:flutter_dtr_app/screens/home/calendar_view.dart';
import 'package:flutter_dtr_app/widgets/data_overview_container.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          children: [
            _overviewDatas(),
            const SizedBox(
              height: 40,
            ),
            const CalendarView(),
          ],
        ),
        Positioned(
            bottom: 40,
            right: 30,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEntry(
                        date: DateTime.now(),
                      ),
                    ));
              },
              child: const Icon(
                Icons.add,
                size: 36,
                color: Colors.white,
              ),
            )),
      ],
    );
  }

  Row _overviewDatas() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: buildDataOverviewContainer(
                icon: SvgPicture.asset(
                  iconCalendar,
                  width: 26,
                  height: 26,
                  colorFilter:
                      ColorFilter.mode(palette['icons']!, BlendMode.srcIn),
                ),
                title: '34',
                subtitle: 'Total Days Worked')),
        const SizedBox(
          width: 20,
        ),
        Expanded(
            child: buildDataOverviewContainer(
                icon: Icon(
                  Icons.schedule,
                  size: 26,
                  color: palette['icons'],
                ),
                title: '400',
                subtitle: 'Total Hours')),
      ],
    );
  }
}
