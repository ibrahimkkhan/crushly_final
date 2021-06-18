import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget toast(size, iconName, text, isError, onTap) => GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.93,
        height: size.height / 16.24,
        decoration: BoxDecoration(
            color: isError ? Color(0xFFEB5757) : Color(0xFF6FCF97),
            borderRadius: BorderRadius.circular(size.height / 40.6)),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width / 18.75, right: size.width / 12.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                      color: Colors.white, fontSize: size.height / 45),
                ),
                SvgPicture.asset(
                  iconName,
                  height: size.height / 33.83,
                )
              ],
            ),
          ),
        ),
      ),
    );
