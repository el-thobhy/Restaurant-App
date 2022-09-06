import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/core/common/date_time_helper.dart';
import 'package:restaurant_app/services/background_services.dart';
import 'package:restaurant_app/ui/bloc/schedule/schedule_cubit.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings-page';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Detail'),
          elevation: 10.0,
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.black,
            ),
            SafeArea(
              child: Container(
                color: Colors.black,
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Turn On Notification",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    BlocConsumer<ScheduleCubit, ScheduleState>(
                      listener: (context, state) async {
                        if (state.isScheduled) {
                          await AndroidAlarmManager.periodic(
                            const Duration(hours: 24),
                            1,
                            BackgroundService.callback,
                            startAt: DateTimeHelper.format(),
                            exact: true,
                            wakeup: true,
                          );
                        }
                      },
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Switch.adaptive(
                            value: state.isScheduled,
                            onChanged: (_) {
                              setState(
                                () {
                                  context
                                      .read<ScheduleCubit>()
                                      .toggleSchedule();
                                },
                              );
                            },
                            inactiveTrackColor: Colors.grey,
                            activeTrackColor: Colors.blueAccent,
                            activeColor: Colors.blueAccent,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
