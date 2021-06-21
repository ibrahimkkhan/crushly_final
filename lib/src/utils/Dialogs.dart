import 'dart:ui';

import '../SharedPref/SharedPref.dart';
import '../widgets/dialog_btn.dart';
import '../widgets/dialog_description.dart';
import '../widgets/dialog_title.dart';
import '../widgets/report_dialog.dart';
import '../widgets/round_avatar.dart';
import 'package:flutter/material.dart';

class Dialogs {
  //
  static void showCrushDialog({
    BuildContext? context,
    Function? msgBtnCallback,
    userState,
  }) async {
    final user = await SharedPref.pref.getUser();
    String curUserProfileImageUrl = user.profilePhoto!;
    showDialog(
      context: context!,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
          child: AlertDialog(
            backgroundColor: Colors.grey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            content: Container(
              padding: EdgeInsets.all(0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      iconSize: 20,
                      icon: Icon(Icons.close),
                      color: Colors.black,
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  DialogTitle(
                    text: 'Congratulations',
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RoundAvatar(
                        imageUrl: curUserProfileImageUrl,
                        height: 80.0,
                        width: 80.0,
                      ),
                      SizedBox(width: 30),
                      RoundAvatar(
                        imageUrl: userState.followResponse.profilePhoto,
                        height: 80.0,
                        width: 80.0,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  DialogDescription(
                    text:
                        '${userState.followResponse.otherName} also has a crush on you. You guys are now dating!',
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: DialogButton(
                          text: 'Send her a message!',
                          onPress: () {
                            msgBtnCallback!();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void showReportDialog({
    BuildContext? context,
    Function? sendReport,
  }) async {
    showDialog(
      context: context!,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          backgroundColor: Colors.grey[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          content: ReportDialogContent(sendReport: sendReport!),
        );
      },
    );
  }
}
