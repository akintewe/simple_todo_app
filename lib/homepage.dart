import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> todos = [
    'Buy groceries',
    'Do laundry',
    'Call mom',
  ];
  int _counter = 0; // updated to start at 0

  void _increaseCount() {
    setState(() {
      _counter++;
    });
  }

  void addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            autofocus: true,
            onSubmitted: (value) {
              setState(() {
                todos.add(value);
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  void editTodo(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTodo = todos[index];
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            autofocus: true,
            onChanged: (value) {
              newTodo = value;
            },
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text('Save'),
              onPressed: () {
                onPressed:
                setState(() {
                  todos[index] = newTodo;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  Future<void> _deleteTodoAtIndex(int index) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Todo'),
          content: const Text('Are you sure you want to delete this todo?'),
          actions: [
            TextButton(
              child: const Text('No', style: TextStyle(color: Colors.purple)),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            ElevatedButton(
              child: Text('Yes', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      setState(() {
        todos.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Container(
          child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.pink[100],
                ),
                margin: EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: Text(todos[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.green[100],
                        ),
                        onPressed: () {
                          editTodo(index);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          _deleteTodoAtIndex(index);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
        onPressed: () {
          _increaseCount();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String newTodo = '';
              return AlertDialog(
                title: const Text('Add Task'),
                content: TextField(
                  autofocus: true,
                  onChanged: (value) {
                    newTodo = value;
                  },
                ),
                actions: [
                  TextButton(
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                    ),
                    child: const Text('Add'),
                    onPressed: () {
                      setState(() {
                        todos.add(newTodo);
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
