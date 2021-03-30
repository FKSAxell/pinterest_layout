import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PinterestButtom{

  final Function onPressed;
  final IconData icon;
  PinterestButtom({
    @required this.onPressed,
    @required this.icon
  });

}


class PinterestMenu extends StatelessWidget {

  final bool mostrar;

  final Color backgroundColor;
  final Color activeColor; //black
  final Color inactiveColor; //bluegrey
  final List<PinterestButtom> items;
  PinterestMenu({
    this.mostrar=true,
    this.backgroundColor = Colors.white,
    this.activeColor     = Colors.black,
    this.inactiveColor   = Colors.blueGrey,
    @required this.items
  });
  

  // final List<PinterestButtom> items =[
  //   PinterestButtom(icon: Icons.pie_chart,onPressed: () {print('Icon pie_chart');}),
  //   PinterestButtom(icon: Icons.search,onPressed: () {print('Icon search');}),
  //   PinterestButtom(icon: Icons.notifications,onPressed: () {print('Icon notifications');}),
  //   PinterestButtom(icon: Icons.supervised_user_circle,onPressed: () {print('Icon supervised_user_circle');})
  // ];

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: ( _ ) => new _MenuModel(),
      child: Builder(
        builder: ( _ ){
          Provider.of<_MenuModel>( _ ).backgroundColor=backgroundColor;
          Provider.of<_MenuModel>( _ ).activeColor=activeColor;
          Provider.of<_MenuModel>( _ ).inactiveColor=inactiveColor;
          return AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            opacity: (mostrar)?1:0,
            child: _PinterestMenuBackground(
              child: _MenuItems( items )
            ),
          );
        },
         
      ),
    );
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  final Widget child;
  const _PinterestMenuBackground({this.child}) ;

  @override
  Widget build(BuildContext context) {
    final menuModel=Provider.of<_MenuModel>(context);
    return Container(
      child: child,
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        color: menuModel.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(100)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            // offset: Offset(10,10),
            blurRadius: 10,
            spreadRadius: -5
          )
        ]
      ),

    );
  }
}


class _MenuItems extends StatelessWidget {

  final List<PinterestButtom> menuItems;
  _MenuItems( this.menuItems );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(menuItems.length, (i) => _PinterestMenuButton( i, menuItems[i] )),
    );
  }
}


class _PinterestMenuButton extends StatelessWidget {

  final int index;
  final PinterestButtom item;
  _PinterestMenuButton( this.index,this.item );

  @override
  Widget build(BuildContext context) {

    final menuModel=Provider.of<_MenuModel>(context);

    final itemSeleccionado = menuModel.itemSeleccionado;
    
    return GestureDetector(
      onTap: (){
        Provider.of<_MenuModel>(context,listen: false).itemSeleccionado=index;
        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Icon( 
          item.icon, 
          size:  ( itemSeleccionado == index ) ? 35 : 25,
          color: ( itemSeleccionado == index ) ? menuModel.activeColor : menuModel.inactiveColor,
        ),
      ),
    );
  }
}


class _MenuModel with ChangeNotifier{
  
  int _itemSeleccionado = 0;
  Color _backgroundColor = Colors.white;
  Color _activeColor     = Colors.black;
  Color _inactiveColor   = Colors.blueGrey;
  
  int get itemSeleccionado =>this._itemSeleccionado;

  set itemSeleccionado( int index ){
    this._itemSeleccionado = index;
    notifyListeners();
  }

  Color get backgroundColor => this._backgroundColor;

  set backgroundColor(Color color) {
    this._backgroundColor = color;
  }

  Color get activeColor => this._activeColor;

  set activeColor(Color color) {
    this._activeColor = color;
  }

  Color get inactiveColor => this._inactiveColor;

  set inactiveColor(Color color) {
    this._inactiveColor = color;
  }

}