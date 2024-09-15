import 'package:Edukids/res/style/app_colors.dart';
import 'package:Edukids/view/widget/ui_text.dart';
import 'package:flutter/material.dart';

import '../../utils/dimens/dimens_manager.dart';

class UiLocationCard extends StatelessWidget {
  const UiLocationCard({
    super.key,
    required this.title,
    required this.address,
    required this.phone,
    required this.time,
  });

  final String title;
  final String address;
  final String phone;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: DimensManager.dimens.setHeight(228),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.location_on_rounded,
                color: AppColors.primaryColor,
              ),
              const SizedBox(
                width: 20,
              ),
              UIText(
                title,
                fontWeight: FontWeight.bold,
                size: 20,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.home,
                      color: AppColors.yellowColor,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    UIText(
                      address,
                      maxLines: 2,
                      fontWeight: FontWeight.w300,
                      size: 14,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: AppColors.yellowColor,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    UIText(
                      phone, // Use phone here
                      fontWeight: FontWeight.w300,
                      size: 14,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: AppColors.yellowColor,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    UIText(
                      time, // Use time here
                      fontWeight: FontWeight.w300,
                      size: 14,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
