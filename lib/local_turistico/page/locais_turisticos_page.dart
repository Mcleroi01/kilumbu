import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../const/appbar.dart';
import '../model/local_turistico.dart';
import '../service/local_turistico_service.dart';

class LocaisTuristicosPage extends StatefulWidget {
  const LocaisTuristicosPage({Key? key}) : super(key: key);

  @override
  _LocaisTuristicosPageState createState() => _LocaisTuristicosPageState();
}

class _LocaisTuristicosPageState extends State<LocaisTuristicosPage> {
  final LocalTuristicoService _localService = LocalTuristicoService();
  late Future<List<LocalTuristico>> _locaisFuture;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _tipos = [
    'Todos',
    'historico',
    'natural',
    'cultural',
    'religioso',
    'gastronomico',
    'outro'
  ];
  String _selectedTipo = 'Todos';
  bool _isLoadingLocation = false;
  Position? _currentPosition;
  bool _showMap = false;
  Set<Marker> _markers = {};
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _loadLocais();
    _getCurrentLocation();
  }

  void _loadLocais({String? tipo}) async {
    setState(() {
      if (tipo == null || tipo == 'Todos') {
        _locaisFuture = _localService.getAllLocais();
      } else {
        _locaisFuture = _localService.getLocaisByType(tipo);
      }
    });
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw 'Os serviços de localização estão desativados.';
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Permissão de localização negada';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw 'Permissão de localização permanentemente negada';
      }

      _currentPosition = await Geolocator.getCurrentPosition();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao obter localização: $e')),
      );
    } finally {
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  void _searchLocais(String query) {
    if (query.isEmpty) {
      _loadLocais(tipo: _selectedTipo);
      return;
    }

    setState(() {
      _locaisFuture = _localService.searchLocais(query);
    });
  }

  void _toggleView() {
    setState(() {
      _showMap = !_showMap;
    });
  }

  Future<void> _updateMarkers(List<LocalTuristico> locais) async {
    if (_mapController == null) return;

    final markers = <Marker>{};

    for (final local in locais) {
      if (local.endereco.coordenadas.latitude == 0 ||
          local.endereco.coordenadas.longitude == 0) continue;

      final markerId = MarkerId(local.id ?? '');

      markers.add(
        Marker(
          markerId: markerId,
          position: LatLng(
            local.endereco.coordenadas.latitude,
            local.endereco.coordenadas.longitude,
          ),
          infoWindow: InfoWindow(
            title: local.nome,
            snippet: local.tipoFormatado,
          ),
          icon: await _getMarkerIcon(local.tipo),
        ),
      );
    }

    setState(() {
      _markers = markers;
    });
  }

  Future<BitmapDescriptor> _getMarkerIcon(String tipo) async {
    // Default marker color
    Color color;

    switch (tipo) {
      case 'historico':
        color = Colors.brown;
        break;
      case 'natural':
        color = Colors.green;
        break;
      case 'cultural':
        color = Colors.blue;
        break;
      case 'religioso':
        color = Colors.purple;
        break;
      case 'gastronomico':
        color = Colors.orange;
        break;
      default:
        color = Colors.grey;
    }

    return BitmapDescriptor.defaultMarkerWithHue(
      HSLColor.fromColor(color).hue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'Locais Turísticos',
        actionIcon: _showMap ? Icons.list : Icons.map,
        onActionPressed: _toggleView,
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Pesquisar locais...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  onChanged: _searchLocais,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _tipos.length,
                    itemBuilder: (context, index) {
                      final tipo = _tipos[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(
                            tipo == 'Todos'
                                ? 'Todos'
                                : LocalTuristico(
                                        nome: 'nome',
                                        tipo: 'tipo',
                                        descricao: 'descricao',
                                        endereco: Endereco(
                                            rua: 'rua',
                                            coordenadas: Coordenadas(
                                                latitude: 0, longitude: 0),
                                            cidade: 'cidade',
                                            estado: 'estado',
                                            pais: 'pais',
                                            provincia: ''),
                                        horarioFuncionamento:
                                            'horarioFuncionamento',
                                        melhoresEpocas: ['melhoresEpocas'],
                                        comoChegar: 'comoChegar',
                                        contato: Contato(),
                                        precoIngresso: 0,
                                        avaliacaoMedia: 0,
                                        createdAt: DateTime.now(),
                                        updatedAt: DateTime.now(),
                                        imageUrl: 'imageUrl',
                                        galeria: ['galeria'],
                                        dicasVisita: ['dicasVisita'],
                                        acessibilidade: true,
                                        tags: ['tags'])
                                    .tipoFormatado,
                            style: const TextStyle(fontSize: 12),
                          ),
                          selected: _selectedTipo == tipo,
                          onSelected: (selected) {
                            setState(() {
                              _selectedTipo = selected ? tipo : 'Todos';
                              _loadLocais(tipo: _selectedTipo);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<LocalTuristico>>(
              future: _locaisFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhum local encontrado'));
                }

                final locais = snapshot.data!;

                if (_showMap) {
                  _updateMarkers(locais);

                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition != null
                          ? LatLng(
                              _currentPosition!.latitude,
                              _currentPosition!.longitude,
                            )
                          : const LatLng(0, 0),
                      zoom: _currentPosition != null ? 12 : 2,
                    ),
                    markers: _markers,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: (controller) {
                      setState(() {
                        _mapController = controller;
                      });
                    },
                  );
                }

                return ListView.builder(
                  itemCount: locais.length,
                  itemBuilder: (context, index) {
                    final local = locais[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: ListTile(
                        leading: local.imageUrl.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  local.imageUrl,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.place, size: 40),
                                ),
                              )
                            : const Icon(Icons.place, size: 40),
                        title: Text(
                          local.nome,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(local.endereco.cidade),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  local.avaliacaoMedia.toStringAsFixed(1),
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(width: 8),
                                Chip(
                                  label: Text(
                                    local.tipoFormatado,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                  backgroundColor: Colors.blue[50],
                                ),
                                if (local.acessibilidade)
                                  const Padding(
                                    padding: EdgeInsets.only(left: 4.0),
                                    child: Icon(
                                      Icons.accessible,
                                      size: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        trailing: Text(
                          local.precoFormatado,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onTap: () {
                          // Navigate to detail page
                          // Navigator.push(context, MaterialPageRoute(
                          //   builder: (context) => LocalDetailPage(local: local),
                          // ));
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isLoadingLocation
            ? null
            : () {
                if (_currentPosition != null) {
                  setState(() {
                    _locaisFuture = _localService.getLocaisProximos(
                      _currentPosition!.latitude,
                      _currentPosition!.longitude,
                      10, // 10km radius
                    );
                    _showMap = true;
                  });
                } else {
                  _getCurrentLocation();
                }
              },
        child: _isLoadingLocation
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.explore),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mapController?.dispose();
    super.dispose();
  }
}
