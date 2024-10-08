import 'package:flutter/material.dart';

void main() {
  runApp(KuisApp());
}

class KuisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuis Sederhana',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MulaiKuisPage(),
    );
  }
}

// Halaman untuk memulai kuis
class MulaiKuisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kuis Sederhana'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selamat Datang di Kuis Sederhana!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KuisPage()),
                );
              },
              child: Text('Mulai Kuis'),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman untuk pertanyaan kuis
class KuisPage extends StatefulWidget {
  @override
  _KuisPageState createState() => _KuisPageState();
}

class _KuisPageState extends State<KuisPage> {
  final List<Question> questions = [
    Question(
      question: "Apa yang menjadi simbol kimia untuk air?",
      options: ["O2", "CO2", "H2O"],
      answer: "H2O",
    ),
    Question(
      question: "Apa warna bendera nasional Jepang?",
      options: ["Merah dan Putih", "Biru dan Putih", "Hijau dan Putih"],
      answer: "Merah dan Putih",
    ),
    Question(
      question: "Apa nama planet ketiga dari Matahari dalam tata surya kita?",
      options: ["Mars", "Venus", "Bumi"],
      answer: "Bumi",
    ),
    Question(
      question: "Siapa penemu lampu pijar?",
      options: ["Nikola Tesla", "Thomas Edison", "Albert Einstein"],
      answer: "Thomas Edison",
    ),
    Question(
      question: "Apa yang dimaksud dengan Global Warming?",
      options: [
        "Proses pendinginan atmosfer Bumi",
        "Kenaikan suhu rata-rata Bumi karena gas rumah kaca",
        "Perubahan musim yang ekstrem"
      ],
      answer: "Kenaikan suhu rata-rata Bumi karena gas rumah kaca",
    ),
  ];

  int currentQuestionIndex = 0;
  int score = 0;

  void answerQuestion(String selectedOption) {
    if (selectedOption == questions[currentQuestionIndex].answer) {
      score++;
    }
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _showScore();
    }
  }

  void _showScore() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Skor Anda'),
          content: Text('Anda mendapatkan $score dari ${questions.length} pertanyaan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentQuestionIndex = 0;
                  score = 0;
                });
              },
              child: Text('Ulangi Kuis'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Kembali ke halaman Mulai Kuis
              },
              child: Text('Keluar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kuis Sederhana'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              questions[currentQuestionIndex].question,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ...questions[currentQuestionIndex].options.map((option) {
              return ElevatedButton(
                onPressed: () => answerQuestion(option),
                child: Text(option),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String question;
  final List<String> options;
  final String answer;

  Question({required this.question, required this.options, required this.answer});
}
