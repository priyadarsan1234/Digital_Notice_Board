import 'package:digital_notice_board/Notice.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ImageList(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
          widget.title,
          style: const TextStyle(fontSize: 35),
        )),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.purple, border: Border.all(width: 3)),
                child: const Center(
                    child: Text(
                  'DIGITAL NOTICE BOARD',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                )),
              ),
              Expanded(
                child: Container(
                  // height: 390,
                  color: Colors.white,
                  margin: const EdgeInsets.all(10),
                  child: Center(
                    child: Row(children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: Colors.grey, border: Border.all(width: 3)),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    border: Border.all(width: 3),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(width: 3)),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(width: 3)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.purple, border: Border.all(width: 3)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
