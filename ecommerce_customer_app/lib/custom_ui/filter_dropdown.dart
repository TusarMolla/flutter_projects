import 'package:flutter/material.dart';
import 'package:grostore/helpers/device_info_helper.dart';


class FilterDropDown extends StatefulWidget {
  late List<DropDownFilterModel> model;
  late Function onSelected;

  FilterDropDown({super.key, required this.onSelected, required this.model});

  @override
  State<FilterDropDown> createState() => _FilterDropDownState();
}

class _FilterDropDownState extends State<FilterDropDown> {

  TextEditingController controller=TextEditingController();
  List<DropDownFilterModel> data = [];
  DropDownFilterModel? selected;

  @override
  void initState() {
    // TODO: implement initState
   data.addAll(widget.model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<DropDownFilterModel>(
      value: selected,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (DropDownFilterModel? value) {
        widget.onSelected(value);
      },
      items:  [
        DropdownMenuItem<DropDownFilterModel>(
          child: Container(
            width: getWidth(context)*0.5,
            height: 40,
            child: TextField(
              controller: controller,
              onChanged: (text)async{
                if(text.isNotEmpty){
                  List<DropDownFilterModel> tmp =[];
                  for(DropDownFilterModel mo in widget.model){
                    if(mo.name.contains(text)){
                      tmp.add(mo);
                    }
                  }
                  data.clear();
                  data.addAll(tmp);
                }else{
                  data.clear();
                  data.addAll(widget.model);
                }
              },
            ),
          ),
        ),
        DropdownMenuItem<DropDownFilterModel>(
          child: Container(
            width: getWidth(context)*0.5,
            height: 40,
            child: TextField(
              //controller: controller,
              onChanged: (text)async{
                if(text.isNotEmpty){
                  List<DropDownFilterModel> tmp =[];
                  for(DropDownFilterModel mo in widget.model){
                    if(mo.name.contains(text)){
                      tmp.add(mo);
                    }
                  }
                  data.clear();
                  data.addAll(tmp);
                }else{
                  data.clear();
                  data.addAll(widget.model);
                }
              },
            ),
          ),
        ),
        //...item(data),

      ],
    );
  }

  List<DropdownMenuItem<DropDownFilterModel>> item(List<DropDownFilterModel> data) {
    // data.insert(0, DropDownFilterModel(key: "_search", name: ""));
    List<DropdownMenuItem<DropDownFilterModel>> items = [];

    for (DropDownFilterModel model in data) {
      items.add(
          DropdownMenuItem<DropDownFilterModel>(
            child: Text(model.name),
          )
      );
    }

    return items;
  }

}

class DropDownFilterModel {
  late String key;
  late String name;

  DropDownFilterModel({required this.key, required this.name});

}


