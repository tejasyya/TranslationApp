import 'package:flutter/material.dart';
class mScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Abhivadin"),),
      body: Material(
        child: Container(
          padding: EdgeInsets.only(top:30.0),
          color: Colors.lightBlueAccent,
          child: Center(
            child: Column(
              children: <Widget>[
               // SingleChildScrollView(
                 // child:
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                   child:
                  dropDown(), 
                    ),
              //Expanded(
               // child: 
                   swapButton(),
                // ),
               Expanded(
                      child: 
                        dropDown(), 
               ),
              ],
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class swapButtonImage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage = AssetImage('assests/icons/swap_horiz.png');
    Image image = Image(image: assetImage, height: 19.0,width: 19.0,);
    return Container(child: image,);
  }
             
}
class swapButton extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: swapButtonImage(),
        color: Colors.blue[400],
        padding: EdgeInsets.all(0),
        elevation: 6.0,
        shape: CircleBorder(),
        onPressed: ()=>swapLan(context)
      ),
    );
  }
  void swapLan(BuildContext context)
  {
    var alertDialog= AlertDialog(
            //title: Text("Languages swapped!!"),
            content: Text("Swapped Successfully!"),
    );
    showDialog(
            context: context,
            builder: (BuildContext context) => alertDialog
    );
  }
  
}
class dropDown extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _dropDownState();
  }
}
class _dropDownState extends State<dropDown>
{
  var _languages=['Arabic','Chinese(Simplified)','Chinese(Traditional)','Czech','Danish','Dutch','English','Finnish','French',
                   'German','Hebrew','Indonesian','Italian','Japanese','Korean','Polish','Portuguese','Russian','Spanish','Swedish','Turkish'];
  var _currentItemSelected = 'English';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
             // Expanded(
               // child: 
              DropdownButton<String>(
                     items:_languages.map((String dropDownStringItem) {
                       return DropdownMenuItem<String>(
                           value: dropDownStringItem,
                           
                           child:
                           Container(
                             decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(50)),
                         color: Colors.blue[400],
                       ),
                       
                       width: 112.0,
                             child:
                           Text(
                             dropDownStringItem,
                             style: TextStyle(color: Colors.white,fontSize: 20.0,),
                             textAlign: TextAlign.center,
                        ),
                           ),
                       );
                     }).toList(),
                     onChanged: (String newValueSelected){
                       _onDropDownItemSelected(newValueSelected);
                       
                     },
                     value: _currentItemSelected,
                     
            );       
      // );
  }
  void _onDropDownItemSelected(String newValueSelected)
  {
       setState(() {
                        this._currentItemSelected=newValueSelected; 
    });
  }
}