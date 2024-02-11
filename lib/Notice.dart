import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:marquee/marquee.dart';

class ImageList extends StatefulWidget {
  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  List<String> imageStrings = [];
  Timer? timer;
  List<String> upcomingData = [];

  @override
  void initState() {
    super.initState();
    fetchUpcomingData();
    fetchImages();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> fetchUpcomingData() async {
    try {
      var url =
          Uri.parse("https://creativecollege.in/DNB/upcoming_retrive.php");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          upcomingData = List<String>.from(data);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Failed to fetch data');
    }
  }

  Future<void> fetchImages() async {
    var url = Uri.parse("https://creativecollege.in/img_retrive.php");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        try {
          List<dynamic> data = json.decode(response.body);
          setState(() {
            imageStrings = List<String>.from(data.reversed);
          });
        } catch (e) {
          print('Error decoding JSON: $e');
          throw Exception('Failed to load images');
        }
      } else {
        print('HTTP ${response.statusCode} ${response.body}');
        throw Exception('Failed to load images');
      }
    } catch (e) {
      print('Error fetching images: $e');
      throw Exception('Failed to fetch images');
    }
  }

  void startTimer() {
  timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
    if (imageStrings.isNotEmpty) {
      setState(() {
        String firstItem = imageStrings.removeAt(0);
        imageStrings.add(firstItem);
      });
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'CREATIVE TECHNO COLLEGE',
            style: TextStyle(fontSize: 35),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 55,
              decoration: BoxDecoration(
                color: Colors.purple,
                border: Border.all(width: 3),
              ),
              child: const Center(
                child: Text(
                  'DIGITAL NOTICE BOARD',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageStrings.length,
                itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: ScrollController(initialScrollOffset: 0.0),
                    child:  Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.memory(
                        base64Decode(imageStrings[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                  );
                },
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.purple,
                border: Border.all(width: 3),
              ),
              alignment: Alignment.center,
              child: upcomingData.isEmpty
                  ? Text(
                      'Creative Techno College First Professional Degree College In Angul',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Marquee(
                          text: upcomingData.join(", "),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          blankSpace: 20.0,
                          velocity: 50.0,
                          pauseAfterRound: Duration(seconds: 1),
                          startPadding: 10.0,
                          accelerationDuration: Duration(seconds: 1),
                          accelerationCurve: Curves.linear,
                          decelerationDuration: Duration(milliseconds: 500),
                          decelerationCurve: Curves.easeOut,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
  