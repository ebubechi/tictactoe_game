import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oTurn = true; // first to go is O
  List<String> displayXOH = ['', '', '', '', '', '', '', '', ''];
  TextStyle myStyle = TextStyle(color: Colors.white, fontSize: 22.0);
  int oScore = 0;
  int xScore = 0;
  int fieldBoxes = 0;

  static TextStyle myNewFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.black, letterSpacing: 3)
  );
  static TextStyle myNewFontWhite = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 15)
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, right: 15.0),
                      child: Text('Player O', style: myNewFontWhite),
                    ),
                    Text(oScore.toString(), style: myNewFontWhite),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 15.0),
                      child: Text('Player X', style: myNewFontWhite),
                    ),
                    Text(
                      xScore.toString(),
                      style: myNewFontWhite,
                    ),
                  ],
                ),
              ],
            ),
          )),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Center(
                        child: Text(
                          displayXOH[index],
                          style: TextStyle(color: Colors.white, fontSize: 40.0),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: Text('TIC TAC TOE', style: myNewFontWhite,),
                     ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: Text('@SPACE_X', style: myNewFontWhite,),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (oTurn && displayXOH[index] == '') {
        displayXOH[index] = 'O';
        fieldBoxes += 1;
      } else if (!oTurn && displayXOH[index] == '') {
        displayXOH[index] = 'X';
        fieldBoxes += 1; 
      }
      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displayXOH[0] == displayXOH[1] &&
        displayXOH[0] == displayXOH[2] &&
        displayXOH[0] != '') {
      _showWinDialog(displayXOH[0].toString());
    }
    if (displayXOH[3] == displayXOH[4] &&
        displayXOH[3] == displayXOH[5] &&
        displayXOH[3] != '') {
      _showWinDialog(displayXOH[3].toString());
    }
    if (displayXOH[6] == displayXOH[7] &&
        displayXOH[6] == displayXOH[8] &&
        displayXOH[6] != '') {
      _showWinDialog(displayXOH[6].toString());
    }
    if (displayXOH[0] == displayXOH[3] &&
        displayXOH[0] == displayXOH[6] &&
        displayXOH[0] != '') {
      _showWinDialog(displayXOH[0].toString());
    }
    if (displayXOH[1] == displayXOH[4] &&
        displayXOH[1] == displayXOH[7] &&
        displayXOH[1] != '') {
      _showWinDialog(displayXOH[1].toString());
    }
    if (displayXOH[2] == displayXOH[5] &&
        displayXOH[2] == displayXOH[8] &&
        displayXOH[2] != '') {
      _showWinDialog(displayXOH[2].toString());
    }
    if (displayXOH[0] == displayXOH[4] &&
        displayXOH[0] == displayXOH[8] &&
        displayXOH[0] != '') {
      _showWinDialog(displayXOH[0].toString());
    }
    if (displayXOH[2] == displayXOH[4] &&
        displayXOH[2] == displayXOH[6] &&
        displayXOH[2] != '') {
      _showWinDialog(displayXOH[2].toString());
    }else if (fieldBoxes == 9) {
      _showDrawDialog();
    }
  }
      
  void _showWinDialog(String winner) {
    showDialog(
      barrierDismissible: false,
        context: (context),
        builder: (context) {
          return AlertDialog(
            title: Text('WINNER IS: $winner'),
            actions: [
              FlatButton(
                onPressed: (){
                  _clearBoard();
                  Navigator.pop(context);
                }, 
                child: Text('Play Again!'))
            ],
          );
        }
    );
    if (winner == 'O') {
      oScore += 1;
    } else if (winner == 'X') {
      xScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for(int i=0; i<9; i++) {
      displayXOH[i] = '';
    }
    });
    fieldBoxes = 0;
  }

  void _showDrawDialog() {
    showDialog(
      barrierDismissible: false,
        context: (context),
        builder: (context) {
          return AlertDialog(
            title: Text('DRAW'),
            actions: [
              FlatButton(
                onPressed: (){
                  _clearBoard();
                  Navigator.pop(context);
                }, 
                child: Text('Play Again!'))
            ],
          );
        }
    );
  }
}
