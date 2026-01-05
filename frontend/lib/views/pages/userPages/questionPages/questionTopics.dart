import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter, FilteringTextInputFormatter;
import 'package:teste/classes/lessonClass.dart';
import 'package:teste/views/pages/userPages/questionPages/question.dart';
import 'package:teste/views/pages/userPages/questionPages/questionSubTopics.dart';

LessonClass lessonClassInstance = LessonClass();
bool hasData = false;
final TextEditingController questionQuantity = TextEditingController();
String questionDifficulty = "";

class QuestionTopic extends StatefulWidget{
  final String subjectName;
  final String questionsContext;
  const QuestionTopic({Key? key, required this.subjectName, required this.questionsContext}) : super(key: key);
  @override
  State<QuestionTopic> createState() => _QuestionTopicState();
}

class _QuestionTopicState extends State<QuestionTopic> {
  @override
  Widget build(BuildContext context) {
    if (hasData) {
            List subjectsList = lessonClassInstance.lessonData["topics"]?["msg"];
            return Column(children: [
              ElevatedButton(onPressed: (){
                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Question(questionType: "topics", questionFilter: [subjectsList], quantity: int.parse(questionQuantity.text), dificulty: questionDifficulty, questionsContext: widget.questionsContext)),
                      );
              }, child: Text("Fazer questões")),
              TextField(controller: questionQuantity, keyboardType: TextInputType.number, inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly], decoration: InputDecoration(labelText: "Quantidade de questões")),
              DropdownButton<String>(
                value: questionDifficulty,
                
                items: [
                  DropdownMenuItem(value: "facil", child: Text("Fácil")),
                  DropdownMenuItem(value: "medio", child: Text("Médio")),
                  DropdownMenuItem(value: "dificil", child: Text("Difícil")),
                ],
                
                
                onChanged: (novoValor) {
                  setState(() {
                    questionDifficulty = novoValor!;
                  });
                },
              ),
              Expanded(child:
              ListView.builder(
              itemCount: subjectsList.length,
              itemBuilder: (context, index){
                final item = subjectsList[index]['name'];
                return Card(
                  clipBehavior: Clip.hardEdge, 
                  child: InkWell(
                    splashColor: Colors.blue.withOpacity(0.3),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuestionSubTopic(topicName: item, questionsContext: widget.questionsContext)),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text(item),
                    ),
                  ),
                );
              })
              )
            ]); 
    }
    return(
      FutureBuilder(future: lessonClassInstance.saveTopicData(widget.subjectName), builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return (CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            hasData=true;
            List subjectsList = snapshot.data?["topics"]?["msg"];
            return Column(children: [
              ElevatedButton(onPressed: (){
                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Question(questionType: "topics", questionFilter: [subjectsList], quantity: int.parse(questionQuantity.text), dificulty: questionDifficulty, questionsContext: widget.questionsContext)),
                      );
              }, child: Text("Fazer questões")),
              TextField(controller: questionQuantity, keyboardType: TextInputType.number, inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly], decoration: InputDecoration(labelText: "Quantidade de questões")),
              DropdownButton<String>(
                value: questionDifficulty,
                
                items: [
                  DropdownMenuItem(value: "facil", child: Text("Fácil")),
                  DropdownMenuItem(value: "medio", child: Text("Médio")),
                  DropdownMenuItem(value: "dificil", child: Text("Difícil")),
                ],
                
                
                onChanged: (novoValor) {
                  setState(() {
                    questionDifficulty = novoValor!;
                  });
                },
              ),
              Expanded(child: 
              ListView.builder(
              itemCount: subjectsList.length,
              itemBuilder: (context, index){
                final item = subjectsList[index]['name'];
                return Card(
                  clipBehavior: Clip.hardEdge, 
                  child: InkWell(
                    splashColor: Colors.blue.withOpacity(0.3),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuestionSubTopic(topicName: item, questionsContext: widget.questionsContext)),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text(item),
                    ),
                  ),
                );
              })
              )
            ]); 
          }

          return(Image.network("https://static.vecteezy.com/system/resources/thumbnails/024/405/934/small/icon-tech-error-404-icon-isolated-png.png"));
        }
      )
    );
  }
}