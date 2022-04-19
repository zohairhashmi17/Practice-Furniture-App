import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'products.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: buildAppBar(context),
      body: Body(product: product,),
    );
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded, size: 30, color: Colors.black,)
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, size: 30, color: Colors.black,)
        ),
        SizedBox(width: 5,),
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart_rounded, size: 30, color: Colors.black,)
        ),
      ],
    );
  }
}

class Body extends StatelessWidget {
  final Product product;
  const Body({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height,
            child: Stack(
              children: [

                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                      top: size.height * 0.13,
                      left: 20.0,
                      right: 20.0
                  ),
                  height: 500,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      )
                  ),

                  child: Column(
                    children: [
                      // ColorandSize(product: product),
                      Description(product: product),
                      SizedBox(height: 10,),
                      CartCounter(),
                      SizedBox(height: 10,),
                      AddToCart(product: product)
                    ],
                  ),
                ),
                ProductTitleWithImage(product: product),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage(
      {
        Key key,
        this.product,
      }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            style: Theme.of(context).textTheme.headline4?.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 5.0,),
          Row(
            children: [
              RichText(text:
              TextSpan(
                  children: [
                    TextSpan(
                        text: "Price\n",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                        text: "\$${product.price}",
                        style: Theme.of(
                            context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        )

                    )
                  ]
              )
              ),
              SizedBox(width: 40.0,),
              Expanded(
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/spinner.gif",
                    image: product.image,)
              )
            ],
          )
        ],
      ),
    );
  }
}



// class ColorDot extends StatelessWidget {
//   final Color color;
//   final bool isSelected;
//   const ColorDot({
//     Key key,
//     this.color,
//     this.isSelected = false
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(
//           top: 5,
//           right: 5
//       ),
//       padding: EdgeInsets.all(2.5),
//       height: 25,
//       width: 25,
//       decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(color: isSelected ? color: Colors.transparent)
//       ),
//       child: DecoratedBox(
//         decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.circle
//         ),
//       ),
//     );
//   }
// }
//
//
// class ColorandSize extends StatelessWidget {
//   final Product product;
//   const ColorandSize({
//     Key key,
//     this.product
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Color",
//                 style: TextStyle(
//                     fontSize: 17.5
//                 ),
//               ),
//               Row(
//                 children: [
//                   ColorDot(
//                     color: product.color,
//                     isSelected: true,),
//                   ColorDot(color: Colors.orangeAccent),
//                   ColorDot(color: Colors.lightGreenAccent)
//                 ],
//               )
//
//             ],
//           ),
//         ),
//         Expanded(
//           child: RichText(
//               text: TextSpan(
//                   style: TextStyle(
//                       color: Colors.black
//                   ),
//                   children: [
//                     TextSpan(text: "Size\n"),
//                     TextSpan(text: "${
//                         product.size
//                     } cm",
//                         style: Theme.of(context).textTheme.headline4?.copyWith(
//                             fontWeight: FontWeight.bold
//                         )),
//                   ]
//               )),
//         )
//       ],
//     );
//   }
// }


class Description extends StatelessWidget {
  final Product product;
  const Description({
    Key key,
    this.product
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Text(product.description,
        style: TextStyle(
            height: 1.5
        ),),
    );
  }
}


class CartCounter extends StatefulWidget {
  const CartCounter({Key key}) : super(key: key);

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {

  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildOutlineButton(icon: Icons.remove, press: () {
          if (numOfItems > 1) {
            setState(() {
              numOfItems--;
            });
          }
        }),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            numOfItems.toString().padLeft(2,"0"),

            style: Theme.of(context).textTheme.headline4,

          ),
        ),

        buildOutlineButton(icon: Icons.add, press: () {
          setState(() {
            numOfItems++;
          });
        }),
      ],
    );
  }
  SizedBox buildOutlineButton({IconData icon,
    Function press})
  {
    return SizedBox(
      width: 40,
      height: 30,
      child:  OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}


class AddToCart extends StatelessWidget {
  final Product product;
  const AddToCart({
    Key key,
    this.product
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 20.0),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black)

            ),
            child: IconButton(onPressed: (){},
                icon: Icon(Icons.add_shopping_cart_outlined)
            ),
          ),

          Expanded(
            child: SizedBox(
              height: 50,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.grey,
                onPressed: (){
                },
                child: Text(
                  "Buy Now".toUpperCase(),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
