import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Stream<Map<String, dynamic>> fetchSensorData(String deviceId, String ipAddress) async* {
  while (true) {
    await Future.delayed(const Duration(seconds: 2));
    final response = await http.get(
      Uri.parse('http://$ipAddress:5000/devices/$deviceId/data'),
    );
    if (response.statusCode == 200) {
      yield json.decode(response.body);
    } else {
      throw Exception("Failed to fetch data for device $deviceId");
    }
  }
}

class DataVisualizationScreen extends StatelessWidget {
  const DataVisualizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
    final String deviceId = arguments['deviceId'] ?? '';
    final String ipAddress = arguments['ipAddress'] ?? '';

    if (deviceId.isEmpty || ipAddress.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("Device ID or IP Address is missing!")),
      );
    }

    final Stream<Map<String, dynamic>> sensorDataStream = fetchSensorData(deviceId, ipAddress);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sensor Data"),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder<Map<String, dynamic>>(
        stream: sensorDataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildCard("Timestamp", data['timestamp'], Icons.access_time),
                const SizedBox(height: 12),
                _buildCard("Temperature", "${data['temperature']} °C", Icons.thermostat),
                const SizedBox(height: 12),
                _buildCard("Heart Rate", "${data['heartRate']} bpm", Icons.favorite),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(String label, String value, IconData icon) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



