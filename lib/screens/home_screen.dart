import 'package:flutter/material.dart';
import 'package:loja_virtual_nova/tabs/home_tabs.dart';
import 'package:loja_virtual_nova/tabs/orders_tab.dart';
import 'package:loja_virtual_nova/tabs/products_tab.dart';
import 'package:loja_virtual_nova/widgets/cart_button.dart';

import '../widgets/customDrawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          floatingActionButton: CartButton(),
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
        ),
        Scaffold(),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}
