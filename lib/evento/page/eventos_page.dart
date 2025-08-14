import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../const/appbar.dart';
import '../model/evento.dart';
import '../service/evento_service.dart';

class EventosPage extends StatefulWidget {
  const EventosPage({Key? key}) : super(key: key);

  @override
  _EventosPageState createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> with SingleTickerProviderStateMixin {
  final EventoService _eventoService = EventoService();
  late Future<List<Evento>> _eventosFuture;
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  
  // Calendar state
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Evento>> _events = {};
  List<Evento> _selectedEvents = [];
  
  // Filter state
  final List<String> _tipos = [
    'Todos',
    'cultural',
    'esportivo',
    'musical',
    'gastronomico',
    'religioso',
    'outro'
  ];
  String _selectedTipo = 'Todos';
  bool _showCalendar = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadEventos();
  }

  void _loadEventos() async {
    setState(() {
      switch (_tabController.index) {
        case 0: // Hoje
          _eventosFuture = _eventoService.getEventosHoje();
          break;
        case 1: // Próximos
          _eventosFuture = _eventoService.getProximosEventos();
          break;
        case 2: // Por tipo
          _eventosFuture = _selectedTipo == 'Todos' 
              ? _eventoService.getEventosAtivos()
              : _eventoService.getEventosPorTipo(_selectedTipo);
          break;
        case 3: // Calendário
          _eventosFuture = _eventoService.getEventosAtivos();
          break;
        default:
          _eventosFuture = _eventoService.getEventosAtivos();
      }
    });

    // Load events for calendar
    if (_tabController.index == 3) {
      final eventos = await _eventoService.getEventosAtivos();
      final eventsMap = <DateTime, List<Evento>>{};
      
      for (var evento in eventos) {
        final date = DateTime(
          evento.dataInicio.year,
          evento.dataInicio.month,
          evento.dataInicio.day,
        );
        
        if (eventsMap[date] == null) {
          eventsMap[date] = [];
        }
        eventsMap[date]!.add(evento);
        
        // If it's a multi-day event, add it to all days in the range
        if (evento.dataFim != null) {
          var currentDate = DateTime(
            evento.dataInicio.year,
            evento.dataInicio.month,
            evento.dataInicio.day + 1,
          );
          
          final endDate = DateTime(
            evento.dataFim!.year,
            evento.dataFim!.month,
            evento.dataFim!.day,
          );
          
          while (!currentDate.isAfter(endDate)) {
            if (eventsMap[currentDate] == null) {
              eventsMap[currentDate] = [];
            }
            eventsMap[currentDate]!.add(evento);
            currentDate = currentDate.add(const Duration(days: 1));
          }
        }
      }
      
      setState(() {
        _events = eventsMap;
        _selectedEvents = _events[_selectedDay ?? _focusedDay] ?? [];
      });
    }
  }

  void _searchEventos(String query) {
    if (query.isEmpty) {
      _loadEventos();
      return;
    }
    
    setState(() {
      _eventosFuture = _eventoService.searchEventos(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'Eventos',
        actionIcon: _showCalendar ? Icons.list : Icons.calendar_today,
        onActionPressed: _tabController.index == 3 
            ? () => setState(() => _showCalendar = !_showCalendar)
            : null,
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar eventos...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _loadEventos();
                        },
                      )
                    : null,
              ),
              onChanged: _searchEventos,
              onSubmitted: (_) => _searchEventos(_searchController.text),
            ),
          ),
          TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Theme.of(context).primaryColor,
            onTap: (index) {
              setState(() {
                _showCalendar = index == 3 && _showCalendar;
              });
              _loadEventos();
            },
            tabs: const [
              Tab(text: 'Hoje'),
              Tab(text: 'Próximos'),
              Tab(text: 'Por Tipo'),
              Tab(text: 'Calendário'),
            ],
          ),
          if (_tabController.index == 2) // Filter by type
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _tipos.length,
                  itemBuilder: (context, index) {
                    final tipo = _tipos[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        label: Text(
                          tipo == 'Todos' ? 'Todos' : Evento(titulo: '', descricao: '', tipo: tipo, local: LocalEvento(nome: '', endereco: ''), dataInicio: DateTime.now()).tipoFormatado,
                          style: const TextStyle(fontSize: 12),
                        ),
                        selected: _selectedTipo == tipo,
                        onSelected: (selected) {
                          setState(() {
                            _selectedTipo = selected ? tipo : 'Todos';
                            _loadEventos();
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          if (_tabController.index == 3 && _showCalendar) // Calendar view
            Card(
              margin: const EdgeInsets.all(8.0),
              child: TableCalendar<Evento>(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _selectedEvents = _events[selectedDay] ?? [];
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                eventLoader: (day) {
                  return _events[day] ?? [];
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (events.isEmpty) return null;
                    return Positioned(
                      right: 1,
                      bottom: 1,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${events.length}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildEventosList(), // Hoje
                _buildEventosList(), // Próximos
                _buildEventosList(), // Por Tipo
                _buildCalendarEventsList(), // Calendário
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add event form
          // Navigator.push(context, MaterialPageRoute(
          //   builder: (context) => const AddEventoPage(),
          // )).then((_) => _loadEventos());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEventosList() {
    return FutureBuilder<List<Evento>>(
      future: _eventosFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum evento encontrado'));
        }

        final eventos = snapshot.data!;
        
        return ListView.builder(
          itemCount: eventos.length,
          itemBuilder: (context, index) {
            final evento = eventos[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListTile(
                contentPadding: const EdgeInsets.all(8),
                leading: evento.imageUrl?.isNotEmpty == true
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          evento.imageUrl!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => 
                              const Icon(Icons.event, size: 40),
                        ),
                      )
                    : Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[200],
                        child: const Icon(Icons.event, size: 40),
                      ),
                title: Text(
                  evento.titulo,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('dd/MM/yyyy').format(evento.dataInicio),
                          style: const TextStyle(fontSize: 12),
                        ),
                        if (evento.horarioInicio != null) ...[
                          const SizedBox(width: 8),
                          const Icon(Icons.access_time, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            '${evento.horarioInicio!.hour.toString().padLeft(2, '0')}:${evento.horarioInicio!.minute.toString().padLeft(2, '0')}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            evento.local.nome,
                            style: const TextStyle(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Chip(
                          label: Text(
                            evento.tipoFormatado,
                            style: const TextStyle(fontSize: 10),
                          ),
                          backgroundColor: Colors.blue[50],
                          padding: EdgeInsets.zero,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        const SizedBox(width: 4),
                        if (evento.isFree)
                          const Chip(
                            label: Text(
                              'Grátis',
                              style: TextStyle(fontSize: 10, color: Colors.green),
                            ),
                            backgroundColor: Color(0xFFE8F5E9),
                            padding: EdgeInsets.zero,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          )
                        else if (evento.ingressos.isNotEmpty)
                          Chip(
                            label: Text(
                              'A partir de R\${{...evento.ingressos.map((e) => e.preco)}.reduce((a, b) => a < b ? a : b).toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 10),
                            ),
                            backgroundColor: Colors.orange[50],
                            padding: EdgeInsets.zero,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  // Navigate to event detail
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) => EventoDetailPage(evento: evento),
                  // ));
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCalendarEventsList() {
    if (_selectedEvents.isEmpty) {
      return const Center(child: Text('Nenhum evento selecionado'));
    }

    return ListView.builder(
      itemCount: _selectedEvents.length,
      itemBuilder: (context, index) {
        final evento = _selectedEvents[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            title: Text(evento.titulo),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(evento.local.nome),
                if (evento.horarioInicio != null)
                  Text(
                    '${evento.horarioInicio!.hour}:${evento.horarioInicio!.minute.toString().padLeft(2, '0')}${evento.horarioFim != null ? ' - ${evento.horarioFim!.hour}:${evento.horarioFim!.minute.toString().padLeft(2, '0')}' : ''}',
                  ),
                if (evento.isFree)
                  const Chip(
                    label: Text('Grátis'),
                    backgroundColor: Colors.green,
                    labelStyle: TextStyle(color: Colors.white),
                  )
                else if (evento.ingressos.isNotEmpty)
                  Chip(
                    label: Text(
                      'A partir de R\${{...evento.ingressos.map((e) => e.preco)}.reduce((a, b) => a < b ? a : b).toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: Colors.orange[100],
                  ),
              ],
            ),
            onTap: () {
              // Navigate to event detail
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) => EventoDetailPage(evento: evento),
              // ));
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }
}
