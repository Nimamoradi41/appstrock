import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'Screens/Modelsuggestionssvsv.dart';
import 'modetest.dart';


class scr extends StatefulWidget {
  const scr({super.key});

  @override
  State<scr> createState() => _scrState();
}

class _scrState extends State<scr> {
  final serverurl="https://fmirzavand.ir/patientHub";
  // final serverurl="http://172.10.10.186:9595/SignalRTest";

  late HubConnection connection;

  double width=100.0, height=100.0;

  late Offset position;


  List<Modelsuggestionssvsv> list=[];
  void initC()
  {
    connection=HubConnectionBuilder().withUrl(serverurl).build();
    connection.on('ReceivePatientUpdate', (arguments) {
      print('c');
      Run();
    });
    print('AAAA');
    Run();
  }


  @override
  void initState() {
    super.initState();
    initC();
    position=Offset(0.0, -20.0);
  }


  Future Run()async{
    var request = http.Request('GET', Uri.parse('http://172.10.10.186:9595/UserApi/Values'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var  Data=modelsuggestionssvsvFromJson(await response.stream.bytesToString());
      list=Data;
      setState(() {

      });

    }
    else {
      print(response.reasonPhrase);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (ctx,item){
            return Container(
              width: double.infinity,
              height: 150,
              child: Column(
                children: [
                  Text(list[item].id.toString()),
                  Text(list[item].name.toString()),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{


      try{
        var sssc=    await connection.start();
        print('Ok');
      }catch(w)
          {
            print(w.toString());
          }
      // print(ss.toString());

          // connection.state==HubConnectionState.Disconnected ?
          //     await connection.start()  :
          //     await connection.stop();
        },
        tooltip: 'Start/Stop',
        child: connection.state==HubConnectionState.Disconnected ?  Icon(Icons.play_arrow):Icon(Icons.stop),
      ),
    );
  }
}
