import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_furniture_app/fetchProducts.dart';
import 'categories.dart';
import 'details.dart';
import 'fetchCategories.dart';

import 'products.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(),
      body: Body(),
    );
  }

  //App Bar
  AppBar BuildAppBar(){
    return AppBar(
      leading: IconButton(
          onPressed: (){}
          , icon: Icon(Icons.menu_rounded, size: 30,color: Colors.black,)
      ),
      actions: [
        IconButton(onPressed: (){},
            icon: Icon(Icons.qr_code_scanner_rounded, size: 30,color: Colors.black,)
        ),
        Center(
          child: Text(
            "Scan",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(width: 20,)
      ],
    );
  }
}

//Body
class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BrowseText(),
            // SizedBox(height: 10,),
            // Categories()
            // FutureBuilder(
            //   future: fetchCategories(),
            //     builder: (context, snapshot) =>
            //         snapshot.hasData ? Categories(
            //           categories: ) : CircularProgressIndicator()
            // )
            FutureBuilder(
              future: fetchCategories(),
              builder: (context, snapshot) => snapshot.hasData ?
              Categories(categories: snapshot.data) :
              Center(
                child: Image.asset("assets/ripple.gif"),
              ),
            ),

            Divider(
              height: 2,
              color: Colors.black26,
            ),

            RecommendedText(),

            FutureBuilder(
                future: fetchProducts(),
                builder: (context, snapshot){
                  return snapshot.hasData ?
                  RecommendedProducts(products: snapshot.data,) :
                  Center(
                    child: Image.asset("assets/ripple.gif"),
                  );
                })

            // ProductCard(product: product, press: (){},)
          ],
        ),
      ),
    );
  }
}


//Browse Text
class BrowseText extends StatelessWidget {
  const BrowseText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        "Browse By Yourself",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),
      ),
    );
  }
}


//Category Card
class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    this.category
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17.5, right: 17.5, bottom: 17.5),
      child: SizedBox(
        width: 200,
        child: AspectRatio(
          aspectRatio: 0.9,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                // color: Colors.blue,
              ),
              ClipPath(
                clipper: CategoryCustomShape(),
                child: AspectRatio(
                  aspectRatio: 1.2,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 30),
                    color: Colors.black12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          category.title,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "${category.numOfProducts}+ products",
                          style: TextStyle(
                              color: Colors.black
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AspectRatio(
                      aspectRatio: 1.5,
                      child: FadeInImage.assetNetwork(
                          placeholder: "assets/spinner.gif",
                          image: category.image)
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}


//Category Custom Shape
class CategoryCustomShape extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double height = size.height;
    double width = size.width;
    double cornerSize = 30;

    path.lineTo(0, height - cornerSize);
    path.quadraticBezierTo(0, height, cornerSize, height);
    path.lineTo(width - cornerSize, height);
    path.quadraticBezierTo(width, height, width, height - cornerSize);
    path.lineTo(width, cornerSize);
    path.quadraticBezierTo(width, 0, width - cornerSize, 0);
    path.lineTo(cornerSize, 0);
    path.quadraticBezierTo(0, cornerSize * 0.01, 0, cornerSize * 1.5);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}


//Categories
class Categories extends StatelessWidget {
  const Categories({
    Key key,
    this.categories
  }) : super(key: key);

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(
              categories.length,
                  (index) => CategoryCard(
                  category: categories[index]))
      ),
    );
  }
}


//Recommended Text
class RecommendedText extends StatelessWidget {
  const RecommendedText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        "Recommended for you",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),
      ),
    );
  }
}


//Product Card
class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.product, this.press
  }) : super(key: key);

  final Product product;
  final Function press;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: 175,

        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(25)
        ),

        child: AspectRatio(
          aspectRatio: 0.75,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: FadeInImage.assetNetwork(
                    placeholder: "assets/spinner.gif",
                    image: product.image),
              ),
              Text(
                product.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),

              SizedBox(height: 5,),

              Text("\$${product.price}")
            ],
          ),
        ),

      ),
    );
  }
}


//Recommended Products
class RecommendedProducts extends StatelessWidget {
  const RecommendedProducts({
    Key key,
    this.products
  }) : super(key: key);


  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20
        ),
        itemBuilder: (context, i) =>
            ProductCard(product: products[i],
              press: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder:
                      (context) => DetailsScreen(product: products[i],)
                  )
              ),),
      ),
    );
  }
}
