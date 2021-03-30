import 'package:flutter/material.dart';


class PinterestButtom{

  final Function onPressed;
  final IconData icon;
  PinterestButtom({
    @required this.onPressed,
    @required this.icon
  });

}


class PinterestMenu extends StatelessWidget {

  final List<PinterestButtom> items =[
    PinterestButtom(icon: Icons.pie_chart,onPressed: () {print('Icon pie_chart');}),
    PinterestButtom(icon: Icons.search,onPressed: () {print('Icon search');}),
    PinterestButtom(icon: Icons.notifications,onPressed: () {print('Icon notifications');}),
    PinterestButtom(icon: Icons.supervised_user_circle,onPressed: () {print('Icon supervised_user_circle');})
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _PinterestMenuBackground(
        child: _MenuItems( items )
      ),
    );
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  final Widget child;
  const _PinterestMenuBackground({this.child}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
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
    return GestureDetector(
      onTap: item.onPressed,
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Icon( 
          item.icon, 
          size: 25,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}