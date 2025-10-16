import '../models/console.dart';

class ConsoleService {
  static List<Console> getConsoles() {
    return [
      Console(
        id: 1,
        name: "PlayStation 5",
        manufacturer: "Sony",
        year: 2020,
        description: "Consola de videojuegos de novena generación desarrollada por Sony Interactive Entertainment con tecnología de última generación.",
        imageUrl: "https://i.imgur.com/YlGGiVH.png",
      ),
      Console(
        id: 2,
        name: "Xbox Series X",
        manufacturer: "Microsoft",
        year: 2020,
        description: "La consola Xbox más potente jamás creada, diseñada para ofrecer rendimiento, velocidad y compatibilidad excepcionales.",
        imageUrl: "https://i.imgur.com/p7qIlBr.png",
      ),
      Console(
        id: 3,
        name: "Nintendo Switch",
        manufacturer: "Nintendo",
        year: 2017,
        description: "Consola híbrida innovadora que se puede usar tanto en casa como en modo portátil.",
        imageUrl: "https://i.imgur.com/6lKXqVP.png",
      ),
      Console(
        id: 4,
        name: "PlayStation 4",
        manufacturer: "Sony",
        year: 2013,
        description: "Consola de octava generación con un amplio catálogo de juegos exclusivos y experiencias inmersivas.",
        imageUrl: "https://i.imgur.com/8cGzXfK.png",
      ),
      Console(
        id: 5,
        name: "Xbox One",
        manufacturer: "Microsoft",
        year: 2013,
        description: "Centro de entretenimiento todo en uno que combina juegos, aplicaciones y entretenimiento multimedia.",
        imageUrl: "https://i.imgur.com/mZ8oVfP.png",
      ),
      Console(
        id: 6,
        name: "Nintendo Switch OLED",
        manufacturer: "Nintendo",
        year: 2021,
        description: "Versión mejorada del Switch con pantalla OLED de 7 pulgadas para una experiencia visual superior.",
        imageUrl: "https://i.imgur.com/9K2XbLe.png",
      ),
    ];
  }

  static List<Joystick> getAllJoysticks() {
    return [
      // PlayStation 5 Controllers
      Joystick(
        id: 1,
        name: "DualSense",
        type: "Control inalámbrico",
        imageUrl: "https://i.imgur.com/kVx8YzD.png",
        consoleId: 1,
        connectivity: "Bluetooth / USB-C",
        isWireless: true,
      ),
      Joystick(
        id: 2,
        name: "DualSense Edge",
        type: "Control Pro personalizable",
        imageUrl: "https://i.imgur.com/vQw3KpE.png",
        consoleId: 1,
        connectivity: "Bluetooth / USB-C",
        isWireless: true,
      ),
      
      // Xbox Series X Controllers
      Joystick(
        id: 3,
        name: "Xbox Wireless Controller",
        type: "Control inalámbrico",
        imageUrl: "https://i.imgur.com/0RmL2qh.png",
        consoleId: 2,
        connectivity: "Bluetooth / USB-C",
        isWireless: true,
      ),
      Joystick(
        id: 4,
        name: "Xbox Elite Series 2",
        type: "Control Elite personalizable",
        imageUrl: "https://i.imgur.com/xR4MnPl.png",
        consoleId: 2,
        connectivity: "Bluetooth / USB-C",
        isWireless: true,
      ),
      
      // Nintendo Switch Controllers
      Joystick(
        id: 5,
        name: "Joy-Con (L/R)",
        type: "Controles desmontables",
        imageUrl: "https://i.imgur.com/tVx9JqK.png",
        consoleId: 3,
        connectivity: "Bluetooth",
        isWireless: true,
      ),
      Joystick(
        id: 6,
        name: "Pro Controller",
        type: "Control Pro tradicional",
        imageUrl: "https://i.imgur.com/fH7MnBx.png",
        consoleId: 3,
        connectivity: "Bluetooth / USB-C",
        isWireless: true,
      ),
      
      // PlayStation 4 Controllers
      Joystick(
        id: 7,
        name: "DualShock 4",
        type: "Control inalámbrico",
        imageUrl: "https://i.imgur.com/L5B2xZr.png",
        consoleId: 4,
        connectivity: "Bluetooth / USB",
        isWireless: true,
      ),
      
      // Xbox One Controllers
      Joystick(
        id: 8,
        name: "Xbox One Controller",
        type: "Control inalámbrico",
        imageUrl: "https://i.imgur.com/dHx4KpL.png",
        consoleId: 5,
        connectivity: "Bluetooth / USB",
        isWireless: true,
      ),
      
      // Nintendo Switch OLED Controllers
      Joystick(
        id: 9,
        name: "Joy-Con OLED (L/R)",
        type: "Controles desmontables",
        imageUrl: "https://i.imgur.com/aL8pQxW.png",
        consoleId: 6,
        connectivity: "Bluetooth",
        isWireless: true,
      ),
    ];
  }

  static List<Joystick> getJoysticksByConsole(int consoleId) {
    return getAllJoysticks().where((joystick) => joystick.consoleId == consoleId).toList();
  }

  static Console? getConsoleById(int id) {
    final consoles = getConsoles();
    try {
      return consoles.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  static Joystick? getJoystickById(int id) {
    final joysticks = getAllJoysticks();
    try {
      return joysticks.firstWhere((j) => j.id == id);
    } catch (e) {
      return null;
    }
  }

  static String getConsoleName(int consoleId) {
    final console = getConsoleById(consoleId);
    return console?.name ?? 'Consola desconocida';
  }
}