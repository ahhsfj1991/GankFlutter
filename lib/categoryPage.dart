import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'webviewPage.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key, this.type});
  final int type;

  @override
  State<StatefulWidget> createState() {
    return new MainPage();
  }
}

class MainPage extends State<CategoryPage> {
  bool loading = true;
  static const loadingTag = {'tag': ""};
  var data = <dynamic>[loadingTag];
  int pageSize = 10;
  int pageNo = 1;
  int type;

  void _getGankData() async {
    String category;
    if (type == 1) {
      category = 'Android';
    } else if (type == 2) {
      category = 'iOS';
    } else if (type == 3) {
      category = 'all';
    } else {
      category = '福利';
    }
    Response response =
        await Dio().get('http://gank.io/api/data/$category/$pageSize/$pageNo');
    data.insertAll(data.length - 1, response.data["results"]);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    type = widget.type;
    _getGankData();
  }

  List<Widget> _imageArray(List<dynamic> images) {
    print(images);
    if (images == null) {
      return [];
    }
    var imageWidget = <Widget>[];
    images.forEach((url) => {
          imageWidget.add(new Padding(
            padding: EdgeInsets.all(10.0),
          )),
          imageWidget.add(new Image.network(
            url,
            width: 100,
            height: 200,
          ))
        });
    return imageWidget;
  }

  Widget _itemWidget(index) {
    if (type == 4) {
      return Column(
        children: <Widget>[
          Text(data.elementAt(index)["publishedAt"]),
          Image.network(data.elementAt(index)["url"]),
        ],
      );
    } else {
      return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (context) {
                        return new WebviewPage(
                            url: data.elementAt(index)["url"]);
                      }));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            data.elementAt(index)["desc"],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  _imageArray(data.elementAt(index)["images"]),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(data.elementAt(index)["type"]),
                              Padding(
                                padding: EdgeInsets.only(left: 30.0),
                                child: Text(data.elementAt(index)["who"]),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
    }
  }

  void _nextPage() => pageNo++;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: loading
          ? Center(
              child: CircularProgressIndicator(strokeWidth: 2.0),
            )
          : Scrollbar(
              child: ListView.separated(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  if (data[index] == loadingTag) {
                    _nextPage();
                    _getGankData();
                    return Container(
                      padding: EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(strokeWidth: 2.0),
                      ),
                    );
                  }
                  return _itemWidget(index);
                },
                separatorBuilder: (context, index) {
                  return Divider(height: 0.1);
                },
              ),
            ),
    );
  }
}
