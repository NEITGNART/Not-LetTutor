import 'package:beatiful_ui/src/features/tutor/presentation/controller/tutor_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/generate_ratio.dart';
import '../../model/schedule.dart';
import '../../model/schedule_detail.dart';
import '../../service/schedule_functions.dart';

Future showTutorTimePicker(BuildContext context, Schedule schedules) {
  List<ScheduleDetails> scheduleDetails = schedules.scheduleDetails;

  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    isScrollControlled: true,
    builder: (context) {
      return SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    margin: const EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'All time',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, bottom: 10),
                    child: GridView.count(
                      crossAxisCount:
                          generateAsisChildRatio(constraints)[0].toInt(),
                      childAspectRatio:
                          (1 / generateAsisChildRatio(constraints)[1]),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      shrinkWrap: true,
                      children: List.generate(
                        scheduleDetails.length,
                        (index) => ElevatedButton(
                          onPressed: () async {
                            if (!scheduleDetails[index].isBooked &&
                                DateTime.fromMillisecondsSinceEpoch(
                                        scheduleDetails[index]
                                            .startPeriodTimestamp)
                                    .isAfter(DateTime.now())) {
                              try {
                                final BookingResponse res =
                                    await ScheduleFunctions.bookAClass(
                                        scheduleDetails[index].id);
                                if (res.success!) {
                                  scheduleDetails[index].isBooked = true;
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  Get.snackbar(
                                    '${res.message}',
                                    "Check email for more details",
                                    backgroundColor: Colors.green,
                                  );
                                } else {
                                  Get.snackbar(
                                    '${res.message}',
                                    "",
                                    backgroundColor: Colors.red,
                                  );
                                }
                              } catch (e) {
                                Get.snackbar("Error", e.toString(),
                                    backgroundColor: Colors.red);
                                // showTopSnackBar(
                                //   context,
                                //   CustomSnackBar.error(
                                //       message: e.toString()),
                                //   showOutAnimationDuration:
                                //       const Duration(milliseconds: 700),
                                //   displayDuration:
                                //       const Duration(milliseconds: 200),
                                // );
                              }
                            } else {
                              Get.snackbar(
                                'Error'.tr,
                                'This time not avaiable due booked'.tr,
                                backgroundColor: Colors.red,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: scheduleDetails[index].isBooked ||
                                    DateTime.fromMillisecondsSinceEpoch(
                                            scheduleDetails[index]
                                                .startPeriodTimestamp)
                                        .isBefore(DateTime.now())
                                ? Colors.grey.shade200
                                : Colors.blue.shade200,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              side: BorderSide(color: Colors.blue, width: 1),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(top: 13, bottom: 13),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(scheduleDetails[index].startPeriodTimestamp))} - ',
                                  style: const TextStyle(color: Colors.blue),
                                ),
                                Text(
                                  DateFormat('HH:mm').format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          scheduleDetails[index]
                                              .endPeriodTimestamp)),
                                  style: const TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future showTutorDatePicker(BuildContext context, DetailTutorController c) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      ),
    ),
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    builder: (context) {
      return SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.6,
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    margin: const EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Schedule",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    )),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, bottom: 10),
                    child: Obx(() {
                      if (c.schedules.value == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (c.schedulesValue!.isEmpty) {
                        return const Center(
                          child: Text("No schedule"),
                        );
                      }

                      return GridView.count(
                        crossAxisCount:
                            generateAsisChildRatio(constraints)[0].toInt(),
                        childAspectRatio:
                            (1 / generateAsisChildRatio(constraints)[1]),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        shrinkWrap: true,
                        children: List.generate(
                          c.schedulesValue!.length,
                          (index) => ElevatedButton(
                            onPressed: () {
                              showTutorTimePicker(
                                  context, c.schedulesValue![index]);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                side: BorderSide(color: Colors.blue, width: 1),
                              ),
                            ),
                            child: Container(
                              padding:
                                  const EdgeInsets.only(top: 13, bottom: 13),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    DateFormat.MMMEd().format(
                                        DateTime.fromMillisecondsSinceEpoch(c
                                            .schedulesValue![index]
                                            .startTimestamp)),
                                    style: const TextStyle(color: Colors.blue),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
