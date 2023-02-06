import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:syren/utils/palette.dart';

class ImageCaptionCard extends StatelessWidget {
  const ImageCaptionCard(
      {super.key,
      required this.imageLocation,
      required this.icon,
      required this.title,
      this.description,
      this.tap});

  final String imageLocation;
  final IconData icon;
  final String title;
  final String? description;
  final VoidCallback? tap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: tap,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              // fit: StackFit.expand,
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(imageLocation,
                      // scale: 0.7,
                      width: double.infinity,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.3)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icon,
                            size: 30,
                            color: Palette.white,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Palette.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          description == null
                              ? const SizedBox()
                              : Text(
                                  description!,
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Palette.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                        ],
                      )),
                ) //
              ],
            )));
  }
}

class MedicationCard extends StatelessWidget {
  const MedicationCard(
      {super.key,
      this.imageLocation,
      this.title,
      this.pills,
      this.time,
      this.daysLeft,
      this.when});
  final String? imageLocation;
  final String? title;
  final String? pills;
  final String? time;
  final String? daysLeft;
  final String? when;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        shadowColor: Palette.secondary,
        color: Palette.white,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(children: [
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(pills!),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(when!)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(time!),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.alarm,
                        size: 15,
                      ),
                      Text('Days left: $daysLeft')
                    ],
                  )
                ],
              )
            ])));
    // return DecoratedBox(
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(15), color: Palette.primary),
    //   child: Padding(padding: const EdgeInsets.symmetric()),
    // );
  }
}

class JumbotronCard extends StatelessWidget {
  JumbotronCard(
      {super.key, required this.image, required this.caption, this.icon});

  final String image;
  final String caption;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withOpacity(0.3)),
              child: Text(
                caption,
                maxLines: 2,
                style: const TextStyle(
                    color: Palette.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            )),
        Positioned(
            right: 20,
            bottom: 20,
            child: Image.asset('assets/images/syren_sm.png'))
      ],
    );
  }
}

class ReminderCard extends StatelessWidget {
  const ReminderCard({super.key, this.title, this.note, this.time});

  final String? title;
  final String? note;
  final String? time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Palette.secondary),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(
                  title!,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Palette.secondary),
                ),
                const Icon(Icons.medication,
                    size: 20, color: Palette.secondary),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              note!,
              style: const TextStyle(fontSize: 12, color: Palette.grey),
            ),
          ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.alarm, size: 20, color: Palette.secondary),
              Text(
                time!,
                style: const TextStyle(fontSize: 12, color: Palette.secondary),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard(
      {super.key,
      this.title,
      this.message,
      this.time,
      this.icon,
      required this.isRead});

  final String? title;
  final String? message;
  final IconData? icon;
  final String? time;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: isRead ? Colors.transparent : Palette.lighterGrey,
              border: Border.all(color: Palette.secondary),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 24, color: Palette.secondary),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title!,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Palette.secondary),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        message!,
                        style:
                            const TextStyle(fontSize: 12, color: Palette.grey),
                      ),
                    ]),
              )
            ],
          ),
        ),
        Text(
          timeago.format(DateTime.parse(time!)),
          style: const TextStyle(fontSize: 12, color: Palette.grey),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

class DrugProductCard extends StatelessWidget {
  const DrugProductCard(
      {super.key,
      this.imageLocation,
      this.name,
      this.description,
      this.prescribedBy,
      this.price,
      this.onTap});
  final String? imageLocation;
  final String? name;
  final String? description;
  final String? prescribedBy;
  final String? price;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Palette.grey),
              borderRadius: BorderRadius.circular(mediumBorderRadius)),
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Row(children: [
            Image.asset(imageLocation!,
                width: Get.width * 0.24,
                height: 90,
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  name!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                description == null
                    ? const SizedBox()
                    : Text(
                        description!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                SizedBox(
                  height: description == null ? 0 : 5,
                ),
                prescribedBy == null
                    ? const SizedBox()
                    : Text('Prescribed By: $prescribedBy'),
                SizedBox(
                  height: prescribedBy == null ? 0 : 5,
                ),
                Text(
                  'Price: \$$price',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Palette.primary),
                )
              ],
            )
          ])),
    );
  }
}
