import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:textil_investigation/config/routes.dart';
import 'package:textil_investigation/injection.dart';
import 'package:textil_investigation/presentations/blocs/campos/campos_bloc.dart';
import 'package:textil_investigation/presentations/blocs/index_bloc.dart';
import 'package:textil_investigation/presentations/blocs/telas/telas_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<IndexBloc>()),
        BlocProvider(create: (context) => sl<TelasBloc>()),
        BlocProvider(create: (context) => sl<CamposBloc>())
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Textil Investigation',
        theme: ThemeData(primarySwatch: Colors.blue),
      ),
    );
  }
}
