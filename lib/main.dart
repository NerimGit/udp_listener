// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:udp/udp.dart';
import 'package:number_system/number_system.dart';
import 'dart:async';
import 'helperClasses.dart';
// a3035588300219034f424305312e302e350f50495320746f75636873637265656e0550495353570e5469636b6574207072696e74657204322e30310c415043206361722041204431000c415043206361722041204432000c415043206361722043204433000c415043206361722043204434000c415043206361722042204435000c415043206361722042204436001256616c696461746f722063617220412044310d56616c696461746f72443153571256616c696461746f722063617220412044320d56616c696461746f72443253571256616c696461746f722063617220432044330d56616c696461746f72443353571256616c696461746f722063617220432044340d56616c696461746f72443453571256616c696461746f722063617220422044350d56616c696461746f72443553571256616c696461746f722063617220422044360d56616c696461746f724436535712496e7465726e616c204c43442063617220410012496e7465726e616c204c43442063617220420012496e7465726e616c204c43442063617220430012496e7465726e616c204c45442063617220410012496e7465726e616c204c45442063617220420012496e7465726e616c204c45442063617220430018496e7465726e616c204c45442066726f6e742063617220410017496e7465726e616c204c454420736964652063617220410017496e7465726e616c204c454420726561722063617220420017496e7465726e616c204c454420736964652063617220420000000000/* ReceiverID*/
// a303558830021903 4f4 24305312e302e350f50495320746f75636873637265656e0550495353570e5469636b6574207072696e74657204322e30310

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UDP listener',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'UDP listener'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late UDP udp;
  var portNumber = 3600;
  A2Frame a2FrameDetails = A2Frame();
  A3Frame a3FrameDetails = A3Frame();
  bool listeningToPort = true;

  bool showA1 = true;
  bool showA2 = true;
  bool showA3 = true;

  bool showA2T1 = true;
  bool showA2T2 = true;
  bool showA2T3 = true;
  bool showA2T4 = true;
  bool showA2T5 = true;

  bool showA3T1 = true;
  bool showA3T2 = true;

  bool generateA2FrameDetails = true;
  bool generateA3FrameDetails = true;

  /*double latitudeToNormalize = 43.82989204611934;
  double longitudeToNormalize = 18.308218931755135;*/

  String longitudeToNormalizeOutput = 'null';
  String latitudeToNormalizeOutput = 'null';

  @override
  void initState() {
    super.initState();
    startUDPListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        checkBoxToggler('A1 -', showA1, () => showA1=!showA1),
                        checkBoxToggler('A2 -', showA2, () => showA2=!showA2),
                        checkBoxToggler('A3 -', showA3, () => showA3=!showA3),
                      ],
                    ),
                    showA2 ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            checkBoxToggler('T 1 -', showA2T1, () => showA2T1=!showA2T1),
                            showA2T1 ? Table(
                              border: TableBorder.all(color: Colors.black12),
                              columnWidths: const {
                                0: FixedColumnWidth(250.0),
                                1: FixedColumnWidth(100.0),
                              },
                              children: [
                                getDetailsWithDescription("Frame ID", a2FrameDetails.frameID),
                                getDetailsWithDescription("Protocol V", a2FrameDetails.protocolV),
                                getDetailsWithDescription("Sender ID", a2FrameDetails.senderID),
                                getDetailsWithDescription("Receiver ID", a2FrameDetails.receiverID),
                                getDetailsWithDescription("Payload Length", a2FrameDetails.payloadLength),
                                getDetailsWithDescription("Panic Button Status", a2FrameDetails.panicButtonStatus),
                                getDetailsWithDescription("WF Lubrication Request", a2FrameDetails.wfLubricationRequest),
                                getDetailsWithDescription("OBC Status", a2FrameDetails.obcStatus),
                                getDetailsWithDescription("PIS Touch Screen Status", a2FrameDetails.pisTouchscreenStatus),
                                getDetailsWithDescription("GPS Connection Status", a2FrameDetails.gpsConnectionStatus),
                                getDetailsWithDescription("WIFI Connection Status", a2FrameDetails.wiFiConnectionStatus),
                                getDetailsWithDescription("GSM 4G Connection Status", a2FrameDetails.gsm4GConnectionStatus),
                                getDetailsWithDescription("Access Level To Pis Touchscreen", a2FrameDetails.accessLevelToPisTouchscreen),
                                getDetailsWithDescription("USB Data Transfer", a2FrameDetails.usbDataTransfer),
                              ],
                            ) : Table(),
                            const SizedBox(height: 20),
                            checkBoxToggler("Validator's and printer table -", showA2T2, () => showA2T2=!showA2T2),
                            showA2T2 ?
                            Table(
                              border: TableBorder.all(color: Colors.black12),
                              columnWidths: const {
                                0: FixedColumnWidth(250.0),
                                1: FixedColumnWidth(100.0),
                              },
                              children: [
                                getDetailsWithDescription( "Printer Status", a2FrameDetails.printerStatus),
                                getDetailsWithDescription( "Validator 1 Status", a2FrameDetails.validator1Status),
                                getDetailsWithDescription( "Validator 2 Status", a2FrameDetails.validator2Status),
                                getDetailsWithDescription( "Validator 3 Status", a2FrameDetails.validator3Status),
                                getDetailsWithDescription( "Validator 4 Status", a2FrameDetails.validator4Status),
                                getDetailsWithDescription( "Validator 5 Status", a2FrameDetails.validator5Status),
                                getDetailsWithDescription( "Validator 6 Status", a2FrameDetails.validator6Status),
                              ],
                            ) : Table(),
                          ],
                        ),
                        const SizedBox(width: 50),
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            checkBoxToggler("APC's table -", showA2T3, () => showA2T3=!showA2T3),
                            showA2T3 ?
                            Table(
                              border: TableBorder.all(color: Colors.black12),
                              columnWidths: const {
                                0: FixedColumnWidth(250.0),
                                1: FixedColumnWidth(100.0),
                              },
                              children: [
                                getDetailsWithDescription( "Apc 1 Status", a2FrameDetails.apc1Status),
                                getDetailsWithDescription( "Apc 2 Status", a2FrameDetails.apc2Status),
                                getDetailsWithDescription( "Apc 3 Status", a2FrameDetails.apc3Status),
                                getDetailsWithDescription( "Apc 4 Status", a2FrameDetails.apc4Status),
                                getDetailsWithDescription( "Apc 5 Status", a2FrameDetails.apc5Status),
                                getDetailsWithDescription( "Apc 6 Status", a2FrameDetails.apc6Status),
                              ],
                            ) : Table(),
                            const SizedBox(height: 20),
                            checkBoxToggler("T 4 -", showA2T4, () => showA2T4=!showA2T4),
                            showA2T4 ?
                            Table(
                              border: TableBorder.all(color: Colors.black12),
                              columnWidths: const {
                                0: FixedColumnWidth(250.0),
                                1: FixedColumnWidth(100.0),
                              },
                              children: [
                                getDetailsWithDescription( "OBC Mcs Communication Status", a2FrameDetails.obcMcsCommunicationStatus),
                                getDetailsWithDescription( "Audio DataSync", a2FrameDetails.audioDataSync),
                                getDetailsWithDescription( "Audio Announcement Status", a2FrameDetails.audioAnnouncementStatus),
                                getDetailsWithDescription( "Obc MemorySpace", a2FrameDetails.obcMemorySpace),
                                getDetailsWithDescription( "Vehicle ID", a2FrameDetails.vehicleID),
                                getDetailsWithDescription( "Driver Number", a2FrameDetails.driverNumber),
                                getDetailsWithDescription( "Line Number", a2FrameDetails.lineNumber),
                                getDetailsWithDescription( "Vehicle Latitude Gps", a2FrameDetails.vehicleLatitudeGps),
                                getDetailsWithDescription( "Vehicle Longitude Gps", a2FrameDetails.vehicleLongitudeGps),
                                getDetailsWithDescription( "LifeCounter from OBC", a2FrameDetails.lifeCounterFromObcA2),
                              ],
                            ) : Table(),
                            const SizedBox(height: 50),
                           ],
                        ),
                        const SizedBox(width: 50),
                        Column(
                          children: [
                            checkBoxToggler("Display's table -", showA2T5, () => showA2T5=!showA2T5),
                            showA2T5 ?
                            Table(
                              border: TableBorder.all(color: Colors.black12),
                              columnWidths: const {
                                0: FixedColumnWidth(250.0),
                                1: FixedColumnWidth(100.0),
                              },
                              children: [
                                getDetailsWithDescription( "Front Ext Led Display Status", a2FrameDetails.frontExtLedDisplayStatus),
                                getDetailsWithDescription( "Side A Ext Led Display Status", a2FrameDetails.sideAExtLedDisplayStatus),
                                getDetailsWithDescription( "Side B Ext Led Display Status", a2FrameDetails.sideBExtLedDisplayStatus),
                                getDetailsWithDescription( "Rear Ext Led Display Status", a2FrameDetails.rearExtLedDisplayStatus),
                                getDetailsWithDescription( "Int A Led Display Status", a2FrameDetails.intALedDisplayStatus),
                                getDetailsWithDescription( "Int B Led Display Status", a2FrameDetails.intBLedDisplayStatus),
                                getDetailsWithDescription( "Int C Led Display Status", a2FrameDetails.intCLedDisplayStatus),
                                getDetailsWithDescription( "Int A Lcd Display Status", a2FrameDetails.intALcdDisplayStatus),
                                getDetailsWithDescription( "Int B Lcd Display Status", a2FrameDetails.intBLcdDisplayStatus),
                                getDetailsWithDescription( "Int C Lcd Display Status", a2FrameDetails.intCLcdDisplayStatus),
                              ],
                            ) : Table(),
                          ],
                        )
                      ],
                    ) : const Row(),

                    showA3 ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            checkBoxToggler('A3 T1 -', showA3T1, () => showA3T1=!showA3T1),
                            showA3T1 ? Table(
                              border: TableBorder.all(color: Colors.black12),
                              columnWidths: const {
                                0: FixedColumnWidth(250.0),
                                1: FixedColumnWidth(150.0),
                              },
                              children: [
                                getDetailsWithDescription("Frame ID", a3FrameDetails.frameID),
                                getDetailsWithDescription("Protocol V", a3FrameDetails.protocolV),
                                getDetailsWithDescription("Sender ID", a3FrameDetails.senderID),
                                getDetailsWithDescription("Receiver ID", a3FrameDetails.receiverID),
                                getDetailsWithDescription("Payload Length", a3FrameDetails.payloadLength),
                                getDetailsWithDescription("Number Of SoftVer", a3FrameDetails.numberOfSoftVer),
                                getDetailsWithDescription("LifeCounter from OBC", a3FrameDetails.lifeCounterFromObcA3)
                              ],
                            ) : Table(),
                            const SizedBox(height: 20,),
                            checkBoxToggler("Device's table -", showA3T2, () => showA3T2=!showA3T2),
                            showA3T2 ? Table(
                              border: TableBorder.all(color: Colors.black12),
                              columnWidths: const {
                                0: FixedColumnWidth(250.0),
                                1: FixedColumnWidth(150.0),
                              },
                              children: [
                                getDeviceNameAndSWasRow(a3FrameDetails.dev01),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev02),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev03),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev04),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev05),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev06),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev07),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev08),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev09),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev10),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev11),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev12),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev13),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev14),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev15),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev16),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev17),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev18),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev19),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev20),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev21),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev22),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev23),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev24),
                                getDeviceNameAndSWasRow(a3FrameDetails.dev25),
                              ],
                            ) : Table(),
                          ],
                        ),
                      ],
                    ) : const Row(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('Listen to port $portNumber'),
                                Checkbox(value: listeningToPort, onChanged: (value) {
                                  setState(() {
                                    listeningToPort = !listeningToPort;
                                  });
                                },),
                                SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: TextField(
                                    onSubmitted: (value) {
                                      setState(() {
                                        portNumber = int.parse(value);
                                        resetUdpListener();
                                      });
                                    },
                                    onChanged: (value) {

                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Change port number',
                                    ),
                                  ),
                                ),
                                ElevatedButton(onPressed: () {
                                  setState(() {
                                    clearDisplayedData();
                                  });
                                }, child: const Text('Clear all'))
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 250,
                                  height: 50,
                                  child: TextField(
                                    onSubmitted: (value) {
                                      setState(() {
                                        var tmpNormalized = normalizePosition(double.parse(value));
                                        longitudeToNormalizeOutput = get4BytesFromIntegerHEX(tmpNormalized).toString();
                                      });
                                    },
                                    onChanged: (value) {

                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Convert Longitude to 4B HEX ',
                                    ),
                                  ),
                                ),
                                SelectableText(longitudeToNormalizeOutput,
                                  style: const TextStyle(fontSize: 30),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 250,
                                  height: 50,
                                  child: TextField(
                                    onSubmitted: (value) {
                                      setState(() {
                                        var tmpNormalized = normalizePosition(double.parse(value));
                                        latitudeToNormalizeOutput = get4BytesFromIntegerHEX(tmpNormalized).toString();
                                      });
                                    },
                                    onChanged: (value) {

                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Convert Latitude to 4B HEX ',
                                    ),
                                  ),
                                ),
                                SelectableText(
                                  latitudeToNormalizeOutput,
                                  style: const TextStyle(fontSize: 30),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),])
      ),
    );
  }

  Future<void> startUDPListener() async {
    udp = await UDP.bind(Endpoint.unicast(InternetAddress('127.0.0.1'), port: Port(portNumber)));

    print('started listening ${('127.0.0.1')} | port: $portNumber ');
    udp.asStream().listen((Datagram? datagram) async {
      if(!listeningToPort) return;
      Datagram? d = datagram;
      if (d == null) return;

      String message = String.fromCharCodes(d.data).toString();

      var tempReceiverID = (message[6] + message[7]).hexToDEC();

      if(tempReceiverID != 136) return;
      var frameId =  (message[0] + message[1]);

      if(frameId == "a2")
        {
          generateA2FrameDetails = true;
          generateA3FrameDetails = false;
        }
      if(frameId == "a3")
      {
        generateA2FrameDetails = false;
        generateA3FrameDetails = true;
      }

      setState(() {
        if(generateA2FrameDetails) {
          generateA2Details(message);
        }

        if(generateA3FrameDetails)
        {
          generateA3Details(message);
        }
      }
      );
    });
  }

  List<int> get2BytesFromInteger(int number) {
    List<int> byteList = [(number >> 8) & 0xFF, number & 0xFF];
    List<int> result = byteList.reversed.toList();
    return result;
  }
  List<int> get4BytesFromInteger(int number) {
    List<int> byteList = [(number >> 24) & 0xFF, (number >> 16) & 0xFF, (number >> 8) & 0xFF, number & 0xFF];
    List<int> result = byteList.reversed.toList();
    return result;
  }
  List<String> get4BytesFromIntegerHEX(int number) {
    List<int> byteList = [(number >> 24) & 0xFF, (number >> 16) & 0xFF, (number >> 8) & 0xFF, number & 0xFF];
    List<int> resultReversed = byteList.reversed.toList();
    List<String> result = [resultReversed[0].decToHex(), resultReversed[1].decToHex(), resultReversed[2].decToHex(), resultReversed[3].decToHex()];
    return result;
  }
  int getIntegerFrom2Bytes(String a, String b){
    int number = 0;
    number = a.hexToDEC() + (b.hexToDEC() << 8);
    return number;
  }
  int getIntegerFrom4Bytes(String a, String b, String c, String d){
    return (a.hexToDEC() + (b.hexToDEC() << 8) + (c.hexToDEC() << 16) + (d.hexToDEC() << 24));
  }
  normalizePosition(double position) {
    return (position * 1000000).round();
  }
  void generateA2Details(String message) {
    a2FrameDetails.frameID = (message[0] + message[1]).hexToDEC();
    a2FrameDetails.protocolV = (message[2] + message[3]).hexToDEC();
    a2FrameDetails.senderID = (message[4] + message[5]).hexToDEC();
    a2FrameDetails.receiverID = (message[6] + message[7]).hexToDEC();
    a2FrameDetails.payloadLength = (message[8] + message[9]).hexToDEC();
    a2FrameDetails.panicButtonStatus = (message[10] + message[11]).hexToDEC();
    a2FrameDetails.wfLubricationRequest = (message[12] + message[13]).hexToDEC();
    a2FrameDetails.obcStatus = (message[14] + message[15]).hexToDEC();
    a2FrameDetails.pisTouchscreenStatus = (message[16] + message[17]).hexToDEC();
    a2FrameDetails.gpsConnectionStatus = (message[18] + message[19]).hexToDEC();
    a2FrameDetails.wiFiConnectionStatus = (message[20] + message[21]).hexToDEC();
    a2FrameDetails.gsm4GConnectionStatus = (message[22] + message[23]).hexToDEC();
    a2FrameDetails.accessLevelToPisTouchscreen = (message[24] + message[25]).hexToDEC();
    a2FrameDetails.usbDataTransfer = (message[26] + message[27]).hexToDEC();
    a2FrameDetails.frontExtLedDisplayStatus = (message[28] + message[29]).hexToDEC();
    a2FrameDetails.sideAExtLedDisplayStatus = (message[30] + message[31]).hexToDEC();
    a2FrameDetails.sideBExtLedDisplayStatus = (message[32] + message[33]).hexToDEC();
    a2FrameDetails.rearExtLedDisplayStatus = (message[34] + message[35]).hexToDEC();
    a2FrameDetails.intALedDisplayStatus = (message[36] + message[37]).hexToDEC();
    a2FrameDetails.intCLedDisplayStatus = (message[38] + message[39]).hexToDEC();
    a2FrameDetails.intBLedDisplayStatus = (message[40] + message[41]).hexToDEC();
    a2FrameDetails.intALcdDisplayStatus = (message[42] + message[43]).hexToDEC();
    a2FrameDetails.intCLcdDisplayStatus = (message[44] + message[45]).hexToDEC();
    a2FrameDetails.intBLcdDisplayStatus = (message[46] + message[47]).hexToDEC();
    a2FrameDetails.printerStatus = (message[48] + message[49]).hexToDEC();
    a2FrameDetails.validator1Status = (message[50] + message[51]).hexToDEC();
    a2FrameDetails.validator2Status = (message[52] + message[53]).hexToDEC();
    a2FrameDetails.validator3Status = (message[54] + message[55]).hexToDEC();
    a2FrameDetails.validator4Status = (message[56] + message[57]).hexToDEC();
    a2FrameDetails.validator5Status = (message[58] + message[59]).hexToDEC();
    a2FrameDetails.validator6Status = (message[60] + message[61]).hexToDEC();

    a2FrameDetails.apc1Status = (message[62] + message[63]).hexToDEC();
    a2FrameDetails.apc2Status = (message[64] + message[65]).hexToDEC();
    a2FrameDetails.apc3Status = (message[66] + message[67]).hexToDEC();
    a2FrameDetails.apc4Status = (message[68] + message[69]).hexToDEC();
    a2FrameDetails.apc5Status = (message[70] + message[71]).hexToDEC();
    a2FrameDetails.apc6Status = (message[72] + message[73]).hexToDEC();
    a2FrameDetails.obcMcsCommunicationStatus = (message[74] + message[75]).hexToDEC();
    a2FrameDetails.audioDataSync = (message[76] + message[77]).hexToDEC();
    a2FrameDetails.audioAnnouncementStatus = (message[78] + message[79]).hexToDEC();
    a2FrameDetails.obcMemorySpace = (message[80] + message[81]).hexToDEC();
    a2FrameDetails.vehicleID = getIntegerFrom2Bytes((message[82] + message[83]),((message[84] + message[85])));
    a2FrameDetails.driverNumber = getIntegerFrom2Bytes((message[86] + message[87]),((message[88] + message[89])));
    a2FrameDetails.lineNumber = (message[90] + message[91]).hexToDEC();
    a2FrameDetails.vehicleLatitudeGps = getIntegerFrom4Bytes(message[92]+message[93],
        message[94]+message[95],
        message[96]+message[97],
        message[98]+message[99])/1000000;
    a2FrameDetails.vehicleLongitudeGps = getIntegerFrom4Bytes(message[100]+message[101],
        message[102]+message[103],
        message[104]+message[105],
        message[106]+message[107])/1000000;
    a2FrameDetails.reserved1 = (message[108] + message[109]).hexToDEC();
    a2FrameDetails.reserved2 = (message[110] + message[111]).hexToDEC();
    a2FrameDetails.reserved3 = (message[112] + message[113]).hexToDEC();
    a2FrameDetails.reserved4 = (message[114] + message[115]).hexToDEC();
    a2FrameDetails.reserved5 = (message[116] + message[117]).hexToDEC();
    a2FrameDetails.reserved6 = (message[118] + message[119]).hexToDEC();
    a2FrameDetails.lifeCounterFromObcA2 = getIntegerFrom4Bytes(message[120]+message[121],
        message[122]+message[123],
        message[124]+message[125],
        message[126]+message[127])/1000000;
  }
  void generateA3Details(String message) {
    a3FrameDetails.frameID = (message[0] + message[1]).hexToDEC();
    a3FrameDetails.protocolV = (message[2] + message[3]).hexToDEC();
    a3FrameDetails.senderID = (message[4] + message[5]).hexToDEC();
    a3FrameDetails.receiverID = (message[6] + message[7]).hexToDEC();

    a3FrameDetails.payloadLength = getIntegerFrom2Bytes((message[8] + message[9]),((message[10] + message[11])));
    a3FrameDetails.numberOfSoftVer = (message[12] + message[13]).hexToDEC();

    a3FrameDetails.dev01.nameLength = (message[14] + message[15]).hexToDEC();
    a3FrameDetails.dev01.name = getStringFromA3(message, 16, a3FrameDetails.dev01.nameLength);
    int nIndex = 16 + ((message[14] + message[15]).hexToDEC())*2;
    a3FrameDetails.dev01.sWLength = (message[nIndex] + message[nIndex + 1]).hexToDEC();
    a3FrameDetails.dev01.sW = getStringFromA3(message, nIndex + 2, a3FrameDetails.dev01.sWLength);

    int nIndex2 = nIndex + 2 + ((message[nIndex] + message[nIndex + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev02.nameLength = (message[nIndex2] + message[nIndex2 + 1]).hexToDEC();
    a3FrameDetails.dev02.name = getStringFromA3(message, nIndex2 + 2, a3FrameDetails.dev02.nameLength);
    int nIndex3 = nIndex2 + 2 + ((message[nIndex2] + message[nIndex2 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev02.sWLength = (message[nIndex3] + message[nIndex3 + 1]).hexToDEC();
    a3FrameDetails.dev02.sW = getStringFromA3(message, nIndex3 + 2, a3FrameDetails.dev02.sWLength);

    int nIndex4 = nIndex3 + 2 + ((message[nIndex3] + message[nIndex3 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev03.nameLength = (message[nIndex4] + message[nIndex4 + 1]).hexToDEC();
    a3FrameDetails.dev03.name = getStringFromA3(message, nIndex4 + 2, a3FrameDetails.dev03.nameLength);
    int nIndex5 = nIndex4 + 2 + ((message[nIndex4] + message[nIndex4 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev03.sWLength = (message[nIndex5] + message[nIndex5 + 1]).hexToDEC();
    a3FrameDetails.dev03.sW = getStringFromA3(message, nIndex5 + 2, a3FrameDetails.dev03.sWLength);

    int nIndex6 = nIndex5 + 2 + ((message[nIndex5] + message[nIndex5 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev04.nameLength = (message[nIndex6] + message[nIndex6 + 1]).hexToDEC();
    a3FrameDetails.dev04.name = getStringFromA3(message, nIndex6 + 2, a3FrameDetails.dev04.nameLength);
    int nIndex7 = nIndex6 + 2 + ((message[nIndex6] + message[nIndex6 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev04.sWLength = (message[nIndex7] + message[nIndex7 + 1]).hexToDEC();
    a3FrameDetails.dev04.sW = getStringFromA3(message, nIndex7 + 2, a3FrameDetails.dev04.sWLength);

    int nIndex8 = nIndex7 + 2 + ((message[nIndex7] + message[nIndex7 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev05.nameLength = (message[nIndex8] + message[nIndex8 + 1]).hexToDEC();
    a3FrameDetails.dev05.name = getStringFromA3(message, nIndex8 + 2, a3FrameDetails.dev05.nameLength);
    int nIndex9 = nIndex8 + 2 + ((message[nIndex8] + message[nIndex8 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev05.sWLength = (message[nIndex9] + message[nIndex9 + 1]).hexToDEC();
    a3FrameDetails.dev05.sW = getStringFromA3(message, nIndex9 + 2, a3FrameDetails.dev05.sWLength);

    int nIndex10 = nIndex9 + 2 + ((message[nIndex9] + message[nIndex9 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev06.nameLength = (message[nIndex10] + message[nIndex10 + 1]).hexToDEC();
    a3FrameDetails.dev06.name = getStringFromA3(message, nIndex10 + 2, a3FrameDetails.dev06.nameLength);
    int nIndex11 = nIndex10 + 2 + ((message[nIndex10] + message[nIndex10 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev06.sWLength = (message[nIndex11] + message[nIndex11 + 1]).hexToDEC();
    a3FrameDetails.dev06.sW = getStringFromA3(message, nIndex11 + 2, a3FrameDetails.dev06.sWLength);

    int nIndex12 = nIndex11 + 2 + ((message[nIndex11] + message[nIndex11 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev07.nameLength = (message[nIndex12] + message[nIndex12 + 1]).hexToDEC();
    a3FrameDetails.dev07.name = getStringFromA3(message, nIndex12 + 2, a3FrameDetails.dev07.nameLength);
    int nIndex13 = nIndex12 + 2 + ((message[nIndex12] + message[nIndex12 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev07.sWLength = (message[nIndex13] + message[nIndex13 + 1]).hexToDEC();
    a3FrameDetails.dev07.sW = getStringFromA3(message, nIndex13 + 2, a3FrameDetails.dev07.sWLength);

    int nIndex14 = nIndex13 + 2 + ((message[nIndex13] + message[nIndex13 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev08.nameLength = (message[nIndex14] + message[nIndex14 + 1]).hexToDEC();
    a3FrameDetails.dev08.name = getStringFromA3(message, nIndex14 + 2, a3FrameDetails.dev08.nameLength);
    int nIndex15 = nIndex14 + 2 + ((message[nIndex14] + message[nIndex14 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev08.sWLength = (message[nIndex15] + message[nIndex15 + 1]).hexToDEC();
    a3FrameDetails.dev08.sW = getStringFromA3(message, nIndex15 + 2, a3FrameDetails.dev08.sWLength);

    int nIndex16 = nIndex15 + 2 + ((message[nIndex15] + message[nIndex15 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev09.nameLength = (message[nIndex16] + message[nIndex16 + 1]).hexToDEC();
    a3FrameDetails.dev09.name = getStringFromA3(message, nIndex16 + 2, a3FrameDetails.dev09.nameLength);
    int nIndex17 = nIndex16 + 2 + ((message[nIndex16] + message[nIndex16 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev09.sWLength = (message[nIndex17] + message[nIndex17 + 1]).hexToDEC();
    a3FrameDetails.dev09.sW = getStringFromA3(message, nIndex17 + 2, a3FrameDetails.dev09.sWLength);

    int nIndex18 = nIndex17 + 2 + ((message[nIndex17] + message[nIndex17 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev10.nameLength = (message[nIndex18] + message[nIndex18 + 1]).hexToDEC();
    a3FrameDetails.dev10.name = getStringFromA3(message, nIndex18 + 2, a3FrameDetails.dev10.nameLength);
    int nIndex19 = nIndex18 + 2 + ((message[nIndex18] + message[nIndex18 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev10.sWLength = (message[nIndex19] + message[nIndex19 + 1]).hexToDEC();
    a3FrameDetails.dev10.sW = getStringFromA3(message, nIndex19 + 2, a3FrameDetails.dev10.sWLength);

    int nIndex20 = nIndex19 + 2 + ((message[nIndex19] + message[nIndex19 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev11.nameLength = (message[nIndex20] + message[nIndex20 + 1]).hexToDEC();
    a3FrameDetails.dev11.name = getStringFromA3(message, nIndex20 + 2, a3FrameDetails.dev11.nameLength);
    int nIndex21 = nIndex20 + 2 + ((message[nIndex20] + message[nIndex20 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev11.sWLength = (message[nIndex21] + message[nIndex21 + 1]).hexToDEC();
    a3FrameDetails.dev11.sW = getStringFromA3(message, nIndex21 + 2, a3FrameDetails.dev11.sWLength);

    int nIndex22 = nIndex21 + 2 + ((message[nIndex21] + message[nIndex21 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev12.nameLength = (message[nIndex22] + message[nIndex22 + 1]).hexToDEC();
    a3FrameDetails.dev12.name = getStringFromA3(message, nIndex22 + 2, a3FrameDetails.dev12.nameLength);
    int nIndex23 = nIndex22 + 2 + ((message[nIndex22] + message[nIndex22 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev12.sWLength = (message[nIndex23] + message[nIndex23 + 1]).hexToDEC();
    a3FrameDetails.dev12.sW = getStringFromA3(message, nIndex23 + 2, a3FrameDetails.dev12.sWLength);

    int nIndex24 = nIndex23 + 2 + ((message[nIndex23] + message[nIndex23 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev13.nameLength = (message[nIndex24] + message[nIndex24 + 1]).hexToDEC();
    a3FrameDetails.dev13.name = getStringFromA3(message, nIndex24 + 2, a3FrameDetails.dev13.nameLength);
    int nIndex25 = nIndex24 + 2 + ((message[nIndex24] + message[nIndex24 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev13.sWLength = (message[nIndex25] + message[nIndex25 + 1]).hexToDEC();
    a3FrameDetails.dev13.sW = getStringFromA3(message, nIndex25 + 2, a3FrameDetails.dev13.sWLength);

    int nIndex26 = nIndex25 + 2 + ((message[nIndex25] + message[nIndex25 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev14.nameLength = (message[nIndex26] + message[nIndex26 + 1]).hexToDEC();
    a3FrameDetails.dev14.name = getStringFromA3(message, nIndex26 + 2, a3FrameDetails.dev14.nameLength);
    int nIndex27 = nIndex26 + 2 + ((message[nIndex26] + message[nIndex26 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev14.sWLength = (message[nIndex27] + message[nIndex27 + 1]).hexToDEC();
    a3FrameDetails.dev14.sW = getStringFromA3(message, nIndex27 + 2, a3FrameDetails.dev14.sWLength);

    int nIndex28 = nIndex27 + 2 + ((message[nIndex27] + message[nIndex27 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev15.nameLength = (message[nIndex28] + message[nIndex28 + 1]).hexToDEC();
    a3FrameDetails.dev15.name = getStringFromA3(message, nIndex28 + 2, a3FrameDetails.dev15.nameLength);
    int nIndex29 = nIndex28 + 2 + ((message[nIndex28] + message[nIndex28 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev15.sWLength = (message[nIndex29] + message[nIndex29 + 1]).hexToDEC();
    a3FrameDetails.dev15.sW = getStringFromA3(message, nIndex29 + 2, a3FrameDetails.dev15.sWLength);

    int nIndex30 = nIndex29 + 2 + ((message[nIndex29] + message[nIndex29 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev16.nameLength = (message[nIndex30] + message[nIndex30 + 1]).hexToDEC();
    a3FrameDetails.dev16.name = getStringFromA3(message, nIndex30 + 2, a3FrameDetails.dev16.nameLength);
    int nIndex31 = nIndex30 + 2 + ((message[nIndex30] + message[nIndex30 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev16.sWLength = (message[nIndex31] + message[nIndex31 + 1]).hexToDEC();
    a3FrameDetails.dev16.sW = getStringFromA3(message, nIndex31 + 2, a3FrameDetails.dev16.sWLength);

    int nIndex32 = nIndex31 + 2 + ((message[nIndex31] + message[nIndex31 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev17.nameLength = (message[nIndex32] + message[nIndex32 + 1]).hexToDEC();
    a3FrameDetails.dev17.name = getStringFromA3(message, nIndex32 + 2, a3FrameDetails.dev17.nameLength);
    int nIndex33 = nIndex32 + 2 + ((message[nIndex32] + message[nIndex32 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev17.sWLength = (message[nIndex33] + message[nIndex33 + 1]).hexToDEC();
    a3FrameDetails.dev17.sW = getStringFromA3(message, nIndex33 + 2, a3FrameDetails.dev17.sWLength);

    int nIndex34 = nIndex33 + 2 + ((message[nIndex33] + message[nIndex33 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev18.nameLength = (message[nIndex34] + message[nIndex34 + 1]).hexToDEC();
    a3FrameDetails.dev18.name = getStringFromA3(message, nIndex34 + 2, a3FrameDetails.dev18.nameLength);
    int nIndex35 = nIndex34 + 2 + ((message[nIndex34] + message[nIndex34 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev18.sWLength = (message[nIndex35] + message[nIndex35 + 1]).hexToDEC();
    a3FrameDetails.dev18.sW = getStringFromA3(message, nIndex35 + 2, a3FrameDetails.dev18.sWLength);

    int nIndex36 = nIndex35 + 2 + ((message[nIndex35] + message[nIndex35 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev19.nameLength = (message[nIndex36] + message[nIndex36 + 1]).hexToDEC();
    a3FrameDetails.dev19.name = getStringFromA3(message, nIndex36 + 2, a3FrameDetails.dev19.nameLength);
    int nIndex37 = nIndex36 + 2 + ((message[nIndex36] + message[nIndex36 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev19.sWLength = (message[nIndex37] + message[nIndex37 + 1]).hexToDEC();
    a3FrameDetails.dev19.sW = getStringFromA3(message, nIndex37 + 2, a3FrameDetails.dev19.sWLength);

    int nIndex38 = nIndex37 + 2 + ((message[nIndex37] + message[nIndex37 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev20.nameLength = (message[nIndex38] + message[nIndex38 + 1]).hexToDEC();
    a3FrameDetails.dev20.name = getStringFromA3(message, nIndex38 + 2, a3FrameDetails.dev20.nameLength);
    int nIndex39 = nIndex38 + 2 + ((message[nIndex38] + message[nIndex38 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev20.sWLength = (message[nIndex39] + message[nIndex39 + 1]).hexToDEC();
    a3FrameDetails.dev20.sW = getStringFromA3(message, nIndex39 + 2, a3FrameDetails.dev20.sWLength);

    int nIndex40 = nIndex39 + 2 + ((message[nIndex39] + message[nIndex39 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev21.nameLength = (message[nIndex40] + message[nIndex40 + 1]).hexToDEC();
    a3FrameDetails.dev21.name = getStringFromA3(message, nIndex40 + 2, a3FrameDetails.dev21.nameLength);
    int nIndex41 = nIndex40 + 2 + ((message[nIndex40] + message[nIndex40 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev21.sWLength = (message[nIndex41] + message[nIndex41 + 1]).hexToDEC();
    a3FrameDetails.dev21.sW = getStringFromA3(message, nIndex41 + 2, a3FrameDetails.dev21.sWLength);

    int nIndex42 = nIndex41 + 2 + ((message[nIndex41] + message[nIndex41 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev22.nameLength = (message[nIndex42] + message[nIndex42 + 1]).hexToDEC();
    a3FrameDetails.dev22.name = getStringFromA3(message, nIndex42 + 2, a3FrameDetails.dev22.nameLength);
    int nIndex43 = nIndex42 + 2 + ((message[nIndex42] + message[nIndex42 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev22.sWLength = (message[nIndex43] + message[nIndex43 + 1]).hexToDEC();
    a3FrameDetails.dev22.sW = getStringFromA3(message, nIndex43 + 2, a3FrameDetails.dev22.sWLength);

    int nIndex44 = nIndex43 + 2 + ((message[nIndex43] + message[nIndex43 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev23.nameLength = (message[nIndex44] + message[nIndex44 + 1]).hexToDEC();
    a3FrameDetails.dev23.name = getStringFromA3(message, nIndex44 + 2, a3FrameDetails.dev23.nameLength);
    int nIndex45 = nIndex44 + 2 + ((message[nIndex44] + message[nIndex44 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev23.sWLength = (message[nIndex45] + message[nIndex45 + 1]).hexToDEC();
    a3FrameDetails.dev23.sW = getStringFromA3(message, nIndex45 + 2, a3FrameDetails.dev23.sWLength);

    int nIndex46 = nIndex45 + 2 + ((message[nIndex45] + message[nIndex45 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev24.nameLength = (message[nIndex46] + message[nIndex46 + 1]).hexToDEC();
    a3FrameDetails.dev24.name = getStringFromA3(message, nIndex46 + 2, a3FrameDetails.dev24.nameLength);
    int nIndex47 = nIndex46 + 2 + ((message[nIndex46] + message[nIndex46 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev24.sWLength = (message[nIndex47] + message[nIndex47 + 1]).hexToDEC();
    a3FrameDetails.dev24.sW = getStringFromA3(message, nIndex47 + 2, a3FrameDetails.dev24.sWLength);

    int nIndex48 = nIndex47 + 2 + ((message[nIndex47] + message[nIndex47 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev25.nameLength = (message[nIndex48] + message[nIndex48 + 1]).hexToDEC();
    a3FrameDetails.dev25.name = getStringFromA3(message, nIndex48 + 2, a3FrameDetails.dev25.nameLength);
    int nIndex49 = nIndex48 + 2 + ((message[nIndex48] + message[nIndex48 + 1]).hexToDEC()) * 2;
    a3FrameDetails.dev25.sWLength = (message[nIndex49] + message[nIndex49 + 1]).hexToDEC();
    a3FrameDetails.dev25.sW = getStringFromA3(message, nIndex49 + 2, a3FrameDetails.dev25.sWLength);

    int nIndex50 = nIndex49 + 2 + ((message[nIndex49] + message[nIndex49 + 1]).hexToDEC()) * 2;
    a3FrameDetails.lifeCounterFromObcA3 = getIntegerFrom4Bytes(message[nIndex50], message[nIndex50+1], message[nIndex50+2], message[nIndex50+3]);
  }
  void testingVariable() {
    /* var latNormalized = normalizePosition(latitudeToNormalize);
    var latNormalizedHEX = get4BytesFromIntegerHEX(latNormalized);
    var lonNormalized = normalizePosition(longitudeToNormalize);
    var lonNormalizedHEX = get4BytesFromIntegerHEX(lonNormalized);
    print('\n'
        '43.82989204611934 -- normalized $latNormalized | HEX : $latNormalizedHEX  \n'
        '18.308218931755135-- normalized $lonNormalized | HEX : $lonNormalizedHEX')  ;*/
  }
  void resetUdpListener() {}
  getStringFromA3(String message,int startByte, devNameLength) {
    List<int> devNameDecode = [];
    int j = 0;
    for(int i=startByte; i<(startByte + devNameLength*2); i++)
    {
      if(j%2==0)
      {
        devNameDecode.add((message[i] + message[i+1]).hexToDEC());
      }
      j++;
    }
    String result = const Utf8Decoder().convert(devNameDecode);
    return result;
  }
  getDetailsWithDescription(String description, var devSW) {
    return TableRow(children: [
      Text(
        description,
        style: const TextStyle(fontSize: 15.0),
      ),
      Text(
        devSW.toString(),
        style: const TextStyle(fontSize: 15.0),
      ),
    ]);
  }
  getDeviceNameAndSWasRow(DeviceProperties device) {
    return TableRow(children: [
      Text(
        device.name.toString(),
        style: const TextStyle(fontSize: 15.0),
      ),
      Text(
        device.sW.toString(),
        style: const TextStyle(fontSize: 15.0),
      ),
    ]);
  }

  void clearDisplayedData() {
    a2FrameDetails = A2Frame();
  }

  checkBoxToggler(String labelText, bool initValue, bool Function() onChange) {
    return Row(
      children: [
        Text(labelText),
        Checkbox(value: initValue, onChanged: (value) => {
          setState(() {
            onChange();
          })
        },)
      ],
    );
  }
}