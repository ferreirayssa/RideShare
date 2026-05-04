## 🚗 RideShare - Caronas Comunitárias
O *RideShare* é um aplicativo de mobilidade urbana focado em segurança e integração comunitária. O projeto visa facilitar o transporte compartilhado, oferecendo ferramentas de monitoramento em tempo real e comunicação direta entre motorista e passageiro.

### 🚀 Funcionalidades
1. Geolocalização em Tempo Real: Localização via GPS para acompanhamento preciso durante a corrida.
2. Busca Inteligente: Integração com a API Nominatim para busca de destinos via endereços.
3. Roteamento: Traçado de rotas automático utilizando o motor OSRM, exibindo caminhos otimizados no mapa.

### 📱 Interface do Aplicativo

<table align="center">
  <tr>
    <td align="center"><b>Login</b><br><img src="../rideshare/assets/login.png" width="200"></td>
    <td align="center"><b>Mapa</b><br><img src="../rideshare/assets/mapa.png" width="200"></td>
    <td align="center"><b>Chat</b><br><img src="../rideshare/assets/chat.png" width="200"></td>
  </tr>
  <tr>
    <td align="center"><b>Perfil Motorista</b><br><img src="../rideshare/assets/motorista.png" width="200"></td>
    <td align="center"><b>Perfil Usuário</b><br><img src="../rideshare/assets/perfil.png" width="200"></td>
    <td align="center">---</td>
  </tr>
</table>

### 🛠️ Tecnologias Utilizadas
- *Flutter & Dart*: Desenvolvimento de interface multiplataforma.
- *OpenStreetMap* (Flutter Map): Base cartográfica gratuita e colaborativa.
- *Nominatim API*: Geocodificação para transformar endereços em coordenadas.
- *OSRM* (Open Source Routing Machine): Cálculo de rotas e direções.
- *Geolocator*: Gerenciamento de permissões e captura de posição global.

### 📂 Estrutura do Projeto
O código está organizado de forma modular para facilitar a manutenção:

``main.dart:`` Gerenciamento de login e fluxos de entrada.

``map_screen.dart:`` Tela principal com mapa, busca e lógica de roteamento.

``chat_screen.dart:`` Interface de mensagens com detalhes do motorista.

``profile_screen.dart:`` Perfil do usuário (Ex: Antonio B Souza).

``driver_profile_screen.dart:`` Detalhes do motorista (Ex: Ricardo Carmo).