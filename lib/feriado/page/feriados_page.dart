import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../const/appbar.dart';
import '../model/feriado.dart';
import '../service/feriado_service.dart';

class FeriadosPage extends StatefulWidget {
  const FeriadosPage({super.key});

  @override
  _FeriadosPageState createState() => _FeriadosPageState();
}

class _FeriadosPageState extends State<FeriadosPage> with SingleTickerProviderStateMixin {
  final FeriadoService _feriadoService = FeriadoService();
  late Future<List<Feriado>> _feriadosFuture;
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  final List<String> _months = [
    'Todos',
    'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
  ];
  int _selectedMonth = 0; // 0 for all months

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _months.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _loadFeriados();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _selectedMonth = _tabController.index;
        _loadFeriados(month: _selectedMonth);
      });
    }
  }

  void _loadFeriados({int? month}) async {
    setState(() {
      if (month == null || month == 0) {
        _feriadosFuture = _feriadoService.getAllFeriados();
      } else {
        _feriadosFuture = _feriadoService.getFeriadosPorMes(month);
      }
    });
  }

  void _searchFeriados(String query) {
    if (query.isEmpty) {
      _loadFeriados(month: _selectedMonth);
      return;
    }
    
    setState(() {
      _feriadosFuture = _feriadoService.searchFeriados(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'Feriados',
        actionIcon: Icons.calendar_today,
        onActionPressed: () {
          // Show upcoming holidays
          setState(() {
            _feriadosFuture = _feriadoService.getProximosFeriados();
          });
        },
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar feriados...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
              onChanged: _searchFeriados,
            ),
          ),
          SizedBox(
            height: 50,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Theme.of(context).primaryColor,
              tabs: _months.map((month) => Tab(text: month)).toList(),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Feriado>>(
              future: _feriadosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhum feriado encontrado'));
                }

                final feriados = snapshot.data!;
                return ListView.builder(
                  itemCount: feriados.length,
                  itemBuilder: (context, index) {
                    final feriado = feriados[index];
                    final date = DateTime.tryParse(feriado.data);
                    final dateStr = date != null 
                        ? DateFormat('dd/MM/yyyy').format(date)
                        : 'Data inválida';
                    
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: ListTile(
                        leading: feriado.imageUrl.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  feriado.imageUrl,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => 
                                      const Icon(Icons.calendar_today, size: 40),
                                ),
                              )
                            : const Icon(Icons.calendar_today, size: 40),
                        title: Text(
                          feriado.nome,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(dateStr),
                            if (feriado.feriadoNacional)
                              const Chip(
                                label: Text('Nacional', style: TextStyle(fontSize: 12)),
                                backgroundColor: Colors.blue,
                                labelStyle: TextStyle(color: Colors.white),
                              )
                            else if (feriado.regioesEspecificas != null)
                              Wrap(
                                spacing: 4,
                                children: feriado.regioesEspecificas!
                                    .take(2)
                                    .map((regiao) => Chip(
                                          label: Text(regiao, style: const TextStyle(fontSize: 10)),
                                          backgroundColor: Colors.green[50],
                                        ))
                                    .toList(),
                              ),
                            Text(
                              feriado.importanceStars,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        trailing: feriado.isToday
                            ? const Chip(
                                label: Text('Hoje', style: TextStyle(color: Colors.white)),
                                backgroundColor: Colors.green,
                              )
                            : null,
                        onTap: () {
                          // Navigate to detail page
                          // Navigator.push(context, MaterialPageRoute(
                          //   builder: (context) => FeriadoDetailPage(feriado: feriado),
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
          // Navigate to add feriado form
          // Navigator.push(context, MaterialPageRoute(
          //   builder: (context) => const AddFeriadoPage(),
          // )).then((_) => _loadFeriados(month: _selectedMonth));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }
}
