import 'package:flutter/material.dart';

import 'dialog_btn.dart';
import 'dialog_title.dart';

class ReportDialogContent extends StatefulWidget {
  //
  ReportDialogContent({required this.sendReport});
  final Function sendReport;

  @override
  _ReportDialogContentState createState() => _ReportDialogContentState();
}

class _ReportDialogContentState extends State<ReportDialogContent> {
  //

  late int _selectedRadio;

  @override
  void initState() {
    super.initState();
    _selectedRadio = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DialogTitle(
                text: 'Tell us more!',
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.fromLTRB(30, 10, 20, 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: DialogTitle(
                        text: 'It\'s a spam, fake or a scam',
                      ),
                    ),
                    Radio(
                        value: 1,
                        groupValue: _selectedRadio,
                        onChanged: (val) {
                          setState(() {
                            _selectedRadio = val as int;
                          });
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: DialogTitle(
                        text: 'It\'s inappropriate',
                      ),
                    ),
                    Radio(
                        value: 2,
                        groupValue: _selectedRadio,
                        onChanged: (val) {
                          setState(() {
                            _selectedRadio = val as int;
                          });
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: DialogTitle(
                        text: 'It\'s something else',
                      ),
                    ),
                    Radio(
                        value: 3,
                        groupValue: _selectedRadio,
                        onChanged: (val) {
                          setState(() {
                            _selectedRadio = val as int;
                          });
                        })
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: DialogButton(
                  text: 'Send report',
                  color: Colors.transparent,
                  textColor: _selectedRadio == 0 ? Colors.grey : Colors.red,
                  onPress: _selectedRadio == 0
                      ? null
                      : () {
                          widget.sendReport();
                        },
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
