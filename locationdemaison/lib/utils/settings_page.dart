



/*Scaffold(
backgroundColor: Colors.white,
appBar: AppBar(
backgroundColor: Colors.white,
elevation: 0.0,
title: Text("Acceuil"),
actions: <Widget>[
TextButton.icon(onPressed: () async{
await _authenticationService.signOut();
},icon: Icon(Icons.person), label: Text("Logout"),)
],
),
//Recuperer une liste d'utilisateurs
body: Container(
child: StreamBuilder<List<Post>>(

stream: postService.readPosts(),
builder: (context,snapshot){
if(snapshot.hasError){
print(snapshot.error);
return Text("Une erreur s'est produite : ${snapshot.error}",);
}
else if(snapshot.hasData){
final posts = snapshot.data!;
return posts.isEmpty ? Center(child: Text("Aucun enregistrement trouvé"),) : ListView.builder(
itemCount: posts.map(AffichagePost).toList().length,
itemBuilder: (BuildContext context, int index) {
return SingleChildScrollView(
scrollDirection: Axis.vertical,
child: Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Card(
elevation: 5,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(20),
),
child: Column(
children: [
Container(
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(20)
),
width: MediaQuery.of(context).size.width*0.9,
height: 190,

child: Column(
children: [
Container(

decoration: BoxDecoration(
borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)
),
image: DecorationImage(
image: NetworkImage(posts[index].Image_maison!),
fit: BoxFit.cover,
),
),
height: 150,
width: MediaQuery.of(context).size.width,
child: Row(
mainAxisAlignment: MainAxisAlignment.end,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Container(
margin: EdgeInsets.all(1),
width: 50,
height: 50,
child: Column(
children: [
Card(

color: Colors.yellow,
child: Text(posts[index].Prix.toString()),
),
],
)
)
],
),
),
Row(
mainAxisAlignment: MainAxisAlignment.start,
children: [
Column(
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Text(posts[index].NomLocation),
Text(posts[index].Pays!)
],
)
],
)



],
),
),
SizedBox(height: 10,)
],
),
)
],
),
);
},

);
}else{
return Center(child: CircularProgressIndicator(),);
}
},
),
),
floatingActionButton: FloatingActionButton(
onPressed: (){
print("Boutton");
Navigator.push(context, MaterialPageRoute(builder: (context)=> AjoutPost1()));
},
tooltip: 'Increment',
child: const Icon(Icons.add),
),
bottomNavigationBar: BottomNavigationBar(

currentIndex: indexpage,
iconSize: 25,
selectedFontSize: 15,
items: [
BottomNavigationBarItem(

icon: Icon(Icons.settings),
backgroundColor: Colors.blue,
label: "Paramètre",
),
BottomNavigationBarItem(
icon: Icon(Icons.home),
backgroundColor: Colors.black,
label: "Acceuil",
),
BottomNavigationBarItem(
icon: Icon(Icons.message),
backgroundColor: Colors.red,
label: "Discussions",
),
BottomNavigationBarItem(
icon: Icon(Icons.search),
backgroundColor: Colors.green,
label: "Recherche",

),

],

onTap: (index){
setState((){
indexpage = index;
});
print(indexpage);
},
),

//Recuperer un utilisareur précis
/*body: Container(
        child: Column(
          children: [
            FutureBuilder<Personne?>(
              future: _authenticationService.readUser(),
              builder: (context,snapshot){
                if(snapshot.hasError){
                  return Text("Une erreur s'est produite ${snapshot}",);
                }else if(snapshot.hasData){
                  final user = snapshot.data!;

                  return user == null? Center(child: Text("Aucun utilisateur trouvé"),) : AffichagePersonne(user);
                }else{
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            ),
            ElevatedButton(onPressed: (){
              _authenticationService.UpdateUser("uid", "Nom", "Prenom", DateTime.now(), "Mail", "Sex", "Tel");
            }, child: Text("Update")),
            ElevatedButton(onPressed: (){
              //_authenticationService.DeleteUser();
            }, child: Text("Delete"))
          ],
        ),
      )*/
);



*/