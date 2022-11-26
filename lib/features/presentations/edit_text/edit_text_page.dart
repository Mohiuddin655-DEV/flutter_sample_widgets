import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_views/core/widgets/edit_text.dart';
import 'package:flutter_views/features/presentations/home/home_page.dart';

class EditTextPage extends StatefulWidget {
  const EditTextPage({Key? key}) : super(key: key);

  @override
  State<EditTextPage> createState() => _EditTextPageState();
}

class _EditTextPageState extends State<EditTextPage> {
  final TextEditingController controller = TextEditingController();
  var isValid = false;

  dynamic snackBar = SnackBar(
    duration: const Duration(microseconds: 1500),
    content: const Text("Your Registration Complete"),
    action: SnackBarAction(
      label: "Go it",
      onPressed: () {},
    ),
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: !isValid ? Colors.redAccent : Colors.green,
          title: const Text("Edit Text"),
          centerTitle: true,
          elevation: 2,
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Enter Your Email",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                isValid ? "('_')" : "(^_^!)",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 24),
              EditText(
                controller: controller,
                inputType: InputType.number,
                onEvent: (event) {
                  isValid = event.isValid;
                  print('\n\n');
                  print(event.isValid);
                  print(event.value);
                  setState(() {});
                },
              ),
              const SizedBox(height: 30),
              _loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  _loginButton() {
    return ElevatedButton(
      onPressed: !isValid
          ? null
          : () {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Future.delayed(const Duration(microseconds: 1500)).then(
                (value) {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
              );
              controller.clear();
              isValid = false;
              setState(() {});
            },
      style: ButtonStyle(
        backgroundColor: !isValid
            ? MaterialStateProperty.all(
                const Color.fromARGB(255, 41, 41, 41),
              )
            : MaterialStateProperty.all(
                Colors.green,
              ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Text("Log in"),
      ),
    );
  }
}
