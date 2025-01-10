import 'package:flutter/material.dart';

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

class Item {
  final String name;
  final double price;
  final IconData icon; // เพิ่มฟิลด์สำหรับเก็บไอคอน
  int quantity;

  Item(
      {required this.name,
      required this.price,
      required this.icon,
      this.quantity = 0});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Item> items = <Item>[
    Item(name: 'iPhone 15', price: 45000, icon: Icons.phone_iphone),
    Item(name: 'MacBook Pro', price: 32500, icon: Icons.laptop_mac),
    Item(name: 'iPad Pro', price: 35000, icon: Icons.tablet),
  ];

  double total = 0;

  void resetCart() {
    setState(() {
      total = 0;
      for (var item in items) {
        item.quantity = 0; // รีเซ็ตจำนวนสินค้าในตะกร้า
      }
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
                  onPressed: resetCart,
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
                    item.quantity += 1; // เพิ่มจำนวนสินค้า
                    total += item.price;
                  });
                },
              ),
            const Spacer(),
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

class CartItem extends StatelessWidget {
  final Item items;
  final VoidCallback onAddToCart;

  const CartItem({super.key, required this.items, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(items.icon, size: 40), // เพิ่มไอคอนสำหรับสินค้า
      title: Text(items.name),
      subtitle: Text('Price: ${items.price} ฿'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('x${items.quantity}'), // แสดงจำนวนสินค้า
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: onAddToCart,
          ),
        ],
      ),
    );
  }
}
