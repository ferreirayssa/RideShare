import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'chat_screen.dart';
import 'profile_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  List<LatLng> _routePoints = [];
  LatLng? _currentLocation;
  LatLng? _destinationLocation;
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen())
      );
    } else if (index == 2) {
      // ESTA É A NAVEGAÇÃO PARA O PERFIL QUE VOCÊ SOLICITOU
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    }
  }

  Future<void> _getCurrentPosition() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _mapController.move(_currentLocation!, 15.0);
    });
  }

  Future<void> _searchAddress(String query) async {
    if (query.isEmpty) return;
    final url = Uri.parse('https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1');
    try {
      final response = await http.get(url, headers: {'User-Agent': 'RideShare_App'});
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        if (data.isNotEmpty) {
          double lat = double.parse(data[0]['lat']);
          double lon = double.parse(data[0]['lon']);
          setState(() {
            _destinationLocation = LatLng(lat, lon);
            _mapController.move(_destinationLocation!, 15.0);
          });
          _getRoute(_destinationLocation!);
        }
      }
    } catch (e) { debugPrint("Erro Nominatim: $e"); }
  }

  Future<void> _getRoute(LatLng destination) async {
    if (_currentLocation == null) await _getCurrentPosition();
    if (_currentLocation == null) return;
    final url = Uri.parse('https://router.project-osrm.org/route/v1/driving/${_currentLocation!.longitude},${_currentLocation!.latitude};${destination.longitude},${destination.latitude}?overview=full&geometries=geojson');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List coords = data['routes'][0]['geometry']['coordinates'];
      setState(() {
        _routePoints = coords.map((c) => LatLng(c[1], c[0])).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Mapa
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(-20.3155, -40.3128),
              initialZoom: 15.0,
              onTap: (tapPosition, point) => _getRoute(point),
            ),
            children: [
              TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
              PolylineLayer(polylines: [Polyline(points: _routePoints, color: Colors.purple, strokeWidth: 5.0)]),
              MarkerLayer(markers: [
                if (_currentLocation != null) Marker(point: _currentLocation!, child: const Icon(Icons.my_location, color: Colors.blue)),
                if (_destinationLocation != null) Marker(point: _destinationLocation!, child: const Icon(Icons.location_on, color: Colors.red, size: 40)),
                const Marker(point: LatLng(-20.3175, -40.3115), child: Icon(Icons.directions_car, color: Colors.blue, size: 35)),
              ]),
            ],
          ),

          // Busca
          Positioned(
            top: 40, left: 20, right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)]),
              child: Row(children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 10),
                Expanded(child: TextField(controller: _searchController, decoration: const InputDecoration(hintText: "Para onde vamos?", border: InputBorder.none), onSubmitted: _searchAddress)),
                IconButton(icon: const Icon(Icons.my_location, color: Colors.blue), onPressed: _getCurrentPosition),
              ]),
            ),
          ),

          // Card do Ricardo com Ícones de Pagamento
          Positioned(
            top: 120, left: 30, right: 30,
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen())),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)]),
                child: Row(children: [
                  const CircleAvatar(radius: 30, backgroundColor: Colors.greenAccent, child: Icon(Icons.person, color: Colors.white, size: 40)),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text("Ricardo Carmo", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("R\$ 19,90", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                    ]),
                    Row(children: List.generate(5, (i) => const Icon(Icons.star, color: Colors.orange, size: 16))),
                    const SizedBox(height: 5),
                    // Ícones de Cartão e Pagamento restaurados
                    const Row(
                      children: [
                        Icon(Icons.credit_card, size: 20, color: Colors.blue),
                        SizedBox(width: 5),
                        Icon(Icons.payment, size: 20, color: Colors.red),
                      ],
                    ),
                  ])),
                ]),
              ),
            ),
          ),

          // Botão de Aceitar (Camada Superior)
          Positioned(
            bottom: 30,
            left: 50,
            right: 50,
            child: ElevatedButton(
              onPressed: () {
                debugPrint("Carona Aceita!");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1DE9B6),
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text("Aceitar", style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ),
        ],
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false, showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: "Corrida"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Perfil"),
        ],
      ),
    );
  }
}