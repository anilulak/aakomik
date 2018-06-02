import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:aakomik/randomjoke.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/initialization_settings.dart';
import 'package:flutter_local_notifications/notification_details.dart';
import 'package:flutter_local_notifications/platform_specifics/android/initialization_settings_android.dart';
import 'package:flutter_local_notifications/platform_specifics/android/notification_details_android.dart';
import 'package:flutter_local_notifications/platform_specifics/ios/initialization_settings_ios.dart';
import 'package:flutter_local_notifications/platform_specifics/ios/notification_details_ios.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationOption extends StatefulWidget {
  final Storage storage = new Storage();

  @override
  State<StatefulWidget> createState() => new _NotificationOption();
}

class _NotificationOption extends State<NotificationOption> {
  bool isSwitchOn;
  int valueOfNotificationText; // to set isSwitchOn
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();

    // initialise the plugin
    var initializationSettingsAndroid =
        new InitializationSettingsAndroid('mipmap/ic_launcher');
    var initializationSettingsIOS = new InitializationSettingsIOS();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        selectNotification: onSelectNotification);

    widget.storage.readNotificationChecker().then((int value) async {
      int val = await value;
      setState(() {
        valueOfNotificationText = val;
        if (valueOfNotificationText == 1) {
          isSwitchOn = true;
        } else {
          isSwitchOn = false;
        }
      });
    });
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new RandomJoke(),
        ));
  }

  Future _cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  Future _showDailyAtTime() async {
    Storage storage = new Storage();
    String timeString = await storage.readTime();

    int hour = int.parse(timeString.substring(0, timeString.indexOf(':')));
    int minute = int.parse(timeString.substring((timeString.indexOf(':') + 1)));

    var time = new Time(hour, minute, 0);
    var androidPlatformChannelSpecifics = new NotificationDetailsAndroid(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = new NotificationDetailsIOS();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'AA KOMİK Fıkra Bildirim Servisi',
        'Fıkranızı tam da bu saatte mi istemiştiniz? ${_toTwoDigitString(
            time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(
            time.second)}',
        time,
        platformChannelSpecifics);
  }

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }

  void _changeMyState(bool value) async {
    if (value) {
      widget.storage.writeNotificationChecker(
          1); // It can be used to write sth to notification.txt
      widget.storage.readNotificationChecker().then((int value) {
        setState(() {
          valueOfNotificationText = value;
        });
      });
      // when switch turns from false to true.  // time picker, popup will come.
      setAlarmDialog(context);
    } else {
      widget.storage.writeNotificationChecker(0);
      widget.storage.readNotificationChecker().then((int value) {
        setState(() {
          valueOfNotificationText = value;
        });
      });

      _cancelNotification();
      // when switch turns from true to false.  // are you sure to close popup will come.
    }
    print("it is: " + value.toString());
    print("isSwitchOn: " + isSwitchOn.toString());
    setState(() {
      isSwitchOn = !isSwitchOn;
      print("isSwitchOn: " + isSwitchOn.toString());
    });
  }

  Future<Null> setAlarmDialog(BuildContext context) async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: false, // user must tap button!
        child: new AlertDialog(
          title: new Text(
            'Bildirim Saati Ayarlayıcı',
            textAlign: TextAlign.center,
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(
                  'Lütfen bir saat seçiniz.',
                  textAlign: TextAlign.center,
                ),
                new Text(
                  'Seçtiğiniz saatte 1 adet fıkra bildirim kutunuza düşecektir.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new Container(
                child: new FlatButton(
              child: new Text('Saat seç'),
              onPressed: () {
                selectTime(context);
                //Navigator.of(context).pop();
              },
            )),
          ],
        ));
  }

  Future<Null> selectTime(BuildContext context) async {
    TimeOfDay _time = new TimeOfDay.now();

    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _time);

    if (picked != null && picked != _time) {
      _time = picked;
      print('Time selected: ${_time.toString()}');
      Storage storage = new Storage();
      storage.writeTime(_time.hour.toString() + ":" + _time.minute.toString());

      await _showDailyAtTime();

      Navigator
          .of(context)
          .pop(); // it closes alert dialog, after choosing time.
    }
  }

  @override
  Widget build(BuildContext context) {
    print("VALUE: " + valueOfNotificationText.toString());
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text('AA Komik!'),
        ),
        body: new Container(
            child: new NotificationSwitch(
          value: isSwitchOn,
          onValueChanged: _changeMyState,
        )));
  }
}

class NotificationSwitch extends StatelessWidget {
  NotificationSwitch({this.value, this.onValueChanged});

  final bool value;
  final onValueChanged;

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new Center(
            child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              new Text('Bildirim gelsin/gelmesin.'),
              new Switch(
                  value: value,
                  onChanged: (bool value) {
                    onValueChanged(value);
                  })
            ]))
      ],
    )));
  }
}


// class to read/write file.
class Storage {
  Future<String> get _localPathForNotificationChecker async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFileForNotificationChecker async {
    final path = await _localPathForNotificationChecker;

    return new File('$path/notification.txt');
  }

  Future<File> writeNotificationChecker(int notificationChecker) async {
    final file = await _localFileForNotificationChecker;

    // Write the file
    return file.writeAsString('$notificationChecker');
  }

  Future<int> readNotificationChecker() async {
    try {
      final file = await _localFileForNotificationChecker;

      // Read the file
      String contents = await file.readAsString();
      print('Contents:' + contents);
      return int.parse(contents);
    } catch (e) {
      // If we encounter an error, return 0
      return 2;
    }
  }

  Future<String> get _localPathForTime async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFileForTime async {
    final path = await _localPathForTime;

    return new File('$path/time.txt');
  }

  Future<File> writeTime(String time) async {
    final file = await _localFileForTime;

    // Write the file
    return file.writeAsString('$time');
  }

  Future<String> readTime() async {
    try {
      final file = await _localFileForTime;

      // Read the file
      String contents = await file.readAsString();
      print('Contents Time:' + contents);
      return contents;
    } catch (e) {
      // If we encounter an error, return 0
      return "10:00";
    }
  }
}
