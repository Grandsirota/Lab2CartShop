import 'package:flutter/material.dart';
import 'package:shoppingcart/item.dart';

class CartItem extends StatefulWidget {
  final Item items;
  final VoidCallback onAddToCart;

  const CartItem({
    super.key,
    required this.items,
    required this.onAddToCart,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = 1; // กำหนดค่าเริ่มต้นของจำนวนสินค้าในตะกร้าเป็น 1
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
            ListTile(
              title: Text(widget.items.name),
              subtitle: Text('${widget.items.price} ฿'),
              trailing: IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: widget.onAddToCart, // ใช้ onAddToCart ที่ส่งมา
              ),
            ),
          ],
        ),
      ],
    );
  }
}
