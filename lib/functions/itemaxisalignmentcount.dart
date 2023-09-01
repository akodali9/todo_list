import 'package:flutter/material.dart';

int crossAxisAlignmentCountItem(context) {
  int crossAxisCount_ = 0;
  final double screenWidthsize = MediaQuery.of(context).size.width;
  if (screenWidthsize >= 1440) {
    crossAxisCount_ = 5;
  } else if (screenWidthsize >= 1280) {
    crossAxisCount_ = 4;
  } else if (screenWidthsize >= 720) {
    crossAxisCount_ = 4;
  } else if (screenWidthsize >= 350) {
    crossAxisCount_ = 2;
  } else if (screenWidthsize >= 280) {
    crossAxisCount_ = 2;
  } else {
    crossAxisCount_ = 1;
  }

  return crossAxisCount_;
}
