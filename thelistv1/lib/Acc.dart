import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thelistv1/FrigPage.dart';
import 'package:thelistv1/PharmaPage.dart';

// couleur perso
const d_green = Color.fromARGB(255, 73, 137, 129);

class Acc extends StatelessWidget {
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
      /*body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),*/
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
          Icons.app_registration,
          color: Colors.grey[800],
          size: 20,
        ),
        onPressed: null,
      ),
      title: Text(
        'The List',
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

//section boutons
class CentralSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(height: 50),
      SizedBox(
        height: 200, //height of button
        width: 500,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FrigPage();
            }));
            print("La gagne à ou la !");
          },
          icon: Icon(Icons.restaurant_menu), //icon data for elevated button
          label: Text("Mon Frigo"), //label text
        ), //width of button
      ),
      SizedBox(height: 50),
      SizedBox(
        height: 200, //height of button
        width: 500,
        child: ElevatedButton.icon(
          onPressed: () {
            print("La gagne à ou la !");
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return PharmaPage();
            }));
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
          icon: Icon(Icons.health_and_safety), //icon data for elevated button
          label: Text("Ma Pharmacie"),
          //label text
        ), //width of button)
      )
    ]);
  }
}

/*class CentralSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: 500,
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: ElevatedButton.icon(
          onPressed: () {
            print("La gagne à ou la !");
          },
          icon: Icon(Icons.save), //icon data for elevated button
          label: Text("Mon Frigo"), //label text
        ));
  }
}*/

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
        /*switch (index) {
          case 0:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return PharmaPage();
            }))
            break;
          default:
        }*/
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: d_green,
          ),
          label: 'Explore',
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
