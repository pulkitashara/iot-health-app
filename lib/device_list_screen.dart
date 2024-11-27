import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, String>>> fetchDevices(String ipAddress) async {
  final response = await http.get(Uri.parse('http://$ipAddress:5000/devices'));
  if (response.statusCode == 200) {
    final List<dynamic> devices = json.decode(response.body);
    return devices.map((device) {
      return {
        "name": device['name'].toString(),
        "id": device['id'].toString(),
      };
    }).toList();
  } else {
    throw Exception("Failed to load devices");
  }
}


class DeviceListScreen extends StatefulWidget {
  const DeviceListScreen({super.key});

  @override
  _DeviceListScreenState createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  late Future<List<Map<String, String>>> devicesFuture;
  late String ipAddress;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments as String;
    ipAddress = arguments;
    devicesFuture = fetchDevices(ipAddress);
  }

  Future<List<Map<String, String>>> fetchDevices(String ipAddress) async {
    final response = await http.get(Uri.parse('http://$ipAddress:5000/devices'));
    if (response.statusCode == 200) {
      final List<dynamic> devices = json.decode(response.body);
      return devices.map((device) {
        return {
          "name": device['name'].toString(),
          "id": device['id'].toString(),
        };
      }).toList();
    } else {
      throw Exception("Failed to load devices");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Devices"),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: devicesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.data!.isEmpty) {
            return const Center(child: Text("No devices found"));
          }

          final devices = snapshot.data!;
          return ListView.builder(
            itemCount: devices.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(devices[index]['name']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/data-visualization',
                        arguments: {
                          'deviceId': devices[index]['id']!,
                          'ipAddress': ipAddress,
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      elevation: 5,
                      side: BorderSide(color: Colors.blue.shade700),
                    ),
                    child: const Text("Connect"),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

