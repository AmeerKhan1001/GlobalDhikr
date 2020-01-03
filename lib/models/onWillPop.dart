import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_dhikr_final/screens/onboardingScreen.dart';
import 'dart:io';

Future<bool> onWillPop(BuildContext context,{bool toExit = false}) async {
  return (await showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text('Are you sure?'),
      content: toExit ? Text('Do you want to exit the app ?') : Text('Do you want to go back to intro screens ?'),
      actions: <Widget>[
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: new Text('No'),
        ),
        new FlatButton(
          onPressed: () => toExit ? SystemNavigator.pop() : Navigator.pushReplacementNamed(context, onBoardingScreen.id),
          child: new Text('Yes'),
        ),
      ],
    ),
  )) ?? false;
}