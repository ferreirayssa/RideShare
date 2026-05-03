import 'package:flutter/material.dart';
import 'driver_profile_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // AppBar customizada conforme o protótipo
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80, // Aumentado para caber as infos
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DriverProfileScreen()),
          );
        },
        child: Row(
          children: [
            // Foto do Motorista
            const CircleAvatar(
              radius: 22,
              backgroundColor: Colors.greenAccent,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 12),
            // Nome e Avaliação
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Ricardo Carmo",
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: List.generate(
                    5,
                    (i) => const Icon(Icons.star, color: Colors.orange, size: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
        actions: [
          // Ícone de Telefone destacado
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.phone, color: Color(0xFF1DE9B6), size: 28),
              onPressed: () {
                // Lógica para ligar
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Divider(height: 1, color: Colors.black12),
          // Lista de Mensagens
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildChatBubble("Olá! Já estou a caminho.", false, "09:58 PM"),
                _buildChatBubble("Perfeito, estou te aguardando em frente ao prédio.", true, "10:00 PM"),
                _buildChatBubble("Estou passando pelo posto agora, chego em 2 min.", false, "10:01 PM"),
                _buildChatBubble("Combinado!", true, "10:02 PM"),
              ],
            ),
          ),
          // Área de Input
          _buildInputArea(),
        ],
      ),
    );
  }

  // Bolha de Chat (Verde para o usuário, Cinza para o Ricardo)
  Widget _buildChatBubble(String message, bool isMe, String time) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            constraints: const BoxConstraints(maxWidth: 250),
            decoration: BoxDecoration(
              color: isMe ? const Color(0xFF1DE9B6) : const Color(0xFFF1F1F1),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft: Radius.circular(isMe ? 15 : 0),
                bottomRight: Radius.circular(isMe ? 0 : 15),
              ),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              time,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  // Campo de entrada de texto arredondado
  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Digite uma mensagem...",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const CircleAvatar(
              backgroundColor: Color(0xFF1DE9B6),
              radius: 25,
              child: Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}