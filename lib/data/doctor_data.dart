import '../model/doctor_model.dart';

final doctorsData = <DoctorModel>[];
final doctorsData5 = <DoctorModel>[];
final doctorsData10 = <DoctorModel>[];
final doctorsData15 = <DoctorModel>[];
final doctorsData20 = <DoctorModel>[];

getDoctorData() {
  for (var m in doctorData) {
    final someObject = DoctorModel.fromMap(m);
    doctorsData.add(someObject);
  }
  for (var i = 0; i < 5; i++) {
    final someObject = DoctorModel.fromMap(doctorData[i]);
    doctorsData5.add(someObject);
  }
  for (var i = 0; i < 5; i++) {
    final someObject = DoctorModel.fromMap(doctorData[i]);
    doctorsData10.add(someObject);
  }
  for (var i = 0; i < 5; i++) {
    final someObject = DoctorModel.fromMap(doctorData[i]);
    doctorsData15.add(someObject);
  }
  for (var i = 0; i < 5; i++) {
    final someObject = DoctorModel.fromMap(doctorData[i]);
    doctorsData20.add(someObject);
  }
}

List doctorData = [
  {
    "id": 1,
    "doctor_name": "Christean Kopmann",
    "email": "ckopmann0@constantcontact.com",
    "phone_num": "4001035671",
    "address": "34074 Lillian Street",
    "doctor_img": "assets/doctors_img/doc1.jpg",
    "pecialty": "Marketing Assistant",
    "gender": "Female",
    "rate": 5,
    "about":
        "Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit."
  },
  {
    "id": 2,
    "doctor_name": "Darelle Winterbotham",
    "email": "dwinterbotham1@livejournal.com",
    "phone_num": "2872368003",
    "address": "9747 Carpenter Parkway",
    "doctor_img": "assets/doctors_img/doc2.jpg",
    "pecialty": "Software Test Engineer III",
    "gender": "Female",
    "rate": 3,
    "about":
        "Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst."
  },
  {
    "id": 3,
    "doctor_name": "Leanor Kleinzweig",
    "email": "lkleinzweig2@amazon.de",
    "phone_num": "5977699550",
    "address": "5795 Lerdahl Point",
    "doctor_img": "assets/doctors_img/doc3.jpg",
    "pecialty": "Structural Engineer",
    "gender": "Female",
    "rate": 4,
    "about":
        "Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat."
  },
  {
    "id": 4,
    "doctor_name": "Garreth Sargant",
    "email": "gsargant3@spiegel.de",
    "phone_num": "6169504993",
    "address": "17872 Spohn Plaza",
    "doctor_img": "assets/doctors_img/doc1.jpg",
    "pecialty": "Operator",
    "gender": "Male",
    "rate": 1,
    "about":
        "In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla."
  },
  {
    "id": 5,
    "doctor_name": "Daniel Garbar",
    "email": "dgarbar4@deviantart.com",
    "phone_num": "4873361098",
    "address": "52 David Junction",
    "doctor_img": "assets/doctors_img/doc2.jpg",
    "pecialty": "Recruiting Manager",
    "gender": "Male",
    "rate": 4,
    "about":
        "Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis."
  },
  {
    "id": 6,
    "doctor_name": "Reuben Bartelli",
    "email": "rbartelli5@twitter.com",
    "phone_num": "7249100235",
    "address": "753 Spenser Lane",
    "doctor_img": "assets/doctors_img/doc3.jpg",
    "pecialty": "Database Administrator II",
    "gender": "Male",
    "rate": 4,
    "about":
        "Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc."
  },
  {
    "id": 7,
    "doctor_name": "Chastity Bootland",
    "email": "cbootland6@nifty.com",
    "phone_num": "8796768926",
    "address": "94493 Schmedeman Park",
    "doctor_img": "assets/doctors_img/doc1.jpg",
    "pecialty": "Help Desk Operator",
    "gender": "Female",
    "rate": 1,
    "about":
        "Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus."
  },
  {
    "id": 8,
    "doctor_name": "Grace Warre",
    "email": "gwarre7@domainmarket.com",
    "phone_num": "7997437251",
    "address": "10 Waxwing Court",
    "doctor_img": "assets/doctors_img/doc2.jpg",
    "pecialty": "Programmer Analyst III",
    "gender": "Male",
    "rate": 1,
    "about":
        "Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim."
  },
  {
    "id": 9,
    "doctor_name": "Wyndham Oxbury",
    "email": "woxbury8@nhs.uk",
    "phone_num": "9464271190",
    "address": "068 Stang Alley",
    "doctor_img": "assets/doctors_img/doc3.jpg",
    "pecialty": "Budget/Accounting Analyst IV",
    "gender": "Male",
    "rate": 1,
    "about":
        "Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue."
  },
  {
    "id": 10,
    "doctor_name": "Hewie Hewins",
    "email": "hhewins9@unc.edu",
    "phone_num": "9247055217",
    "address": "70 Ilene Place",
    "doctor_img": "assets/doctors_img/doc1.jpg",
    "pecialty": "Tax Accountant",
    "gender": "Male",
    "rate": 2,
    "about":
        "Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus."
  },
  {
    "id": 11,
    "doctor_name": "Amalita Varley",
    "email": "avarleya@github.com",
    "phone_num": "7421243057",
    "address": "0713 Fair Oaks Point",
    "doctor_img": "assets/doctors_img/doc2.jpg",
    "pecialty": "Office Assistant IV",
    "gender": "Female",
    "rate": 1,
    "about":
        "Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi."
  },
  {
    "id": 12,
    "doctor_name": "Pernell Gogan",
    "email": "pgoganb@disqus.com",
    "phone_num": "3928063043",
    "address": "0732 Monterey Point",
    "doctor_img": "assets/doctors_img/doc3.jpg",
    "pecialty": "Technical Writer",
    "gender": "Male",
    "rate": 3,
    "about":
        "Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue."
  },
  {
    "id": 13,
    "doctor_name": "Cornelius Cottill",
    "email": "ccottillc@vk.com",
    "phone_num": "8443023722",
    "address": "466 Roxbury Point",
    "doctor_img": "assets/doctors_img/doc1.jpg",
    "pecialty": "Automation Specialist II",
    "gender": "Male",
    "rate": 1,
    "about":
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat."
  },
  {
    "id": 14,
    "doctor_name": "Katusha Franke",
    "email": "kfranked@yandex.ru",
    "phone_num": "8515607176",
    "address": "19801 Stoughton Place",
    "doctor_img": "assets/doctors_img/doc2.jpg",
    "pecialty": "Software Engineer I",
    "gender": "Female",
    "rate": 1,
    "about":
        "In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti."
  },
  {
    "id": 15,
    "doctor_name": "Meyer Slayny",
    "email": "mslaynye@google.es",
    "phone_num": "6971525632",
    "address": "341 Dottie Point",
    "doctor_img": "assets/doctors_img/doc3.jpg",
    "pecialty": "Analyst Programmer",
    "gender": "Male",
    "rate": 5,
    "about":
        "Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet."
  },
  {
    "id": 16,
    "doctor_name": "Andras Gaynsford",
    "email": "agaynsfordf@engadget.com",
    "phone_num": "9581377449",
    "address": "9877 Bluejay Parkway",
    "doctor_img": "assets/doctors_img/doc1.jpg",
    "pecialty": "Operator",
    "gender": "Male",
    "rate": 1,
    "about":
        "Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa."
  },
  {
    "id": 17,
    "doctor_name": "Iorgos Scholar",
    "email": "ischolarg@nationalgeographic.com",
    "phone_num": "4813147472",
    "address": "38894 Crest Line Park",
    "doctor_img": "assets/doctors_img/doc2.jpg",
    "pecialty": "Statistician IV",
    "gender": "Male",
    "rate": 2,
    "about":
        "In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum."
  },
  {
    "id": 18,
    "doctor_name": "Carleton Denisovich",
    "email": "cdenisovichh@alexa.com",
    "phone_num": "6058949014",
    "address": "90 Granby Center",
    "doctor_img": "assets/doctors_img/doc3.jpg",
    "pecialty": "Account Representative II",
    "gender": "Male",
    "rate": 5,
    "about":
        "Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum."
  },
  {
    "id": 19,
    "doctor_name": "Caprice Kneeland",
    "email": "ckneelandi@addtoany.com",
    "phone_num": "2355591197",
    "address": "58 Carey Park",
    "doctor_img": "assets/doctors_img/doc1.jpg",
    "pecialty": "Associate Professor",
    "gender": "Female",
    "rate": 5,
    "about":
        "Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam."
  },
  {
    "id": 20,
    "doctor_name": "Petronia Lared",
    "email": "plaredj@hp.com",
    "phone_num": "1841575473",
    "address": "30892 Hagan Park",
    "doctor_img": "assets/doctors_img/doc2.jpg",
    "pecialty": "VP Quality Control",
    "gender": "Female",
    "rate": 5,
    "about":
        "Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum."
  }
];
