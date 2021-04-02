import 'package:lucidum_legalis/constants/app_icons.dart';
import 'package:lucidum_legalis/database/database.dart';
import 'package:lucidum_legalis/models/app_model.dart';
import 'package:lucidum_legalis/models/tab_controller_model.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/widgets/components/add_button.dart';
import 'package:moor/moor.dart' as moor;
import 'package:provider/provider.dart';

enum _DrawerTabs { Clients, Files }

class MainPageDrawer extends StatefulWidget {
  @override
  _MainPageDrawerState createState() => _MainPageDrawerState();
}

class _MainPageDrawerState extends State<MainPageDrawer> {
  final double _addPanelCloseHeight = 0;
  final double _addPanelOpenHeight = 100;
  final Duration _animationDuration = const Duration(milliseconds: 250);

  _DrawerTabs _currentTab = _DrawerTabs.Clients;
  double _addPanelHeight;
  AppDatabase _database;
  List<Client> _clients;

  @override
  void initState() {
    super.initState();
    _addPanelHeight = _addPanelCloseHeight;
    _loadData();
  }

  void _loadData() async {
    _database = context.read<AppModel>().database;
    _database.clientDao.watchAllClients().listen((clients) {
      setState(() => _clients = clients);
    });
  }

  void _viewClients() {
    setState(() => _currentTab = _DrawerTabs.Clients);
  }

  void _viewFiles() {
    setState(() => _currentTab = _DrawerTabs.Files);
  }

  Widget _getClientsTab() {
    final tabModel = context.read<TabControllerModel>();

    if (_clients == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ListView.separated(
        itemCount: _clients.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(AppIcons.CLIENT),
            title: Text(_clients[index].name),
            onTap: () => tabModel.openClient(_clients[index].id),
          );
        },
      );
    }
  }

  Widget _getFilesTab() {
    return Center(child: Text('Files!'));
  }

  void _onAddButtonStateChanged(bool opened) {
    setState(() {
      _addPanelHeight = opened ? _addPanelOpenHeight : _addPanelCloseHeight;
    });
  }

  void _addClient() {
    final tabModel = context.read<TabControllerModel>();
    _database.clientDao
        .createClient(ClientsCompanion(name: moor.Value('Filipe')));
    tabModel.openNewClient();
  }

  void _addFile() {
    final tabModel = context.read<TabControllerModel>();
    tabModel.openNewFile();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Scaffold(
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: _AddFab(
          animationDuration: _animationDuration,
          onOpen: () => _onAddButtonStateChanged(true),
          onClose: () => _onAddButtonStateChanged(false),
        ),
        bottomNavigationBar: _DrawerBottomAppBar(
          height: _addPanelHeight,
          animationDuration: _animationDuration,
          onClientViewSelected: _viewClients,
          onFileViewSelected: _viewFiles,
          child: Column(
            children: [
              AddButton(
                label: 'Add new client',
                icon: AppIcons.CLIENT_ADD,
                onPressed: _addClient,
              ),
              AddButton(
                label: 'Add new file',
                icon: AppIcons.FILE_ADD,
                onPressed: _addFile,
              ),
            ],
          ),
        ),
        body: _currentTab == _DrawerTabs.Clients
            ? _getClientsTab()
            : _getFilesTab(),
      ),
    );
  }
}

class _AddFab extends StatefulWidget {
  const _AddFab({
    this.onOpen,
    this.onClose,
    this.animationDuration,
    Key key,
  }) : super(key: key);

  final Duration animationDuration;
  final Function onOpen;
  final Function onClose;

  @override
  _AddFabState createState() => _AddFabState();
}

class _AddFabState extends State<_AddFab> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    super.initState();
  }

  void _onButtonPressed() {
    if (_controller.isCompleted) {
      _controller.reverse();
      if (widget.onClose != null) {
        widget.onClose();
      }
    } else {
      _controller.forward();
      if (widget.onOpen != null) {
        widget.onOpen();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _onButtonPressed,
      tooltip: 'Add new...',
      elevation: 2.0,
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: (0.125 + 0.25)).animate(_controller),
        child: Icon(Icons.add),
      ),
    );
  }
}

class _DrawerBottomAppBar extends StatelessWidget {
  const _DrawerBottomAppBar({
    Key key,
    @required this.animationDuration,
    @required this.height,
    this.child,
    this.onClientViewSelected,
    this.onFileViewSelected,
  }) : super(key: key);

  final double height;
  final Duration animationDuration;
  final Function onClientViewSelected;
  final Function onFileViewSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: onClientViewSelected,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Clients  '),
                      Icon(AppIcons.CLIENT),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: onFileViewSelected,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(AppIcons.FILE),
                      Text('  Files'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 36,
              ),
            ],
          ),
          AnimatedContainer(
              height: height,
              duration: animationDuration,
              curve: Curves.decelerate,
              child: child)
        ],
      ),
    );
  }
}
