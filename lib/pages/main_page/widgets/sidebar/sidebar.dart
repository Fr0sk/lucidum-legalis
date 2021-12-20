import 'package:flutter/material.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/utils/api.dart';
import 'package:lucidum_legalis/pages/main_page/widgets/sidebar/add_menu.dart';
import 'sidebar_bottom_navigation.dart';
import 'sidebar_tab.dart';

class Siderbar extends StatefulWidget {
  const Siderbar({Key? key}) : super(key: key);

  @override
  _SiderbarState createState() => _SiderbarState();
}

enum Tabs { clients, lawsuites }

class _SiderbarState extends State<Siderbar> with TickerProviderStateMixin {
  late final Api _api;
  late final UserDatabase _db;
  late final Stream<List<Client>> _clientsStream;
  late final Stream<List<Lawsuite>> _lawsuitesStream;
  late final _controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 200));

  var _isAddMenuOpen = false;
  var _selectedTab = Tabs.clients;

  @override
  void initState() {
    _api = api;
    _db = _api.database;

    // Creates the data stream for clients and lawsuites
    _clientsStream = _db.clientDao.watchAllClients();
    _lawsuitesStream = _db.lawsuiteDao.watchAllLawsuites();

    super.initState();
  }

  void _showClients() {
    setState(() => _selectedTab = Tabs.clients);
    _closeAddMenu();
  }

  void _showLawsuites() {
    setState(() => _selectedTab = Tabs.lawsuites);
    _closeAddMenu();
  }

  Future<void> _addClient() async {
    final id = await _api.createClient();
    final result = await _api.openClient(id: id);
    _closeAddMenu();
  }

  void _addLawsuite() {
    _api.createLawsuite();
    _closeAddMenu();
  }

  void _clientSelected(int id) async {
    var result = await _api.openClient(id: id);
    /*if (result == OpenTabBodyResult.UNSAVED_CHANGES) {
      // TODO show dialog asking to save changes
      print('TODO show dialog asking to save changes');
    }*/
  }

  void _lawsuiteSelected(int id) async {
    var result = await _api.openLawsuite(id: id);
    /*if (result == OpenTabBodyResult.UNSAVED_CHANGES) {
      // TODO show dialog asking to save changes
      print('TODO show dialog asking to save changes');
    }*/
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
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SidebarBottomNavigation(
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
        isAlwaysShown: true,
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
