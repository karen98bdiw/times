import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var year = DateTime.now().year;
  var day = DateTime.now().day;
  var month = DateTime.now().month;
  DateTime today;
  DateTime tommorow;
  DateTime curentWeekStart;
  DateTime
      curentWeekEnd; //will be the firs day of next week ect. next monday 00:00:00

  var times = [
    1617195499013,
    1617195499013,
    1617195899013,
    1617194499013,
    1617194356364,
    1617059876496,
    1615059876496,
    1605059876496,
    1505059876496,
    1618306355764,
    1619898350764
  ];

  List<DateTime> dates = [];

  void toDateTime() {
    dates = []; //line writed for curect debuging...
    for (int i = 0; i < times.length; i++) {
      dates.add(DateTime.fromMillisecondsSinceEpoch(times[i]));
    }
  }

  @override
  void initState() {
    today = DateTime(year, month, day);
    tommorow = today.add(Duration(days: 1));
    for (int i = 0; i < 7; i++) {
      curentWeekStart = today.subtract(Duration(days: i));
      if (curentWeekStart.weekday == DateTime.monday) {
        break;
      }
    }
    for (int i = 0; i < 7; i++) {
      curentWeekEnd = today.add(Duration(days: i));
      if (curentWeekEnd.weekday == DateTime.monday) {
        break;
      }
    }
    print("CURENT WEEK START DAY $curentWeekStart");
    print("CURENT WEEK END DAY $curentWeekEnd");

    print("TODAY:$today");
    print("TOMMOROW:$tommorow");
    toDateTime();
    super.initState();
  }

  dynamic rightFormat(DateTime time) {
    if (time.isAfter(today) && time.isBefore(tommorow) || time == today) {
      return DateFormat("HH:mm").format(time);
    } //check is date today
    if (time == curentWeekStart ||
        time.isAfter(curentWeekStart) && time.isBefore(curentWeekEnd)) {
      return DateFormat("EEEE").format(time).substring(0, 3);
    } //check is date in curent week ect. from monday to next monday

    return DateFormat("MMM-dd").format(time); //pther cases
  }

  @override
  Widget build(BuildContext context) {
    dates.sort((a, b) => a.isAfter(b) ? 1 : -1);
    return Scaffold(
      appBar: AppBar(title: Text("something")),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView.builder(
            itemBuilder: (c, index) => Text(
                dates[index].toString() + ":---" + rightFormat(dates[index])),
            itemCount: dates.length,
          ),
        ),
      ),
    );
  }
}
