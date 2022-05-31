import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/tab_state.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/pages/main_page/widgets/sidebar/add_menu.dart';
import 'package:lucidum_legalis/pages/main_page/widgets/sidebar/sidebar_controller.dart';
import 'sidebar_bottom_navigation.dart';
import 'sidebar_tab.dart';

class Siderbar extends StatefulWidget {
  const Siderbar({Key? key}) : super(key: key);

  @override
  State<Siderbar> createState() => _SiderbarState();
}

enum Tabs { clients, lawsuites }

class _SiderbarState extends State<Siderbar> with TickerProviderStateMixin {
  final controller = SidebarController();
  late final Stream<List<Client>> _clientsStream;
  late final Stream<List<Lawsuite>> _lawsuitesStream;
  late final _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200));

  var _isAddMenuOpen = false;
  var _selectedTab = Tabs.clients;

  @override
  void initState() {
    // Creates the data stream for clients and lawsuites
    _clientsStream = userDatabase.clientDao.watchAllClients();
    _lawsuitesStream = userDatabase.lawsuiteDao.watchAllLawsuites();

    api.tabHistory.addListener(() {
      if (api.tabHistory.isEmpty) {
        return;
      }

      if (api.tabHistory.last is TabState<Client>) {
        _showClients();
      } else if (api.tabHistory.last is TabState<Lawsuite>) {
        _showLawsuites();
      }
    });

    super.initState();
  }

  void _showClients() {
    if (_selectedTab != Tabs.clients) {
      setState(() => _selectedTab = Tabs.clients);
      controller.showClients();
    }
    _closeAddMenu();
  }

  void _showLawsuites() {
    if (_selectedTab != Tabs.lawsuites) {
      setState(() => _selectedTab = Tabs.lawsuites);
      controller.showLawsuites();
    }
    _closeAddMenu();
  }

  Future<void> _addClient() async {
    final id = await api.createClient();
    await api.openClient(id: id, editMode: true);
    _closeAddMenu();
  }

  Future<void> _addLawsuite() async {
    final id = await api.createLawsuite();
    api.openLawsuit(id: id, editMode: true);
    _closeAddMenu();
  }

  void _clientSelected(int id) async {
    await api.openClient(id: id);
  }

  void _lawsuiteSelected(int id) async {
    await api.openLawsuit(id: id);
  }

  void _closeAddMenu() {
    if (_isAddMenuOpen) {
      setState(() => _isAddMenuOpen = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isAddMenuOpen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _isAddMenuOpen = !_isAddMenuOpen),
        child: RotationTransition(
          turns: Tween<double>(begin: 0, end: 45 / 360).animate(_controller),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SidebarBottomNavigation(
        controller: controller,
        onClientsPressed: _showClients,
        onLawsuitesPressed: _showLawsuites,
        bottomMenu: AddMenu(
          duration: _controller.duration!,
          vsync: this,
          opened: _isAddMenuOpen,
          onAddClient: _addClient,
          onAddLawsuite: _addLawsuite,
        ),
      ),
      // Sidebar tabs
      body: Scrollbar(
        thumbVisibility: true,
        child: SidebarTab(
          dataStream:
              _selectedTab == Tabs.clients ? _clientsStream : _lawsuitesStream,
          onClientPressed: _clientSelected,
          onLawsuitePressed: _lawsuiteSelected,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
