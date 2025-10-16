import 'package:flutter/material.dart';
import '../models/console.dart';
import '../services/console_service.dart';
import 'joystick_detail_screen.dart';

class JoysticksScreen extends StatefulWidget {
  const JoysticksScreen({super.key});

  @override
  State<JoysticksScreen> createState() => _JoysticksScreenState();
}

class _JoysticksScreenState extends State<JoysticksScreen> {
  List<Joystick> joysticks = [];

  @override
  void initState() {
    super.initState();
    _loadJoysticks();
  }

  void _loadJoysticks() {
    setState(() {
      joysticks = ConsoleService.getAllJoysticks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: joysticks.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                _loadJoysticks();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: joysticks.length,
                itemBuilder: (context, index) {
                  final joystick = joysticks[index];
                  final consoleName = ConsoleService.getConsoleName(joystick.consoleId);
                  
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => JoystickDetailScreen(joystick: joystick),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Imagen del joystick
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[100],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  joystick.imageUrl,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.gamepad,
                                      size: 40,
                                      color: Colors.grey[400],
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Información del joystick
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    joystick.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    joystick.type,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      consoleName,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[700],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        joystick.isWireless ? Icons.bluetooth : Icons.cable,
                                        size: 16,
                                        color: joystick.isWireless ? Colors.blue[600] : Colors.orange[600],
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        joystick.connectivity,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: joystick.isWireless ? Colors.blue[600] : Colors.orange[600],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Estado inalámbrico
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: joystick.isWireless
                                        ? Colors.green[100]
                                        : Colors.orange[100],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    joystick.isWireless ? 'Inalámbrico' : 'Con cable',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: joystick.isWireless
                                          ? Colors.green[700]
                                          : Colors.orange[700],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[400],
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}