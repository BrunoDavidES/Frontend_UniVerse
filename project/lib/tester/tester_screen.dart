import 'package:flutter/material.dart';
import 'package:UniVerse/tester/tester.dart';

class TesterScreen extends StatefulWidget {
  const TesterScreen({super.key});

  @override
  TesterScreenState createState() => TesterScreenState();
}

class TesterScreenState extends State<TesterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmationController = TextEditingController();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController senderController = TextEditingController();
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  String? outputMessage = '';

  void registerUser(String email, String name, String password, String confirmation) {
    // Perform registration logic and update output message
    setState(() {
      outputMessage = 'User registered: $name ($email)';
    });
  }

  void loginUser(String email, String password) {
    // Perform login logic and update output message
    setState(() {
      outputMessage = 'User logged in: $email';
    });
  }

  void logoutUser() {
    // Perform logout logic and update output message
    setState(() {
      outputMessage = 'User logged out';
    });
  }

  void sendMessage(String sender, String recipient, String message) {
    // Perform send message logic and update output message
    setState(() {
      outputMessage = 'Message sent from $sender to $recipient: $message';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Screen'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the grid
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 4, // Number of columns in the grid
                mainAxisSpacing: 16.0, // Spacing between buttons vertically
                crossAxisSpacing: 16.0, // Spacing between buttons horizontally
                children: [
                  Column(
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                      ),
                      TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                      ),
                      TextField(
                        controller: confirmationController,
                        decoration: const InputDecoration(labelText: 'Confirmation'),
                        obscureText: true,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent, // Use pastel red color
                        ),
                        child: const Text('Register'),
                        onPressed: () async {
                          String email = emailController.text;
                          String name = nameController.text;
                          String password = passwordController.text;
                          String confirmation = confirmationController.text;

                          String result = await Tester().register(email, name, password, confirmation);
                          setState(() {
                            outputMessage = result;
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      TextField(
                        controller: loginEmailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                      TextField(
                        controller: loginPasswordController,
                        decoration: const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent, // Use pastel red color
                        ),
                        child: const Text('Login'),
                        onPressed: () async {
                          String email = loginEmailController.text;
                          String password = loginPasswordController.text;

                          String result = await Tester().login(email, password);
                          setState(() {
                            outputMessage = result;
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent, // Use pastel red color
                        ),
                        child: const Text('Logout'),
                        onPressed: () async {
                          String result = await Tester().logout();
                          setState(() {
                            outputMessage = result;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0), // Add spacing between the buttons
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent, // Use pastel red color
                          ),
                          child: const Text('Display Token'),
                          onPressed: () async {
                            String? result = await Tester().displayToken();
                            setState(() {
                              outputMessage = result;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      TextField(
                        controller: senderController,
                        decoration: const InputDecoration(labelText: 'Sender'),
                      ),
                      TextField(
                        controller: recipientController,
                        decoration: const InputDecoration(labelText: 'Recipient'),
                      ),
                      TextField(
                        controller: messageController,
                        decoration: const InputDecoration(labelText: 'Message'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent, // Use pastel red color
                        ),
                        child: const Text('Send Message'),
                        onPressed: () async {
                          String sender = senderController.text;
                          String recipients = recipientController.text;
                          List<String> recipientIds = recipients.split(',');
                          String message = messageController.text;

                          String result = await Tester().sendMessage(sender, recipientIds, message);
                          setState(() {
                            outputMessage = result;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              outputMessage!,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
