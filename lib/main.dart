import 'package:flutter/material.dart';
import 'data_visualization_screen.dart';
import 'device_list_screen.dart';

void main() {
  runApp(const IoTHealthApp());
}

class IoTHealthApp extends StatelessWidget {
  const IoTHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT Health App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/device-list': (context) => const DeviceListScreen(),
        '/data-visualization': (context) => const DataVisualizationScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final TextEditingController _deviceNameController = TextEditingController();
  final TextEditingController _ipController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String connectionType = "Bluetooth";

    return Scaffold(
      appBar: AppBar(
        title: const Text("IoT Health App"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(_deviceNameController, "Device Name", Icons.devices),
              const SizedBox(height: 20),
              _buildDropdown(connectionType),
              const SizedBox(height: 20),
              _buildTextField(_ipController, "IP Address", Icons.wifi),
              const SizedBox(height: 20),
              _buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildDropdown(String connectionType) {
    return DropdownButtonFormField<String>(
      value: connectionType,
      items: const [
        DropdownMenuItem(value: "Bluetooth", child: Text("Bluetooth")),
        DropdownMenuItem(value: "Wi-Fi", child: Text("Wi-Fi")),
      ],
      onChanged: (value) {
        connectionType = value!;
      },
      decoration: InputDecoration(
        labelText: "Connection Type",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final ipAddress = _ipController.text;
        Navigator.pushNamed(
          context,
          '/device-list',
          arguments: ipAddress,
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        elevation: 5,
        side: BorderSide(color: Colors.blue.shade700),
      ),
      child: const Text("Submit", style: TextStyle(fontSize: 18)),
    );
  }
}



