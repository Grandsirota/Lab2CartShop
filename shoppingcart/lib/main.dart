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

  Map<Item, int> cartItems = {};
  int total = 0;

  void calculateTotal() {
    total = 0;
    cartItems.forEach((item, quantity) {
      total += (item.price * quantity).toInt();
    });
    setState(() {});
  }

  void resetCart() {
    cartItems.clear();
    calculateTotal();
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
            TextButton.icon(
              onPressed: resetCart,
              label: const Text('Clear Cart'),
              icon: const Icon(Icons.clear),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return CartItem(
                    items: items[index],
                    onAddToCart: () {
                      setState(() {
                        cartItems[items[index]] =
                            (cartItems[items[index]] ?? 0) + 1;
                        calculateTotal();
                      });
                    },
                  );
                },
              ),
            ),
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
