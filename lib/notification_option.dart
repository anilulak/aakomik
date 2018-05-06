import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class NotificationOption extends StatefulWidget {
  final Storage storage = new Storage();
  //NotificationOption({Key key, @required this.storage}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new _NotificationOption();
}

class _NotificationOption extends State<NotificationOption> {
  bool isSwitchOn;
  int valueOfNotificationText;  // to set isSwitchOn

  @override
  void initState() {
    super.initState();
    widget.storage.readNotificationChecker().then((int value) async {
      int val = await value;
      setState(() {
        valueOfNotificationText = val;
        if(valueOfNotificationText == 1) {
          isSwitchOn = true;
        }
        else {
          isSwitchOn = false;
        }
      });
    });
  }

  void _changeMyState(bool value) {
    if (value) {
      widget.storage.writeNotificationChecker(1); // It can be used to write sth to notification.txt
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
      // when switch turns from true to false.  // are you sure to close popup will come.
    }
    print("it is: " + value.toString());
    print("isSwitchOn: " + isSwitchOn.toString());
    setState(() {
      isSwitchOn = !isSwitchOn;
      print("isSwitchOn: " + isSwitchOn.toString());
    });
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
                'Seçtiğiniz saatte 2 adet fıkra bildirim kutunuza düşecektir.',
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
    Navigator.of(context).pop(); // it closes alert dialog, after choosing time.
  }
}
// These blocks don't work. Permission denied error.
/*void list(String path) {
  try {
    Directory root = new Directory(path);
    if(root.existsSync()) {
      for(FileSystemEntity f in root.listSync()) {
        print(f.path);
      }
    }
  } catch(e) {
    print(e.toString());
  }
}

bool writeFile(String file, String data, FileMode mode) {
  try {
    File f = new File(file);
    RandomAccessFile rf = f.openSync(mode: mode);
    rf.flushSync();
    rf.closeSync();
    return true;
  } catch(e) {
    print('WRITE:' + e.toString());
    return false;
  }
}

String readFile(String file) {
  try {
    File f = new File(file);
    return f.readAsStringSync();
  } catch(e) {
    print('READ:' + e.toString());
  }
}

Future<Directory> myFunc () async{
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  print(appDocPath);
  return appDocDir;
}*/

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
}


