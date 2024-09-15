import 'package:flutter/material.dart';

import '../../res/constant/app_assets.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../utils/general_utils.dart';
import '../../utils/routes/routes.dart';
import '../widget/ui_outlined_button.dart';
import '../widget/ui_text.dart';

const kIconSize = 24.0;
const kBorderRadius = 50.0;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _confirmSignout(BuildContext context) {
    Utils.showPopup(
      context,
      icon: AppAssets.icDown,
      title: 'Đăng xuất',
      message: 'Bạn có chắc chắn muốn đăng xuất tài khoản?',
      action: Row(children: [
        Flexible(
            child: UIOutlineButton(
          title: 'Huỷ',
          onPressed: () => Navigator.of(context).pop(),
        )),
        SizedBox(
          width: DimensManager.dimens.setWidth(16),
        ),
        Flexible(
            child: UIOutlineButton(
          title: 'Đăng xuất',
          backgroundColor: AppColors.primaryColor,
          titleStyle: const TextStyle(color: Colors.white),
          onPressed: () => Routes.goToLoginScreen(context),
        ))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: Column(children: [
          Container(
            decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(kBorderRadius),
                    bottomRight: Radius.circular(kBorderRadius))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SafeArea(
                  bottom: false,
                  child: SizedBox(
                    height: DimensManager.dimens.setHeight(20),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(),
                  _circleAvatar(AppAssets.Edukids),
                  SizedBox(
                    height: DimensManager.dimens.setHeight(16),
                  ),
                  const UIText(
                    'Khách Hàng',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: DimensManager.dimens.setHeight(12),
                  ),
                ],
              )
            ]),
          ),
          Expanded(
              child: Column(
            children: [
              _profileItem(Icons.person_outline_sharp, 'Thông tin tài khoản',
                  onTap: () {}),
              _profileItem(Icons.home_outlined, 'EduKids Việt Nam',
                  onTap: () {}),
              _profileItem(Icons.support_outlined, 'Hỗ trợ', onTap: () {}),
              _profileItem(
                  Icons.info_outline_rounded, 'Chính sách và thông tin',
                  onTap: () {}),
              _profileItem(Icons.logout_outlined, 'Đăng xuất', onTap: () {
                _confirmSignout(context);
              }),
            ],
          ))
        ]),
      ),
    );
  }

  Widget _circleAvatar(String? url) {
    return CircleAvatar(
      radius: DimensManager.dimens.setWidth(kBorderRadius) + 3,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: DimensManager.dimens.setWidth(kBorderRadius),
        backgroundImage: const AssetImage(AppAssets.Edukids),
      ),
    );
  }

  Widget _profileItem(IconData icon, String title, {void Function()? onTap}) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: DimensManager.dimens.setHeight(16),
              horizontal: DimensManager.dimens.setWidth(24)),
          child: Row(
            children: [
              Icon(
                icon,
              ),
              const SizedBox(
                width: kIconSize,
              ),
              UIText(
                title,
                size: DimensManager.dimens.setSp(15),
                color: AppColors.headerTextColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
