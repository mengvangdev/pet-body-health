import 'dart:developer';

import 'package:pet_body_health/resources/resources.dart';

class BleProvider extends ChangeNotifier {
  BleProvider(this.context);
  final BuildContext context;

  late BluetoothDevice device;

  // this variable is checked when user turns off the Bluetooth adapter from the system.
  BlueState turnOffState = BlueState.none;

  final BluetoothAdapterState _blueState = BluetoothAdapterState.off;
  // get
  BluetoothAdapterState get blueState => _blueState;

  bool _connected = false;
  bool get connected => _connected;

  void connection() {
    if (_connected) {
      _disConnect();
    } else {
      _scanDevice();
    }
  }

  void _scanDevice() async {
    // First, check if bluetooth is supported by your hardware
    // Note: The platform is initialized on the first call to any FlutterBluePlus method.
    if (await FlutterBluePlus.isSupported == false) {
      return;
    }

    var subScripion = FlutterBluePlus.adapterState.listen(
      (state) async {
        log("---------------listen state --------------");

        // If Bluetooth adapter is turn off
        if (state == BluetoothAdapterState.off) {
          log(state.toString());
          // If user turns off bluetooth adapter from system.
          // if (turnOffState == BlueState.isTrue) {
          //   turnOffState = BlueState.none;
          //   return;
          // }
          return;
          // Only Android platform
          // if (Platform.isAndroid) {
          //   try {
          //     // Show device system popup to allow or deny from user to app.
          //     // Note: If first time, it will show popup for Allow or Don't Allow
          //     //await FlutterBluePlus.turnOn().then((val) {
          //       //  turnOffState = BlueState.isTrue;
          //     });
          //   } catch (err) {
          //     log("errer: $err");
          //     return; // if users or your press Deny button on system will return nothing to do next coding.
          //   }
          // }
        }

        // If bluetooth adapter is turn on.
        if (state == BluetoothAdapterState.on) {
          await FlutterBluePlus.startScan(
            withNames: ["UART Service"],
            timeout: const Duration(seconds: 10),
            oneByOne: false,
          );
          _scanResult();
        }
      },
    );

    // Cleanup: cancel subscription when scanning stops
    FlutterBluePlus.cancelWhenScanComplete(subScripion);
  }

  void _scanResult() async {
    // Listen to scan results, use Stream
    var onScan = FlutterBluePlus.onScanResults.listen(
      (results) async {
        if (results.isNotEmpty) {
          /* 
            The device with the highest RSSI (closest to 0)
            is considered the nearest device.
          */
          ScanResult nearest = results.reduce((currently, nextElement) =>
              currently.rssi > nextElement.rssi ? currently : nextElement);
          device = nearest.device;

          // Enable auto connect
          await device.connect(autoConnect: true, mtu: null);

          // Wait until connection and stop scan
          await device.connectionState
              .where((state) => state == BluetoothConnectionState.connected)
              .first
              .then((_) {
            FlutterBluePlus.stopScan();
          });

          // listen when device is connected or disconnected
          _listenConnection();
        }
      },
    );

    FlutterBluePlus.cancelWhenScanComplete(onScan);
  }

  void _listenConnection() {
    device.connectionState.listen(
      (state) {
        if (state == BluetoothConnectionState.connected) {
          _writeCharacteristic("real");
          _connected = true;
        }
        if (state == BluetoothConnectionState.disconnected) {
          _connected = false;
          context.read<PetProvider>().petData.clear();
        }
        notifyListeners();
      },
    );
  }

  void _disConnect() async {
    await device.disconnect();
  }

  // Send data to device
  void _writeCharacteristic(String message) async {
    List<int>? messageBytes = _convertStringToBytes(message);
    if (messageBytes != null) {
      // Request larger MTU size
      // Response has 20 bytes that is default
      await device.requestMtu(512);

      List<BluetoothService> services = await device.discoverServices();
      if (services.isNotEmpty) {
        for (var service in services) {
          for (var character in service.characteristics) {
            // Check if the characteristic supports write
            if (character.properties.write && !character.properties.read) {
              try {
                await character.write(messageBytes,
                    withoutResponse: false, allowLongWrite: true);

                // log("Write successful to characteristic ${character.uuid}");
              } catch (e) {
                log("Failed to write to characteristic: $e");
                log("Faild characteristic ${character.uuid}");
              }
            }
            //  else {
            //   log("Skipping characteristic ${character.characteristicUuid} - no write permission");
            // }

            // If characteristic supports indication or notify, enable it
            if (character.properties.notify) {
              await character.setNotifyValue(true);
              await Future.delayed(Durations.long2);
              character.lastValueStream.listen((response) {
                // log("Response from ${character.uuid}: $response");
                if (response.isNotEmpty) {
                  _changeData(response);
                }
              });
            }
          }
        }
      }
    }
  }

  void _changeData(List<int> resBytes) {
    String? text = _convertBytestoString(resBytes);
    // Data format like this: text = "T:23.05 A:5 P:2 / x.-0.06 , y.0.04 , z.-0.02 / p.0 "

    if (text != null) {
      var textList = text.split(" ");
      // textList = ["T:23.05", "A:5", "P:2", "/", "x.-0.06", ",", "y.0.04", ",", "z.-0.02", "/", "p.0", " "]

      textList.removeLast();
      textList.removeWhere((element) => element == "/" || element == ",");
      // textList = ["T:23.05", "A:5", "P:2", "x.-0.06", "y.0.04", "z.-0.02", "p.0"]
      for (var i = 0; i < textList.length; i++) {
        textList[i] = textList[i].substring(
            2); // Each element starts with index 2 to the end or remove index 0 and 1
        // log("index $i : ${textList[i]}");
      }
      log(textList.toString());
      // textList = ["23.05", "5", "2", "-0.06", "0.04", "-0.02", "0"]

      // Convert string to int and double
      double temperature = double.parse(textList[0]);
      int activity = int.parse(textList[1]);
      int hart = int.parse(textList[2]);
      double gx = double.parse(textList[3]);
      double gy = double.parse(textList[4]);
      double gz = double.parse(textList[5]);
      int pulse = int.parse(textList[6]);

      var pet = Pet(
        temperature: temperature,
        activity: activity,
        pulse: pulse,
        gaitAxis: GaitAxis(gx: gx, gy: gy, gz: gz),
        hart: hart,
      );
      final petProvider = context.read<PetProvider>();
      petProvider.petData.add(pet);
      petProvider.temperatureGraph();
    }
  }

  List<int>? _convertStringToBytes(String message) {
    try {
      List<int> messageBytes = utf8.encode(message);
      log("convert string to bytes :$messageBytes");
      return messageBytes;
    } catch (e) {
      log("Failed to convert string to bytes.");
      log("Exception : $e");
      return null;
    }
  }

  String? _convertBytestoString(List<int> bytes) {
    try {
      var text = String.fromCharCodes(bytes);
      return text;
    } catch (e) {
      log("failed to convert bytes to string");
      log("Exception in _convertBytesToString function : $e");
      return null;
    }
  }

  void loadData() {
    _writeCharacteristic("real");
  }

  void saveData() {
    _writeCharacteristic("save");
    log("write save");
  }
}
