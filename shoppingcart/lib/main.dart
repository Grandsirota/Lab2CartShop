import 'package:flutter/material.dart';
import 'package:shoppingcart/cartitem.dart';
import 'package:shoppingcart/item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Item> items = <Item>[
    Item(name: 'iPhone 15', price: 1500),
    Item(name: 'MacBook Pro', price: 2500),
    Item(name: 'iPad Pro', price: 10000),
  ];

  double total = 0;

  void resetCart() {
    setState(() {
      total = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Cart',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                TextButton.icon(
                  onPressed: resetCart, // เพิ่มฟังก์ชันรีเซ็ต
                  label: const Text('Clear Cart'),
                  icon: const Icon(Icons.clear),
                ),
              ],
            ),
            for (Item item in items)
              CartItem(
                items: item,
                onAddToCart: () {
                  setState(() {
                    total += item.price;
                  });
                },
              ),
            Spacer(), // ใช้ Spacer แทน Expanded เพื่อจัดการพื้นที่
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.grey[200],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total:'),
                  Text('$total ฿',
                      style: Theme.of(context).textTheme.headlineLarge),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
