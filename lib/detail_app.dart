import 'package:flutter/material.dart';
import 'model/app_store.dart';

class DetailApp extends StatefulWidget {
  final AppStore app;
  const DetailApp({Key? key, required this.app}) : super(key: key);

  @override
  State<DetailApp> createState() => _DetailAppState();
}

class _DetailAppState extends State<DetailApp> {
  String commentValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail App"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _infoApp(),
              _btnDownload(context),
              _lstImages(),
              _description(),
              _comment(),
              _commentBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoApp() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Image.network(widget.app.imageLogo),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.app.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.app.developer,
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.app.genre,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.app.rating,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _btnDownload(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          onPrimary: Colors.white,
        ),
        onPressed: () {},
        child: Text(
          "Download",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _lstImages() {
    return Container(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: widget.app.imageUrls.map((url) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(url),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _description() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        widget.app.description,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _comment() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: TextFormField(
        enabled: true,
        onChanged: (value) {
          commentValue = value;
        },
        decoration: InputDecoration(
          hintText: "How about this app",
          contentPadding: EdgeInsets.all(15.0),
          border: OutlineInputBorder(
            // borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: (validate() ? Colors.blue : Colors.red),
            ),
          ),
        ),
      ),
    );
  }

  Widget _commentBtn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          onPrimary: Colors.white,
        ),
        onPressed: () {
          String text = "";
          if (validate()) {
            setState(() {
              text = "Success";
            });
          } else {
            setState(() {
              text = "Input field is empty";
            });
          }
          SnackBar snackBar = SnackBar(content: Text(text));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Text(
          "Submit",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  bool validate() {
    if (commentValue == "") {
      return false;
    }
    return true;
  }
}
