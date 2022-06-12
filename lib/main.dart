import 'package:flutter/material.dart';
import 'package:flutter_metamask/provider/metamask.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MetaMaskProvider()..init()),
      ],
      child: MaterialApp(
        title: 'Flutter Metamask',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 55.0,
          width: 250.0,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: MaterialButton(
            child: Consumer<MetaMaskProvider>(
              builder: (context, meta, child) {
                String text = '';
                if (meta.isConnected && meta.isInOperatingChain) {
                  text = 'Metamask connected';
                } else if (meta.isConnected && !meta.isInOperatingChain) {
                  text = 'Wrong operating chain';
                } else if (meta.isEnabled) {
                  return const Text(
                    'Connect Metamask',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  text = 'Unsupported Browser';
                }

                return Text(
                  text,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            onPressed: () {
              final meta = context.read<MetaMaskProvider>();
              meta.connect();
            },
          ),
        ),
      ),
    );
  }
}
