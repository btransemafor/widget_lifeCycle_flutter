// ignore_for_file: no_logic_in_create_state, avoid_print

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LifecycleDemo(),
    );
  }
}

class LifecycleDemo extends StatefulWidget {
  const LifecycleDemo({super.key});

  @override
  State<LifecycleDemo> createState() {
    print("createState() called");
    return _LifecycleDemoState();
  }
}

class _LifecycleDemoState extends State<LifecycleDemo> {
  @override
  void initState() {
    super.initState();

     print("initState() called");
   /* try {
      final size = MediaQuery.of(context).size;
      print('MediaQuery work: $size');
    } catch (e) {
      print('MediaQuery failed: $e');
    }  */

    // Workaround
       WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          final size = MediaQuery.of(context).size;
          print('MediaQuery in callback: $size');
        }
      }); 
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies() called");
    print("didChangeDependencies: thử lấy MediaQuery");
    print(MediaQuery.of(context).size);
  }
  @override
  Widget build(BuildContext context) {
    print("build() called");
    return Scaffold(
      appBar: AppBar(title: const Text("Lifecycle Demo")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              print("setState() called → will trigger build()");
            });
          },
          child: const Text("Press me"),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant LifecycleDemo oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget() called");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate() called");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose() called");
  }
}
