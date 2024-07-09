import 'package:flutter/material.dart';
import 'services/connectivity_service.dart';
import 'services/battery_service.dart';
import 'services/theme_service.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ConnectivityService _connectivityService = ConnectivityService();
  final BatteryService _batteryService = BatteryService();
  final ThemeService _themeService = ThemeService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThemeMode>(
      future: _themeService.getThemeMode(),
      builder: (context, snapshot) {
        ThemeMode themeMode = snapshot.data ?? ThemeMode.system;
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeMode,
          home: MyHomePage(
            connectivityService: _connectivityService,
            batteryService: _batteryService,
            themeService: _themeService,
            authService: _authService,
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final ConnectivityService connectivityService;
  final BatteryService batteryService;
  final ThemeService themeService;
  final AuthService authService;

  const MyHomePage({
    Key? key,
    required this.connectivityService,
    required this.batteryService,
    required this.themeService,
    required this.authService,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    widget.connectivityService.initialize(context);
    widget.batteryService.initialize(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Connectivity and Auth App'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () async {
              ThemeMode currentMode = await widget.themeService.getThemeMode();
              ThemeMode newMode = currentMode == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
              await widget.themeService.setThemeMode(newMode);
              setState(() {});
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
