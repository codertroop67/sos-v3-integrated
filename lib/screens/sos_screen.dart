import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:math';
import 'package:myapp/screens/history_screen.dart';
import 'package:myapp/services/sensor_service.dart';

class SOSScreen extends StatefulWidget {
  const SOSScreen({super.key});

  @override
  State<SOSScreen> createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> {
  bool isDetectionOn = false;
  bool isFallDetected = false;
  final _sensorService = SensorService();
  double _totalAccel = 0.0;
  Timer? _fallTimer;
  int _countdown = 10;
  LocationData? _locationData;
  final Location _location = Location();

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  void _startMonitoring() {
    _sensorService.startListening(() {
      if (mounted) {
        setState(() {
          _totalAccel = sqrt(pow(_sensorService.ax, 2) +
              pow(_sensorService.ay, 2) +
              pow(_sensorService.az, 2));
        });

        if (_totalAccel > 25 && !isFallDetected) {
          _detectFall();
        }
      }
    });
  }

  void _stopMonitoring() {
    _sensorService.stop();
    if (mounted) {
      setState(() {
        _totalAccel = 0.0;
      });
    }
  }

  Future<void> _getLocation() async {
    try {
      final locationData = await _location.getLocation();
      if (mounted) {
        setState(() {
          _locationData = locationData;
        });
      }
    } catch (e, s) {
      developer.log(
        'Could not get location',
        name: 'SOSScreen',
        error: e,
        stackTrace: s,
      );
    }
  }

  void _sendAlert() {
    if (_locationData != null) {
      developer.log(
        'Fall alert sent! Location: lat=${_locationData!.latitude}, long=${_locationData!.longitude}',
        name: 'SOSScreen.Alert',
      );
      // Here you would typically send the data to a server, an emergency contact, etc.
    } else {
      developer.log(
        'Fall alert sent! But location is not available.',
        name: 'SOSScreen.Alert',
      );
    }
    _resetFallDetection();
  }

  void _detectFall() async {
    await _getLocation();
    if (mounted) {
      setState(() {
        isFallDetected = true;
        _countdown = 10;
      });

      _fallTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        if (_countdown > 0) {
          setState(() {
            _countdown--;
          });
        } else {
          timer.cancel(); // Stop the timer
          _sendAlert();
        }
      });
    }
  }

  void _resetFallDetection() {
    _fallTimer?.cancel();
    if (mounted) {
      setState(() {
        isFallDetected = false;
      });
    }
  }

  @override
  void dispose() {
    _sensorService.stop();
    _fallTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: isFallDetected
          ? null
          : AppBar(
              backgroundColor: const Color(0xFF121212),
              elevation: 0,
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fall Detect',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Fall detection system',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isDetectionOn = !isDetectionOn;
                        if (isDetectionOn) {
                          _startMonitoring();
                        } else {
                          _stopMonitoring();
                        }
                      });
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF1E1E1E),
                        border: Border.all(
                          color: isDetectionOn
                              ? const Color(0xFF1DB954)
                              : Colors.grey,
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isDetectionOn
                                ? const Color(0xFF1DB954).withOpacity(0.3)
                                : Colors.black.withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.power_settings_new,
                            size: 60,
                            color: isDetectionOn
                                ? const Color(0xFF1DB954)
                                : Colors.white,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            isDetectionOn ? 'Detection ON' : 'Detection OFF',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isDetectionOn
                                  ? const Color(0xFF1DB954)
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Total Accel: ${_totalAccel.toStringAsFixed(2)} m/s²',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  const SizedBox(height: 64),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HistoryScreen()),
                      );
                    },
                    icon: const Icon(Icons.history),
                    label: const Text('History'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2C2C2C),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isFallDetected)
            Container(
              color: Colors.black.withOpacity(0.8),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.warning, color: Colors.yellow, size: 60),
                    const SizedBox(height: 16),
                    const Text(
                      'FALL DETECTED',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      '$_countdown',
                      style: const TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const Text(
                      'seconds until alert',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 64),
                    ElevatedButton(
                      onPressed: _resetFallDetection,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1DB954),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 64),
                      ),
                      child: const Text(
                        'I\'M OK',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
