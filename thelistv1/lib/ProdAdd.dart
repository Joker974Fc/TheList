import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thelistv1/FrigPage.dart';
import 'package:thelistv1/ProductModel.dart';

class ProdAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: CentralSection(),
      /*body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),*/
      bottomNavigationBar: BottomNavBarSection(),
    );
  }
}

// gestion affichage des sections
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: CentralSection(),
      bottomNavigationBar: BottomNavBarSection(),
    );
  }
}

// gestion banderole
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.restaurant_menu,
          color: Colors.grey[800],
          size: 20,
        ),
        onPressed: null,
      ),
      title: Text(
        'Ajout d\'un produit',
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}

//section Principal
class CentralSection extends StatelessWidget {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(height: 50),
      Text("Nom du Produit :"),
      TextField(
        controller: _controller1,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Nom',
        ),
      ),
      SizedBox(height: 25),
      //descr
      Text("Descriptions :"),
      TextField(
        controller: _controller2,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Descriptions',
        ),
      ),
      SizedBox(height: 25),
      ElevatedButton.icon(
        onPressed: () {
          print(_controller1.text);
          ProdView()
              .produits
              .add(ProductModel(_controller1.text, _controller2.text, false));
          //refresh
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FrigPage()), // this mainpage is your page to refresh.
            (Route<dynamic> route) => false,
          );
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
        icon: Icon(Icons.add), //icon data for elevated button
        label: Text("Ajouter le produit"),
        //label text
      ),
    ]);
  }
}

// banderole du bas
class BottomNavBarSection extends StatelessWidget {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.grey[600],
      currentIndex: index,
      onTap: (index) {
        this.index = index;
        print(index);
        switch (index) {
          case 0:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FrigPage();
            }));
            break;
          default:
        }
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.arrow_back,
            color: d_green,
          ),
          label: 'Retour',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite_outline_rounded,
            color: d_green,
          ),
          label: 'Fav',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: d_green,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
