import 'package:flutter/material.dart';
import 'map_screen.dart';

void main() {
  runApp(const RideShareApp());
}

class RideShareApp extends StatelessWidget {
  const RideShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Aplicando o gradiente de fundo do protótipo
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF00E5FF), Color(0xFF1DE9B6), Color(0xFF7CFF01)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo de Carro (Substitua por um Asset se preferir)
              const Icon(Icons.directions_car, size: 100, color: Colors.blueAccent),
              const SizedBox(height: 20),
              const Text(
                'RideShare',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Caronas comunitárias com segurança',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 60),
              
              // Botão Passageiro
              _buildMainButton(
                "Sou passageiro", 
                Colors.greenAccent.shade100, 
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapScreen()),
                  );
                }
              ),

              const SizedBox(height: 20),
              
              // Botão Motorista
              _buildMainButton("Sou motorista", Colors.lightGreenAccent),
              
              const SizedBox(height: 40),
              const Text("ou", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 20),
              
              // Ícones de Redes Sociais
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialIcon(Icons.email, Colors.red),
                  const SizedBox(width: 20),
                  _socialIcon(Icons.facebook, Colors.blue.shade800),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainButton(String text, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap, 
      child: Container(
        width: 280,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon, Color color) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 25,
      child: Icon(icon, color: color, size: 35),
    );
  }
}