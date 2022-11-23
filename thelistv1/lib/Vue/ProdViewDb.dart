import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:thelistv1/Model/Prod.dart';
import '../Acc.dart';
import '../DB/ProdDb.dart';
import '../ProdAdd.dart';

// couleur perso
const d_green = Color.fromARGB(255, 73, 137, 129);

class ProdViewDB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: ProdViews(),
      bottomNavigationBar: BottomNavBarSection(),
    );
  }
}

//gestion banderole
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
        'Mon Frigo',
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

//listview
class ProdViews extends StatelessWidget {
  //Produits

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<List<Prod>>(
              future: DbProd.instance.prods(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  List<Prod>? prods = snapshot.data;
                  return ListView.builder(
                    itemCount: prods?.length,
                    itemBuilder: ((context, index) {
                      return ProdItem(
                        prods![index].name,
                        prods[index].description,
                        prods[index].isSelected,
                        index,
                      );
                    }),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            ))
          ],
        ),
      ),
    );
  }
}

Widget ProdItem(String name, String description, bool isSelect, int ind) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: Colors.blue,
      child: Icon(
        Icons.restaurant_menu,
        color: Colors.white,
      ),
    ),
    title: Text(
      name,
      style: TextStyle(
        fontWeight: FontWeight.w500,
      ),
    ),
    subtitle: Text(description),
    trailing: isSelect
        ? Icon(
            Icons.check_circle,
            color: Colors.green[700],
          )
        : Icon(
            Icons.check_circle_outline,
            color: Colors.grey,
          ),
    /*onTap: () {
        setState(() {
          produits[index].isSelect = ! produits[index].isSelect;
          if ( produits[index].isSelect == true) {
            selected produits.add( produitsModel(name, description, true));
          } else if ( produits[index].isSelected == false) {
            selected produits
                .removeWhere((element) => element.name ==  produits[index].name);
          }
        });

  }*/
  );
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
              return Acc();
            }));
            break;
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProdAdd();
            }));
            break;
          case 2:
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
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add,
            color: d_green,
          ),
          label: 'Ajouter',
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
