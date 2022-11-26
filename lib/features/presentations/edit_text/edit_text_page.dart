import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_views/features/presentations/home/home_page.dart';
import 'package:validators/validators.dart';

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
              _editBox(),
              const SizedBox(height: 30),
              _loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  _editBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        onChanged: (value) {
          setState(() {
            isValid = isEmail(value);
          });
        },
        showCursor: true,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: _decoration(),
      ),
    );
  }

  _decoration() {
    return InputDecoration(
      labelText: "Email",
      labelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
      hintText: "something@email.com",
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 15,
      ),
      prefixIcon: const Icon(
        Icons.email_outlined,
        color: Colors.white,
      ),
      suffixIcon: !isValid
          ? const Icon(
              Icons.close_sharp,
              color: Colors.red,
            )
          : const Icon(
              Icons.done,
              color: Colors.green,
            ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey.shade200,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: !isValid ? Colors.red : Colors.green,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      floatingLabelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w300,
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
