from flask import Flask, jsonify
import random
import datetime
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/devices', methods=['GET'])
def get_devices():
    devices = [
        {"name": "Device A", "id": "1"},
        {"name": "Device B", "id": "2"},
        {"name": "Device C", "id": "3"}
    ]
    return jsonify(devices)

@app.route('/devices/<device_id>/data', methods=['GET'])
def get_device_data(device_id):
    return jsonify({
        "timestamp": datetime.datetime.now().isoformat(),
        "temperature": round(36 + random.uniform(-1, 1), 2),
        "heartRate": random.randint(60, 100),
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)