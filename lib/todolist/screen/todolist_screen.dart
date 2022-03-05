



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/todolist/bloc/bloc.dart';
import 'package:todolist/todolist/bloc/event.dart';
import 'package:todolist/todolist/bloc/state.dart';

class TodoListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodoListScreenState();
  }
  
}

class _TodoListScreenState extends State<TodoListScreen> {

  TodoListBloc _bloc;
  int updateIndex;

  @override
  void initState() {
    super.initState();
    _bloc = TodoListBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  final TextEditingController textController = TextEditingController();
  final TextEditingController textTodoListController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TodoList'),
      ),
      body: BlocBuilder<TodoListBloc, TodoListBlocState>(
        builder: (BuildContext blocContext, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // text field
                Container(
                  width: double.infinity,
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                            controller: textController,
                            decoration: InputDecoration(
                              hintText: 'Enter Todo List',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          )
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        height: 60,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              context.read<TodoListBloc>().add(AddTodoList(payload: textController.text));
                              FocusScope.of(context).requestFocus(new FocusNode());
                              textController.clear();
                            });
                          },
                          child: Text('ADD TodoList'),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 16,),

                // Todo List

                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.todoList.length,
                  separatorBuilder:(__, int index) => Divider(),
                  itemBuilder: (__, int index) {
                    String title = state.todoList[index].text;
                    String id = state.todoList[index].id;
                    return ListTile(
                      title: updateIndex == index ? TextField(controller: textTodoListController,) : Text(title),
                      leading: GestureDetector(
                        onTap: (){
                          if (updateIndex == index) {
                            setState(() {
                              context.read<TodoListBloc>().add(UpdateTodoList(id: id, text: textTodoListController.text));
                              updateIndex = null;
                              textTodoListController.clear();
                              FocusScope.of(context).requestFocus(new FocusNode());
                            });
                          } else {
                            setState(() {
                              updateIndex = index;
                              textTodoListController.text = title;
                            });
                          }
                        },
                        child: Icon(updateIndex == index ? Icons.update : Icons.edit),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          setState(() {
                            context.read<TodoListBloc>().add(RemoveTodoList(id: id));
                            updateIndex = null;
                          });
                        },
                        child: Icon(Icons.delete),
                      ),
                    );
                  }

                )

              ],
            ),
          );
        },
      ),
    );
  }
  
}