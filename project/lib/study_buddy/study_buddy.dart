import 'dart:convert';
import 'dart:io';

class StudyBuddy {
  static File studyData = File('./studyData.txt');

  Future<String> runPythonScript(String query) async {
    var pythonScript = './python/openai.py';

    var process = await Process.start('python', [pythonScript, query]);

    // Pass query to Python process
    process.stdin.writeln(query);
    await process.stdin.flush();
    await process.stdin.close();

    // Retrieve data from Python process
    var output = await process.stdout.transform(utf8.decoder).join();
    var result = jsonDecode(output);

    // Wait for the process to exit
    var exitCode = await process.exitCode;

    if (exitCode == 0) {
      return result;
    } else {
      throw Exception('Python script failed with exit code $exitCode');
    }
  }

  Future<String> processQuery(String query) async {
    if(!query.contains('?') && !query.contains('pergunta') && !query.contains('ask')) {
      query = '$query\n';
      studyData.writeAsStringSync(query, mode: FileMode.append);
      return 'I have learned something new!';
    }
    else {
      try {
        return await runPythonScript(query);
      } catch (e) {
          print('Python script failed');
          return '';
      }
    }
  }
}
