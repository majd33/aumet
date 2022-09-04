import 'package:aumet_task/controller/uni_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_pagination/flutter_web_pagination.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String? countryVal;
  List universities=[];
  List listOfcurrentPage=[];
  late ChangeNotifierProvider<UniData> getUniData = ChangeNotifierProvider<UniData>((ref)=>UniData());
  bool loading = false;
  bool searchMode =false;
  var searchItemsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
             builder: (context, watch, child) {
               var uniData = watch(getUniData);
               return SingleChildScrollView(
                 child: Container(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Center(
                         child: Container(
                           child: _buildDropdownWidget(uniData),
                         ),
                       ),
                       _buildsearchField(),
                       if(loading)
                         Padding(
                           padding: const EdgeInsets.all(100.0),
                           child: Center(child: CircularProgressIndicator(),),
                         ),
                       if(!loading && universities.isNotEmpty && !searchMode)
                         _buildUnilistWidget(),
                       if(searchMode)
                         _buildUniSearchlistWidget(),
                       if(universities.length>=20 && !loading && !searchMode)
                       _buildPaginationWidget(),
                     ],
                   ),
                 ),
               );
             },
      ),
    );
  }

  _buildsearchField(){
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        width: MediaQuery.of(context).size.width*0.5,
        child: TextField(
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.search),
          ),
          onChanged: (val){
            setState(() {
              if(val.isNotEmpty) searchMode =true;
              else searchMode =false;
            });
            setState(() {
              searchItemsList=
                  universities.where((element)=> element.name.toString().toLowerCase().contains(val.toLowerCase())).toList();
            });
          },
        ));
  }

  _buildDropdownWidget(uniData){
    return DropdownButton(
      hint: Text("Select a country"),
      value: countryVal,
      items: <String>['Jordan', 'Egypt', 'Spain',].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (val) async {
        setState(() {
          universities.clear();
          loading =true;
          countryVal=val.toString();
        });
        await uniData.getData(val.toString());
        setState(() {
          universities=uniData.uniList;
          print(uniData.uniList.length);
          listOfcurrentPage = universities.take(15).toList();
          loading =false;
        });
      },
    );
  }

  _buildUniSearchlistWidget(){
    return ListView.builder(
        itemCount: searchItemsList.length,
        itemBuilder: (context, index){
          return Card(
              child: Text(searchItemsList[index].name)
          );
        },
        shrinkWrap:true
    );
  }

  _buildUnilistWidget(){
    return ListView.builder(
        itemCount: universities.length >=20 ? listOfcurrentPage.length : universities.length,
        itemBuilder: (context, index){
          return Card(
              child: Text(listOfcurrentPage[index].name)
          );
        },
        shrinkWrap:true
    );
  }

  _buildPaginationWidget(){
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: WebPagination(
          currentPage: 1,
          totalPage: (universities.length/15).ceil(),
          onPageChanged: (page) async {
            setState(() {
              listOfcurrentPage = universities.skip((page-1)*15).take(15).toList();
            });
          }),
    );
  }
}
