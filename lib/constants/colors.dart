
import 'package:flutter/material.dart';

const primaryColor = Color(0xffED7402);


const primaryTextColor = Color(0xff000000);
const secondaryTextColor = Color(0xff7B7B7B);
const secondaryDarkTextColor = Color(0xff555555);


const borderColor = Color(0xffE9E9E9);



const red = Color(0xffFF2B18);
const white = Color(0xffFFFFFF);








final Map<int, Color> _yellow700Map = {
  50:  primaryColor.withOpacity(0.1),
  100:  primaryColor.withOpacity(0.2),
  200:  primaryColor.withOpacity(0.3),
  300:  primaryColor.withOpacity(0.4),
  400:  primaryColor.withOpacity(0.5),
  500:  primaryColor.withOpacity(0.6),
  600:  primaryColor.withOpacity(0.7),
  700:  primaryColor.withOpacity(0.8),
  800:  primaryColor.withOpacity(0.9),
  900:  primaryColor.withOpacity(0.10),
};

final MaterialColor primarySwatch =
MaterialColor( primaryColor.value, _yellow700Map);