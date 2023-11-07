class A2Frame {
  var frameID;
  var protocolV;
  var senderID;
  var receiverID;
  var payloadLength;
  var panicButtonStatus;
  var wfLubricationRequest;
  var obcStatus;
  var pisTouchscreenStatus;
  var gpsConnectionStatus;
  var wiFiConnectionStatus;
  var gsm4GConnectionStatus;
  var accessLevelToPisTouchscreen;
  var usbDataTransfer;
  var frontExtLedDisplayStatus;
  var sideAExtLedDisplayStatus;
  var sideBExtLedDisplayStatus;
  var rearExtLedDisplayStatus;
  var intALedDisplayStatus;
  var intCLedDisplayStatus;
  var intBLedDisplayStatus;
  var intALcdDisplayStatus;
  var intCLcdDisplayStatus;
  var intBLcdDisplayStatus;
  var printerStatus;
  var validator1Status;
  var validator2Status;
  var validator3Status;
  var validator4Status;
  var validator5Status;
  var validator6Status;
  var apc1Status;
  var apc2Status;
  var apc3Status;
  var apc4Status;
  var apc5Status;
  var apc6Status;
  var obcMcsCommunicationStatus;
  var audioDataSync;
  var audioAnnouncementStatus;
  var obcMemorySpace;
  var vehicleID;
  var driverNumber;
  var lineNumber;
  var vehicleLatitudeGps;
  var vehicleLongitudeGps;
  var reserved1;
  var reserved2;
  var reserved3;
  var reserved4;
  var reserved5;
  var reserved6;
  var lifeCounterFromObcA2;
}
class DeviceProperties {
  var nameLength;
  var name;
  var sW;
  var sWLength;
}
class A3Frame {
  var frameID;
  var protocolV;
  var senderID;
  var receiverID;
  var payloadLength;
  var numberOfSoftVer;
  var lifeCounterFromObcA3;

  late DeviceProperties dev01 = DeviceProperties();
  late DeviceProperties dev02 = DeviceProperties();
  late DeviceProperties dev03 = DeviceProperties();
  late DeviceProperties dev04 = DeviceProperties();
  late DeviceProperties dev05 = DeviceProperties();
  late DeviceProperties dev06 = DeviceProperties();
  late DeviceProperties dev07 = DeviceProperties();
  late DeviceProperties dev08 = DeviceProperties();
  late DeviceProperties dev09 = DeviceProperties();
  late DeviceProperties dev10 = DeviceProperties();
  late DeviceProperties dev11 = DeviceProperties();
  late DeviceProperties dev12 = DeviceProperties();
  late DeviceProperties dev13 = DeviceProperties();
  late DeviceProperties dev14 = DeviceProperties();
  late DeviceProperties dev15 = DeviceProperties();
  late DeviceProperties dev16 = DeviceProperties();
  late DeviceProperties dev17 = DeviceProperties();
  late DeviceProperties dev18 = DeviceProperties();
  late DeviceProperties dev19 = DeviceProperties();
  late DeviceProperties dev20 = DeviceProperties();
  late DeviceProperties dev21 = DeviceProperties();
  late DeviceProperties dev22 = DeviceProperties();
  late DeviceProperties dev23 = DeviceProperties();
  late DeviceProperties dev24 = DeviceProperties();
  late DeviceProperties dev25 = DeviceProperties();
}