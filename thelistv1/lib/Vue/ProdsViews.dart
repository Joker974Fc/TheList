import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Acc.dart';
import '../DB/ProdDb.dart';
import '../Model/Prod.dart';
import 'ProdAdd.dart';

// couleur perso
const d_green = Color.fromARGB(255, 73, 137, 129);

class ProdsViewsDB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: ListViewDb(),
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
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50))),
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

class ListViewDb extends StatefulWidget {
  const ListViewDb({super.key});

  @override
  State<ListViewDb> createState() => _ListViewDbState();
}

class _ListViewDbState extends State<ListViewDb> {
  int isselected = 0;
  bool supp = false;
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
                      return Card(
                          child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.restaurant_menu,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          prods![index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(prods[index].description),
                        trailing: prods[index].isSelected
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.green[700],
                              )
                            : Icon(
                                Icons.check_circle_outline,
                                color: Colors.grey,
                              ),
                        //lors du clique sur un item

                        onTap: () {
                          setState(() {
                            if (prods[index].isSelected == false) {
                              isselected += 1;
                              DbProd.instance.updateRecipe(Prod(
                                  prods[index].name,
                                  prods[index].description,
                                  true));
                            } else {
                              isselected -= 1;
                              DbProd.instance.updateRecipe(Prod(
                                  prods[index].name,
                                  prods[index].description,
                                  false));
                            }
                            print(isselected);
                            if (isselected > 0) {
                              supp = true;
                            } else if (isselected <= 0) {
                              supp = false;
                            }
                          });
                        },
                      ));
                    }),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            )),
            Visibility(
                visible: supp,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: supp
                        ? () {
                            setState(() {
                              DbProd.instance.deleteSelected();
                              isselected = 0;
                            });
                          }
                        : () {
                            setState(() {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const Expanded(
                                    child: AlertDialog(
                                      title: Icon(Icons.delete_forever),
                                      content: Text(
                                          'Sélectionnez un ou plusieurs élément à supprimer !'),
                                      actions: [],
                                    ),
                                  );
                                },
                              );
                            });
                          },
                    backgroundColor: Colors.white,
                    child: supp
                        ? Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          )
                        : Icon(Icons.delete_forever_outlined,
                            color: Colors.grey),
                  ),
                ))
          ],
        ),
      ),
    );
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
      ],
    );
  }
}
