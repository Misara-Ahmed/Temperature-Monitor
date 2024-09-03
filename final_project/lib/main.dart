import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Monitor',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Temperature Monitor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isOn = false;
  //TextEditingController _temperatureController = TextEditingController();
  String feedbackText = "Feedback";
  String _temperature = "";
  final telephony = Telephony.instance;

  @override
  void initState() {
    super.initState();
    //requestPermissions();
    telephony.listenIncomingSms(
        onNewMessage: onMessage, listenInBackground: false);
  }

  onMessage(SmsMessage message) async {
    setState(() {
      _temperature = message.body ?? "Error reading message body.";
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF062F15),
      body: Column(
        children: [
          Container(
            height: 90,
            margin: const EdgeInsets.only(top: 30.0, right: 10.0, left: 10.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: const Color(0xFF0F4F27),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Temperature Monitor',
                  style: TextStyle(
                    color: Color(0xFFEEDEED),
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(width: 10),
                Image(
                  image: AssetImage('assets/rotation.png'),
                  width: 50.0,
                  height: 50.0,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_isOn) {
                            _isOn = !_isOn;
                            telephony.sendSms(
                              to: "01157127253",
                              message: "@0",
                            );
                          } else {
                            _isOn = !_isOn;
                            telephony.sendSms(
                              to: "01157127253",
                              message: "@1",
                            );
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF062F15),
                      ),
                      child: Text(
                        _isOn ? 'On' : 'Off',
                        style: const TextStyle(
                          color: Color(0xFFEEDEED),
                          fontSize: 25,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isOn) {
                            _isOn = !_isOn;
                            telephony.sendSms(
                              to: "01157127253",
                              message: "@0",
                            );
                          } else {
                            _isOn = !_isOn;
                            telephony.sendSms(
                              to: "01157127253",
                              message: "@1",
                            );
                          }
                        });
                      },
                      child: Image.asset(
                        _isOn ? 'assets/on.png' : 'assets/off.png',
                        width: 50.0,
                        height: 50.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Temperature: ',
                      style: TextStyle(
                        color: Color(0xFFEEDEED),
                        fontSize: 25,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1A60B),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _temperature,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       feedbackText,
                //       style: const TextStyle(
                //         color: Color(0xFFEEDEED),
                //         fontSize: 25,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(
              'assets/grass.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
