import 'dart:developer';
import 'package:flutter/foundation.dart';

void devPrint(Object object) {
  if (!kReleaseMode) {
    log(object.toString());
  }
}
