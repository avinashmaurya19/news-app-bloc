import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_news_assignment/bloc/news_bloc.dart';
import 'package:github_news_assignment/component/drop_down_list.dart';
import 'package:github_news_assignment/constant/list_of_country.dart';


class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  dynamic cName;
  dynamic country;
  dynamic findNews;
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32),
        children: <Widget>[
          ListTile(
            title: TextFormField(
              decoration: const InputDecoration(hintText: 'Find Keyword'),
              scrollPadding: const EdgeInsets.all(5),
              onChanged: (String val) => setState(() => findNews = val),
            ),
            trailing: IconButton(
              onPressed: () async {
                BlocProvider.of<NewsBloc>(context).add(GetNews(
                    'https://newsapi.org/v2/top-headlines?q=$findNews&apiKey=58b98b48d2c74d9c94dd5dc296ccf7b6'));
                Navigator.pop(context);
              },
              icon: const Icon(Icons.search),
            ),
          ),
          ExpansionTile(
            title: const Text('Country'),
            children: <Widget>[
              for (int i = 0; i < listOfCountry.length; i++)
                DropDownList(
                  call: () {
                    country = listOfCountry[i]['code'];
                    cName = listOfCountry[i]['name']!.toUpperCase();
                    BlocProvider.of<NewsBloc>(context).add(GetNews(
                        'https://newsapi.org/v2/top-headlines?country=$country&apiKey=58b98b48d2c74d9c94dd5dc296ccf7b6'));
                    Navigator.pop(context);
                  },
                  name: listOfCountry[i]['name']!.toUpperCase(),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
