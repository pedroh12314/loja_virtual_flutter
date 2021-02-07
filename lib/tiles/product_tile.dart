import 'package:flutter/material.dart';
import 'package:loja_virtual_nova/screens/only_product_screen.dart';
import 'package:loja_virtual_nova/services/product_service.dart';

class ProductTile extends StatelessWidget {
  const ProductTile(this.type, this.data, {Key key}) : super(key: key);

  final String type;
  final ProductService data;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (contex) => OnlyProductScreen(data)));
      },
      child: Card(
        child: (type == "grid")
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: Image.network(
                      data.images[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            data.titleProduct,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "R\$ ${data.price.toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            : Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.network(
                      data.images[0],
                      fit: BoxFit.cover,
                      height: 250,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.titleProduct,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0),
                              ),
                              Text(
                                "R\$ ${data.price.toStringAsFixed(2)}",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )),
                  )
                ],
              ),
      ),
    );
  }
}
