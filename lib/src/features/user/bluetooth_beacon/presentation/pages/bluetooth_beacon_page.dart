import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/appbar.dart';
import 'send_time_page.dart';


class BluetoothBeaconPage extends StatefulWidget {
  const BluetoothBeaconPage({super.key});

  @override
  State<BluetoothBeaconPage> createState() => _BluetoothBeaconPageState();
}

class _BluetoothBeaconPageState extends State<BluetoothBeaconPage> {
  List<BluetoothDevice> devices = [];

  bool isScanning = false;
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? characteristic;

  @override
  void initState() {
    super.initState();
    // scanForDevices();
  }

  Future<void> scanForDevices() async {
    devices.clear();
    var status = await Permission.bluetoothScan.request();
    var locationStatus = await Permission.location.request();
    if(status.isGranted && locationStatus.isGranted){
      if(!isScanning){
        try {
          await FlutterBluePlus.startScan(timeout: Duration(seconds: 10));
          setState(() {
            isScanning = true;
          });
          FlutterBluePlus.scanResults.listen((results) {
            for (ScanResult result in results) {
              // log("${result.device.platformName == "51:00:22:08:05:FD" || result.device.platformName == "51:00:22:08:05:EF"}");
              if (!devices.contains(result.device)) {
                setState(() {
                  devices.add(result.device);
                });
              }
            }
          });
        } catch (e) {
          print("Error scanning for devices: $e");
        }
      }else{
        setState(() {
          isScanning = false;
        });
        FlutterBluePlus.stopScan();
      }
    }
    else{
      print("Bluetooth scanning permission denied.");
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      if(device.isConnected){
        await device.disconnect();
        setState(() {
        });
      }else{
        await device.connect();
        if((device.remoteId.toString() == "51:00:22:08:05:FD") || (device.remoteId.toString() == "51:00:22:08:05:EF")){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SendTimePage(platFormName: device.platformName,),));
        }
      }

    } catch (e) {
      print("Error connecting to device: $e");
    }
  }

  Future<void> discoverServices(BluetoothDevice device) async {
    try {
      List<BluetoothService> services = await device.discoverServices();
      for (BluetoothService service in services) {
        for (BluetoothCharacteristic char in service.characteristics) {
          if (char.properties.read) {
            setState(() {
              characteristic = char;
            });

            List<int> value = await char.read();
            print("Characteristic value: $value");
          }
        }
      }
    } catch (e) {
      print("Error discovering services: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBluetooth(context),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: devices.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              elevation: 10,
              child: ListTile(
                onTap: (){
                  connectToDevice(devices[index]);
                },
                title: Text(devices[index].platformName),
                leading: Icon(Icons.bluetooth),
                subtitle: Text(devices[index].remoteId.toString()),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: devices[index].isConnected?const Color(0xffD8F2DC):const Color(0xffFFD7DB)
                  ),
                  child: devices[index].isConnected? Text("CONNECTED",style: TextStyle(
                    color: const Color(0xff229A16)
                  ),):Text("CONNECT",style: TextStyle(
                      color: const Color(0xffB72136)
                  ),)
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: scanForDevices,
        elevation: 10,
        child: isScanning? Icon(Icons.cancel_outlined) :Icon(Icons.bluetooth),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    FlutterBluePlus.stopScan();
    if (connectedDevice != null) {
      connectedDevice!.disconnect();
    }

  }
}
