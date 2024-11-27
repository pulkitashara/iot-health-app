# IoT-Connected Health App Prototype

## Overview
This project is a prototype of an IoT-Connected Health App built using **Flutter** for the frontend and **Flask** for the backend. The application simulates real-time health data communication, such as temperature and heart rate, over a Wi-Fi connection, with the Bluetooth connection currently simulated as Wi-Fi.

## Features
- Real-time monitoring of health data (temperature and heart rate).
- Integration with a backend server using Flask.
- Simple and intuitive UI for ease of use.
- Simulated device connection over Wi-Fi.

## Prerequisites
- **Python** (version 3.7 or higher)
- **Flutter** (version 3.x or higher)
- A mobile device and PC connected to the same Wi-Fi network.

## Backend (Flask) Setup
1. Connect both your PC and mobile device to the **same network**.
2. Install Python and necessary Flask libraries:
   ```bash  
   pip install flask flask-cors  
   ```  
3. Run the Flask backend by executing `app.py`:
   ```bash  
   python app.py  
   ```  
4. Note the IP address of your PC (e.g., `192.168.x.x`) displayed in the terminal.

## Mobile App (Flutter) Setup
1. Ensure Flutter is installed on your system.
2. Navigate to the project directory and run the app:
   ```bash  
   flutter run  
   ```  

## Usage
1. Start the Flask server on your PC by running `app.py`.
2. Launch the mobile app on your device.
3. Enter the PC's IP address into the app when prompted.
4. Select an IoT device from the displayed list.
5. View real-time updates of temperature and heart rate data on the dashboard.

## Application Workflow
1. **Home Screen**: Enter the device name and PC's IP address and select the connection type (Wi-Fi).
2. **Device List Screen**: Fetches available devices from the backend and displays them.
3. **Data Dashboard**: Displays the current temperature and heart rate in real time.

## Technologies Used
- **Flutter**: Mobile application framework.
- **Flask**: Backend API framework.
- **Dart & Python**: Primary languages for the app and backend.
- **HTTP & Wi-Fi**: Protocols for communication between the app and backend.

## Demonstration Videos
For a complete demonstration of the application usage, refer to the following video link:
- [App Usage Demonstration](https://drive.google.com/drive/folders/1QrrhbRHXBPVwsFCJmd-T_NpMzw4jc4rr?usp=sharing)  