import 'package:flutter/material.dart';
import 'package:shoppingcart/item.dart';

class CartItem extends StatefulWidget {
  final Item items;
  final VoidCallback
      onAddToCart; // เพิ่ม callback สำหรับการเพิ่มสินค้าลงในตะกร้า

  CartItem({
    super.key,
    required this.items,
    required this.onAddToCart, // กำหนดให้ onAddToCart เป็น required
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.items.amount;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.items.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Price: ${widget.items.price}',
              style: Theme.of(context).textTheme.labelSmall,
            )
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (quantity > 0) {
                    quantity--;
                  }
                });
                print('Quantity decreased: $quantity');
              },
            ),
            Text(
              '$quantity',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  quantity++;
                });
                print('Quantity increased: $quantity');
                widget.onAddToCart(); // เรียก callback เมื่อเพิ่มสินค้า
              },
            ),
          ],
        ),
      ],
    );
  }
}
