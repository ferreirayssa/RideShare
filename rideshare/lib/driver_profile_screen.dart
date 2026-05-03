import 'package:flutter/material.dart';

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Perfil do Motorista", style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Foto e Avaliação
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.greenAccent,
              child: Icon(Icons.person, size: 70, color: Colors.white),
            ),
            const SizedBox(height: 15),
            const Text(
              "Ricardo Carmo",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (i) => const Icon(Icons.star, color: Colors.orange, size: 20),
              ),
            ),
            const SizedBox(height: 30),

            // Informações do Veículo (Seguindo o padrão visual do BuSafe)
            _buildInfoCard("Veículo", "Toyota Corolla - Prata", Icons.directions_car),
            _buildInfoCard("Placa", "ABC-1234", Icons.pin),
            _buildInfoCard("Viagens", "1.240 viagens concluídas", Icons.route),
            _buildInfoCard("Membro desde", "Janeiro de 2024", Icons.calendar_today),

            const SizedBox(height: 20),
            // Bio do Motorista
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sobre", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(
                      "Motorista profissional focado em segurança e conforto. Conheço bem todas as rotas da Grande Vitória.",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF1DE9B6)),
        title: Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
        tileColor: Colors.white,
      ),
    );
  }
}