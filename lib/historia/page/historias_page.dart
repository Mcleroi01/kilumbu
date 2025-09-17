import 'package:flutter/material.dart';
import '../model/historia.dart';
import '../service/historia_service.dart';
import 'package:Kilumbu/const/appbar.dart';

class HistoriasPage extends StatefulWidget {
  const HistoriasPage({super.key});

  @override
  _HistoriasPageState createState() => _HistoriasPageState();
}

class _HistoriasPageState extends State<HistoriasPage> {
  final HistoriaService _historiaService = HistoriaService();
  late Future<List<Historia>> _historiasFuture;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadHistorias();
  }

  void _loadHistorias() {
    setState(() {
      _historiasFuture = _historiaService.getAllHistorias();
    });
  }

  void _searchHistorias(String query) {
    if (query.isEmpty) {
      _loadHistorias();
      return;
    }
    
    setState(() {
      _historiasFuture = _historiaService.searchHistorias(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'Histórias',
        actionIcon: Icons.history,
        onActionPressed: null,
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar histórias...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
              onChanged: _searchHistorias,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Historia>>(
              future: _historiasFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhuma história encontrada'));
                }

                final historias = snapshot.data!;
                return ListView.builder(
                  itemCount: historias.length,
                  itemBuilder: (context, index) {
                    final historia = historias[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: ListTile(
                        leading: historia.imageUrl.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  historia.imageUrl,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => 
                                      const Icon(Icons.history, size: 40),
                                ),
                              )
                            : const Icon(Icons.history, size: 40),
                        title: Text(
                          historia.titulo,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(historia.periodoHistorico),
                            if (historia.subtitulo != null) Text(historia.subtitulo!),
                            Wrap(
                              spacing: 4,
                              children: historia.tags.take(3).map((tag) => Chip(
                                label: Text(tag),
                                backgroundColor: Colors.grey[200],
                                labelStyle: const TextStyle(fontSize: 12),
                              )).toList(),
                            ),
                          ],
                        ),
                        onTap: () {
                          // Navigate to detail page
                          // Navigator.push(context, MaterialPageRoute(
                          //   builder: (context) => HistoriaDetailPage(historia: historia),
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
          // Navigate to add historia form
          // Navigator.push(context, MaterialPageRoute(
          //   builder: (context) => const AddHistoriaPage(),
          // )).then((_) => _loadHistorias());
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
