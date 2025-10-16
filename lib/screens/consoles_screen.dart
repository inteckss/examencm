import 'package:flutter/material.dart';
import '../models/console.dart';
import '../services/console_service.dart';
import '../widgets/network_image_widget.dart';
import 'console_detail_screen.dart';

class ConsolesScreen extends StatefulWidget {
  const ConsolesScreen({super.key});

  @override
  State<ConsolesScreen> createState() => _ConsolesScreenState();
}

class _ConsolesScreenState extends State<ConsolesScreen> {
  List<Console> consoles = [];

  @override
  void initState() {
    super.initState();
    _loadConsoles();
  }

  void _loadConsoles() {
    setState(() {
      consoles = ConsoleService.getConsoles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: consoles.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                _loadConsoles();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: consoles.length,
                itemBuilder: (context, index) {
                  final console = consoles[index];
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
                            builder: (context) => ConsoleDetailScreen(console: console),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Imagen de la consola
                            NetworkImageWidget(
                              imageUrl: console.imageUrl,
                              productName: console.name,
                              width: 80,
                              height: 80,
                              borderRadius: 8,
                            ),
                            const SizedBox(width: 16),

                            // Información de la consola
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    console.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    console.manufacturer,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF6C63FF),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Año: ${console.year}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF6C63FF).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Gen ${console.year >= 2020 ? "9" : console.year >= 2012 ? "8" : "7"}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF6C63FF),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Icono de flecha
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF6C63FF),
                              size: 16,
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