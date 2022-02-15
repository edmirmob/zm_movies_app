import 'package:flutter/material.dart';

final navigatorStateGlobalKey = GlobalKey<NavigatorState>();
BuildContext getCurrentContext() {
  return navigatorStateGlobalKey.currentContext;
}
