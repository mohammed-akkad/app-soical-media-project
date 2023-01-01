// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
//
// class LandingPAge extends StatefulWidget {
//   const LandingPAge({Key? key}) : super(key: key);
//
//   @override
//   State<LandingPAge> createState() => _LandingPAgeState();
// }
//
// class _LandingPAgeState extends State<LandingPAge> {
//   final controller = TextEditingController();
//   final _firestore = FirebaseFirestore.instance;
//   final _auth = FirebaseAuth.instance;
//   var image = 'https://www.gstatic.com/images/icons/material/apps/fonts/1x/catalog/v5/opengraph_color.png';
//   bool visibility = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//       child: Scaffold(
//           backgroundColor: Colors.white,
//           body: Stack(
//             children: [
//               SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Column(
//                     children: [
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'MyMedia',
//                               style: GoogleFonts.ubuntu(
//                                   color: Colors.blueAccent,
//                                   fontSize: 30,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             IconButton(onPressed: (){
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
//                             }, icon: const Icon(Icons.person,color: Colors.blueAccent,))
//                           ],
//                         ),
//
//                       ),
//                       const Divider(
//                         color: Colors.grey,
//                       ),
//                       Expanded(
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: [
//
//
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               SizedBox(
//                                 height: 50,
//                                 child: TextField(
//
//                                   onSubmitted: (s){
//                                     PostService().createPost(s, image);
//                                   },
//                                   controller: controller,
//                                   decoration: InputDecoration(
//                                       prefix: CircleAvatar(backgroundImage: NetworkImage(image)),
//                                       hintText: 'Whats In Your Mind...',
//                                       suffix: IconButton(
//                                         icon: Icon(Icons.attachment),
//                                         onPressed: ()async{
//                                           setState(() {
//                                             visibility = true;
//                                           });
//                                           var i = await Auth.uploadPick();
//                                           setState(() {
//                                             image = i;
//                                             visibility = false;
//                                           });
//                                         },
//                                       ),
//                                       hintStyle: GoogleFonts.alice(color: Colors.grey),
//                                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               SizedBox(
//                                 height: 175,
//                                 child: ListView(
//                                   scrollDirection: Axis.horizontal,
//                                   children: [
//                                     Card(
//                                       child: Container(
//                                         decoration: BoxDecoration(color: Colors.grey,
//                                             image: DecorationImage(image: NetworkImage(_auth.currentUser!.photoURL.toString()),fit: BoxFit.fill)
//                                         ),
//                                         height: 175,
//                                         width: 125,
//
//                                         child: Center(
//                                             child: InkWell(
//                                               onTap: (){},
//                                               child: const CircleAvatar(
//                                                 child: Icon(Icons.add),
//                                                 backgroundColor: Colors.white,
//                                               ),
//                                             )),
//                                       ),
//                                     ),
//
//                                   ],
//                                 ),
//                               ),
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     'New Posts',
//                                     style: GoogleFonts.alice(
//                                         color: Colors.blueAccent,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               StreamBuilder(
//                                   stream: _firestore.collection('Posts').snapshots(),
//                                   builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
//                                     List<PostsCard> cards = [];
//                                     int likes = 0;
//                                     if(snapshot.hasData){
//                                       snapshot.data!.docs.forEach((element) {
//                                         var response =  _firestore.collection('Posts').doc(element.id).collection('Likes').get().then((value){
//                                           setState(() {
//                                             likes++;
//                                           });
//                                         });
//                                         cards.add(PostsCard(title: element['title'], uploader: element['uploader'], uploaderImage: element['uploaderImage'], photo: element['photo'], postid: element.id,likes: likes.toString(),));
//
//
//                                       });
//                                     }
//
//
//                                     return snapshot.hasData != true ? Container() : Column(
//
//                                       children: cards.reversed.toList(),
//                                     );
//
//                                   })
//
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Center(
//                 child: Visibility(
//                   visible: visibility,
//                   child: const CircularProgressIndicator(color: Colors.indigo,),
//                 ),
//               )
//             ],
//           )),
//     );
//   }
// }
//
// class StoryCard extends StatelessWidget {
//
//   const StoryCard({Key? key,}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Container(
//         height: 175,
//         width: 125,
//         color: Colors.grey,
//       ),
//     );
//   }
// }
//
//
// class PostsCard extends StatefulWidget {
//   final postid;
//   final title;
//   final uploader;
//   final uploaderImage;
//   final photo;
//   final likes;
//   final comments;
//
//   const PostsCard({Key? key,required this.title,required this.uploader,required this.uploaderImage, required this.photo, this.postid, this.likes, this.comments,}) : super(key: key);
//
//   @override
//   State<PostsCard> createState() => _PostsCardState();
// }
//
// class _PostsCardState extends State<PostsCard> {
//   final _firestore = FirebaseFirestore.instance;
//   final _auth = FirebaseAuth.instance;
//   bool like = false;
//
//   @override
//
//   @override
//   Widget build(BuildContext context) {
//     return  Card(
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   backgroundColor: Colors.grey,
//                   backgroundImage: NetworkImage(widget.uploaderImage),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Text('Code Addict',
//                     style:
//                     GoogleFonts.alice(color: Colors.grey))
//               ],
//             ),
//             const Divider(),
//             const SizedBox(height: 2,),
//             Text(
//               widget.title,
//               style: GoogleFonts.alice(),
//               textAlign: TextAlign.left,
//             ),
//             Image.network(
//                 widget.photo),
//             const Divider(),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 StreamBuilder(
//                     stream: _firestore.collection('Posts').doc(widget.postid).collection('Likes').snapshots(),
//                     builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
//                       return MaterialButton(
//                         child: Column(
//                           children: [
//
//                             Icon(Icons.favorite,color: Colors.redAccent,),
//                             snapshot.hasData? Text(snapshot.data!.docs.length.toString()): Container(),
//                           ],),
//
//                         onPressed: ()async {
//                           var name = _auth.currentUser!.displayName;
//                           if(like == false ){
//                             setState(() {
//                               like = true;
//
//                             });
//                             var response = await _firestore.collection('Posts').doc(widget.postid).collection('Likes').doc(name).set( {
//                               'name': name});
//
//
//                           }else{
//                             setState(() {
//                               like =false;
//
//                             });
//                             var response = await _firestore.collection('Posts').doc(widget.postid).collection('Likes').doc(name).delete();
//                           }
//
//
//
//
//                         },
//                       );
//                     }
//                 ),
//                 StreamBuilder(
//                     stream: _firestore.collection('Posts').doc(widget.postid).collection('Comments').snapshots(),
//                     builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
//                       return MaterialButton(
//                         child: Column(
//                           children: [
//                             const Icon(Icons.comment),
//                             snapshot.hasData? Text(snapshot.data!.docs.length.toString()) : Container()
//                           ],
//                         ),
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) =>Comments(postid: widget.postid,)));
//                         },
//                       );
//                     }
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }