import 'package:flutter/material.dart';
import '../model/prato_culinario.dart';
import '../service/prato_culinario_service.dart';
import 'package:Kilumbu/const/appbar.dart';

class PratosPage extends StatefulWidget {
  const PratosPage({Key? key}) : super(key: key);

  @override
  _PratosPageState createState() => _PratosPageState();
}

class _PratosPageState extends State<PratosPage> {
  final PratoCulinarioService _pratoService = PratoCulinarioService();
  late Future<List<PratoCulinario>> _pratosFuture;
  final TextEditingController _searchController = TextEditingController();
  String _selectedRegion = 'Todas';
  final List<String> _regioes = ['Todas', 'Norte', 'Sul', 'Leste', 'Oeste', 'Centro'];

  @override
  void initState() {
    super.initState();
    _loadPratos();
  }

  void _loadPratos({String? regiao}) {
    setState(() {
      if (regiao == null || regiao == 'Todas') {
        _pratosFuture = _pratoService.getAllPratos();
      } else {
        _pratosFuture = _pratoService.getPratosByRegiao(regiao);
      }
    });
  }

  void _searchPratos(String query) {
    if (query.isEmpty) {
      _loadPratos(regiao: _selectedRegion);
      return;
    }
    
    setState(() {
      _pratosFuture = _pratoService.searchPratos(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'Pratos Culinários',
        actionIcon: Icons.restaurant,
        onActionPressed: null,
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
                    hintText: 'Pesquisar pratos...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  onChanged: _searchPratos,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _regioes.length,
                    itemBuilder: (context, index) {
                      final regiao = _regioes[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(regiao),
                          selected: _selectedRegion == regiao,
                          onSelected: (selected) {
                            setState(() {
                              _selectedRegion = selected ? regiao : 'Todas';
                              _loadPratos(regiao: _selectedRegion);
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
            child: FutureBuilder<List<PratoCulinario>>(
              future: _pratosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhum prato encontrado'));
                }

                final pratos = snapshot.data!;
                return ListView.builder(
                  itemCount: pratos.length,
                  itemBuilder: (context, index) {
                    final prato = pratos[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: ListTile(
                        leading: prato.imageUrl.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  prato.imageUrl,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => 
                                      const Icon(Icons.fastfood, size: 40),
                                ),
                              )
                            : const Icon(Icons.fastfood, size: 40),
                        title: Text(
                          prato.nome,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${prato.tempoPreparo} min • ${prato.dificuldade}'),
                            if (prato.regiao.isNotEmpty) Text('Região: ${prato.regiao}'),
                            Wrap(
                              spacing: 4,
                              children: prato.tags.take(3).map((tag) => Chip(
                                label: Text(tag),
                                backgroundColor: Colors.green[50],
                                labelStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green[800],
                                ),
                              )).toList(),
                            ),
                          ],
                        ),
                        onTap: () {
                          // Navigate to detail page
                          // Navigator.push(context, MaterialPageRoute(
                          //   builder: (context) => PratoDetailPage(prato: prato),
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
        onPressed: () {
          // Navigate to add prato form
          // Navigator.push(context, MaterialPageRoute(
          //   builder: (context) => const AddPratoPage(),
          // )).then((_) => _loadPratos());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
