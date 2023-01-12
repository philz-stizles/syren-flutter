import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syren/models/models.dart';
import 'package:syren/screens/views.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

import 'blood_pressure_controller.dart';

class BloodPressureView extends GetView<BloodPressureController> {
  BloodPressureView({super.key});
  static String routeName = "/blood-pressure";

  final bpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true, title: const Text('Blood Pressure')),
      body: Padding(
          padding: defaultScreenPadding,
          child: GetX<BloodPressureController>(
              init: Get.put<BloodPressureController>(BloodPressureController()),
              builder: (BloodPressureController bpCtrl) {
                return Column(
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                              title: 'Today\'s Result',
                              outlined: controller.page.value != 0,
                              expanded: false,
                              press: () {
                                controller.page.value = 0;
                              }),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: PrimaryButton(
                                title: 'History',
                                outlined: controller.page.value != 1,
                                press: () {
                                  controller.page.value = 1;
                                }))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ...controller.page.value == 0
                        ? buildResults(bpCtrl.bps)
                        : buildHistory(bpCtrl.bps)
                  ],
                );
              })),
    );
  }

  List<Widget> buildHistory(List<BloodPressureModel> bps) {
    return [
      Expanded(
          child: bps.isEmpty
              ? const Center(
                  child: Text('You have no records.'),
                )
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Date'),
                        const Text('Time'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Sys'),
                            Icon(
                              Icons.square,
                              color: Palette.red,
                            )
                          ],
                        ),
                        Row(
                          children: const [
                            Text('Dia'),
                            Icon(
                              Icons.square,
                              color: Palette.primary,
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: bps.length,
                          itemBuilder: (BuildContext context, int index) {
                            // print(bpCtrl.bps[index].id);
                            final bp = bps[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Palette.brown),
                                borderRadius:
                                    BorderRadius.circular(mediumBorderRadius),
                              ),
                              padding: const EdgeInsets.all(15),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(DateFormat('MMM d')
                                        .format(bp.timeStamp.toDate())),
                                    const Icon(Icons.wb_cloudy_outlined),
                                    Text(bp.systolicDisplay),
                                    Text(bp.diastolicDisplay)
                                  ],
                                ),
                                Row(
                                  children: const [],
                                )
                              ]),
                            );
                          }),
                    )
                  ],
                )),
      const SizedBox(
        height: 20,
      ),
      PrimaryButton(
          title: 'Take Blood Pressure',
          press: () {
            Get.toNamed(BloodPressureAddView.routeName);
          })
    ];
  }

  List<Widget> buildResults(List<BloodPressureModel> bps) {
    BloodPressureModel? bp = bps.isNotEmpty ? bps[0] : null;
    BloodPressureModel? previousBp = bps.length > 1 ? bps[1] : null;

    return [
      Expanded(
          child: bps.isEmpty
              ? const Center(
                  child: Text('You have no records.'),
                )
              : SingleChildScrollView(
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: previousBp == null
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Palette.brown),
                              borderRadius:
                                  BorderRadius.circular(mediumBorderRadius),
                            ),
                            padding: const EdgeInsets.all(15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Present Blood Pressure',
                                      style: TextStyle(
                                          fontSize: 12, color: Palette.brown)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text:
                                            '${bp?.systolic}/${bp?.diastolic}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Palette.brown,
                                            fontWeight: FontWeight.bold),
                                        children: const [
                                          TextSpan(
                                            text: 'mmHg',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Palette.brown),
                                          )
                                        ]),
                                  )
                                ]),
                          ),
                          SizedBox(
                            width: previousBp == null ? 0 : 10,
                          ),
                          previousBp == null
                              ? const SizedBox()
                              : Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Palette.brown),
                                    borderRadius: BorderRadius.circular(
                                        mediumBorderRadius),
                                  ),
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Previous Blood Pressure',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Palette.brown)),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text:
                                                  '${previousBp.systolic}/${previousBp.diastolic}',
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Palette.brown,
                                                  fontWeight: FontWeight.bold),
                                              children: const [
                                                TextSpan(
                                                  text: 'mmHg',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Palette.brown),
                                                )
                                              ]),
                                        )
                                      ]),
                                ),
                        ]),
                    const SizedBox(
                      height: 20,
                    ),
                    SfCartesianChart(
                        legend: Legend(
                            isVisible: true,
                            position: LegendPosition.bottom,
                            alignment: ChartAlignment.near,
                            legendItemBuilder: (String name, dynamic series,
                                dynamic point, int index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [Icon(Icons.square)],
                              );
                            }),
                        primaryXAxis: DateTimeAxis(),
                        series: <ChartSeries>[
                          // Renders line chart
                          LineSeries<BloodPressureModel, DateTime>(
                              markerSettings: const MarkerSettings(
                                  isVisible: true,
                                  width: 10,
                                  height: 10,
                                  shape: DataMarkerType.pentagon),
                              dataSource: bps,
                              xValueMapper: (BloodPressureModel sales, _) =>
                                  sales.timeStamp.toDate(),
                              yValueMapper: (BloodPressureModel sales, _) =>
                                  sales.systolic),
                          LineSeries<BloodPressureModel, DateTime>(
                              markerSettings: const MarkerSettings(
                                  isVisible: true,
                                  width: 10,
                                  height: 10,
                                  shape: DataMarkerType.pentagon),
                              dataSource: bps,
                              xValueMapper: (BloodPressureModel sales, _) =>
                                  sales.timeStamp.toDate(),
                              yValueMapper: (BloodPressureModel sales, _) =>
                                  sales.diastolic)
                        ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.square, color: Palette.red),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Systolic Pressure'),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: const [
                            Icon(Icons.square, color: Palette.primary),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Diastolic Pressure')
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Your blood pressure is Normal'),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                          size: 20,
                        )
                      ],
                    )
                  ]),
                )),
      const SizedBox(
        height: 20,
      ),
      PrimaryButton(
          title: 'Blood Pressure Reminder',
          icon: Icons.notifications_outlined,
          press: () {
            // Get.toNamed(BloodPressureAddView.routeName);
          })
    ];
  }
}
