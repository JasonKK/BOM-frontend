import 'package:bom_front/view/components/color_selection_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late TextEditingController categoryName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          foregroundColor: Colors.grey,
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text('카테고리 만들기',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20.0),
                  TextField(
                    // obscureText: true,
                    controller: categoryName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '제목을 입력해주세요',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text('색상:',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17)),
                        SizedBox(width: 10.0),
                        BomColor(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('카테고리 분류:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 17)),
                      SizedBox(width: 30.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.trip_origin,
                            color: Color(0xffA876DE),
                            size: 18.0,
                          ),
                          SizedBox(width: 1.0),
                          Text(
                            '과목',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                        ],
                      ),
                      SizedBox(width: 30.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.radio_button_unchecked,
                            color: Color(0xffA876DE),
                            size: 18.0,
                          ),
                          SizedBox(width: 1.0),
                          Text(
                            '기타',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 160,
                        height: 60,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xffA876DE),
                                //background color of button
                                // side: BorderSide(width:3, color:Colors.brown), //border width and color
                                // elevation: 3, //elevation of button
                                shape: RoundedRectangleBorder(
                                    //to set border radius to button
                                    borderRadius: BorderRadius.circular(30)),
                                padding: EdgeInsets.all(
                                    20) //content padding inside button
                                ),
                            child: Text('저장',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                      ),
                      SizedBox(
                        width: 160,
                        height: 60,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xffececec),
                                //background color of button
                                // side: BorderSide(width:3, color:Colors.brown), //border width and color
                                // elevation: 3, //elevation of button
                                shape: RoundedRectangleBorder(
                                    //to set border radius to button
                                    borderRadius: BorderRadius.circular(30)),
                                padding: EdgeInsets.all(
                                    20) //content padding inside button
                                ),
                            child: Text('취소',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black))),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
