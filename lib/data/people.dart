//* 1. Kelas Person
class Person{
  final String name;
  final String phone;
  final String picture;
  const Person(this.name,this.phone,this.picture);
}

//* 2. Variabel List dengan nama people yang memiliki data bertipe object Person, yang merupakan
//* hasil mapping data list pada baris 14 kebawah
final List<Person> people =
      _people.map((e) => Person(e['name'] as String,e['phone'] as String,e['picture'] as String)).toList(growable: false);

final List<Map<String,Object>> _people =
  [
  {
    "_id": "65017049fe547a3a3f86fe76",
    "index": 0,
    "guid": "7d184afe-a4ca-4122-adf7-a97fbb482e34",
    "isActive": false,
    "balance": "\$3,659.46",
    "picture": "http://placehold.it/32x32",
    "age": 20,
    "eyeColor": "blue",
    "name": "Vanessa Roberts",
    "gender": "female",
    "company": "SOPRANO",
    "email": "vanessaroberts@soprano.com",
    "phone": "+1 (802) 515-2929",
    "address": "469 Pitkin Avenue, Highland, Illinois, 6858",
    "about": "Aliqua id aliquip ea irure deserunt magna. Quis ullamco consequat nulla ipsum aute ea cillum qui est tempor non. Anim ad exercitation voluptate velit cillum incididunt magna ut velit ut dolor tempor dolor. Mollit exercitation culpa sit elit. Dolor ullamco anim commodo nostrud sunt laborum consectetur sit magna. Enim enim aute ullamco nostrud minim eiusmod duis reprehenderit quis reprehenderit qui elit sit. Amet laborum id proident reprehenderit elit elit veniam excepteur do consequat amet et cillum.\r\n",
    "registered": "2015-05-18T06:46:56 -07:00",
    "latitude": -82.05435,
    "longitude": -113.221236,
    "tags": [
      "dolore",
      "aliqua",
      "non",
      "amet",
      "aliqua",
      "tempor",
      "elit"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Payne Moon"
      },
      {
        "id": 1,
        "name": "Moore Good"
      },
      {
        "id": 2,
        "name": "Mara Tyson"
      }
    ],
    "greeting": "Hello, Vanessa Roberts! You have 3 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "650170498ab5e0caf889a4bd",
    "index": 1,
    "guid": "a79f60dc-09bb-476d-9048-63023b5329db",
    "isActive": false,
    "balance": "\$3,301.46",
    "picture": "http://placehold.it/32x32",
    "age": 34,
    "eyeColor": "brown",
    "name": "Delores Combs",
    "gender": "female",
    "company": "PORTALIS",
    "email": "delorescombs@portalis.com",
    "phone": "+1 (876) 586-3909",
    "address": "890 Horace Court, Eastmont, Guam, 3534",
    "about": "Commodo sunt fugiat cillum labore tempor exercitation dolore. Dolor velit ad proident labore labore cupidatat voluptate cillum eu tempor officia. Exercitation ea aliqua elit exercitation. Proident et irure culpa Lorem ipsum ex reprehenderit est cupidatat est id. Magna nostrud amet officia irure ex sit mollit non id exercitation non. Consequat ea deserunt aliqua nulla veniam.\r\n",
    "registered": "2022-06-14T05:25:39 -07:00",
    "latitude": 83.538105,
    "longitude": 30.80209,
    "tags": [
      "officia",
      "ut",
      "Lorem",
      "velit",
      "sint",
      "labore",
      "consectetur"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Finley Humphrey"
      },
      {
        "id": 1,
        "name": "Mann Lamb"
      },
      {
        "id": 2,
        "name": "Weaver Nelson"
      }
    ],
    "greeting": "Hello, Delores Combs! You have 6 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "6501704932229b478c3a0716",
    "index": 2,
    "guid": "2ce1fc26-ccda-445c-8723-8e231b166460",
    "isActive": true,
    "balance": "\$3,587.23",
    "picture": "http://placehold.it/32x32",
    "age": 28,
    "eyeColor": "green",
    "name": "Jordan Rosales",
    "gender": "male",
    "company": "XEREX",
    "email": "jordanrosales@xerex.com",
    "phone": "+1 (984) 438-2120",
    "address": "752 Waldane Court, Harrodsburg, Alaska, 7551",
    "about": "Sint deserunt laboris est ullamco amet duis anim ullamco nisi mollit dolore consectetur cupidatat quis. Nisi enim adipisicing officia anim qui amet quis. Officia nisi esse id ea incididunt ea duis amet irure consectetur. Officia sit fugiat eu ut qui ipsum labore nostrud. Veniam ea enim id voluptate cupidatat enim proident eu. Incididunt dolore cupidatat voluptate nisi tempor quis. Sint adipisicing non laborum aliqua duis Lorem veniam in.\r\n",
    "registered": "2015-01-22T10:28:26 -07:00",
    "latitude": -17.578576,
    "longitude": -9.089813,
    "tags": [
      "Lorem",
      "dolore",
      "sit",
      "id",
      "aliquip",
      "consequat",
      "ea"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Jerry Dennis"
      },
      {
        "id": 1,
        "name": "Mcmillan Barnes"
      },
      {
        "id": 2,
        "name": "Greene Lambert"
      }
    ],
    "greeting": "Hello, Jordan Rosales! You have 10 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "650170496d122ba31cd72da1",
    "index": 3,
    "guid": "12ab61f4-9cf9-4312-ba15-fb7d24b8531a",
    "isActive": true,
    "balance": "\$2,014.31",
    "picture": "http://placehold.it/32x32",
    "age": 21,
    "eyeColor": "blue",
    "name": "Cara Simmons",
    "gender": "female",
    "company": "ZEPITOPE",
    "email": "carasimmons@zepitope.com",
    "phone": "+1 (955) 596-3059",
    "address": "982 Rutledge Street, Turpin, Mississippi, 1046",
    "about": "Culpa irure ex velit est ut non amet qui non minim elit aliqua cillum exercitation. Dolor consequat cillum in cupidatat est cupidatat duis dolor laborum anim ut veniam. Sit ut consequat reprehenderit commodo.\r\n",
    "registered": "2020-10-13T11:47:02 -07:00",
    "latitude": -32.108816,
    "longitude": 175.343385,
    "tags": [
      "fugiat",
      "quis",
      "adipisicing",
      "reprehenderit",
      "exercitation",
      "ipsum",
      "ullamco"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Simpson Santana"
      },
      {
        "id": 1,
        "name": "Lana Rowe"
      },
      {
        "id": 2,
        "name": "Mosley Dominguez"
      }
    ],
    "greeting": "Hello, Cara Simmons! You have 6 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "650170495523ed702e786bcb",
    "index": 4,
    "guid": "bbda437b-924a-4fba-bc1b-533154d5eda4",
    "isActive": false,
    "balance": "\$1,904.85",
    "picture": "http://placehold.it/32x32",
    "age": 35,
    "eyeColor": "green",
    "name": "Wanda Wilcox",
    "gender": "female",
    "company": "ACCUPRINT",
    "email": "wandawilcox@accuprint.com",
    "phone": "+1 (966) 401-2904",
    "address": "761 Remsen Street, Ona, Maryland, 5434",
    "about": "Aute nulla irure ad occaecat. Cupidatat labore officia sunt culpa consectetur id qui elit officia est cupidatat nulla et consequat. Tempor id aliquip esse nostrud voluptate laborum. Dolor ut mollit irure esse.\r\n",
    "registered": "2018-04-19T05:45:33 -07:00",
    "latitude": -66.629248,
    "longitude": -132.521235,
    "tags": [
      "id",
      "enim",
      "veniam",
      "elit",
      "cillum",
      "adipisicing",
      "deserunt"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Blackburn Haynes"
      },
      {
        "id": 1,
        "name": "Hogan Griffin"
      },
      {
        "id": 2,
        "name": "Adeline Pace"
      }
    ],
    "greeting": "Hello, Wanda Wilcox! You have 1 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "6501704957891e15456f6d40",
    "index": 5,
    "guid": "fdbf053b-ee62-4eee-a1a0-8188c832b777",
    "isActive": false,
    "balance": "\$1,151.22",
    "picture": "http://placehold.it/32x32",
    "age": 35,
    "eyeColor": "brown",
    "name": "Alyssa Tanner",
    "gender": "female",
    "company": "MANGELICA",
    "email": "alyssatanner@mangelica.com",
    "phone": "+1 (845) 471-3313",
    "address": "245 Montague Street, Grahamtown, North Dakota, 4326",
    "about": "Officia aute occaecat id est enim reprehenderit irure et elit. Magna aliqua ipsum aliquip consequat voluptate mollit tempor voluptate ullamco. Lorem minim elit aliqua tempor. Tempor pariatur do ex anim eiusmod tempor eiusmod enim esse culpa minim cupidatat labore Lorem. Consectetur irure eiusmod exercitation consequat pariatur culpa do ad occaecat voluptate esse irure Lorem. Eiusmod veniam excepteur labore velit laboris mollit anim adipisicing sunt mollit id voluptate qui.\r\n",
    "registered": "2021-01-18T12:44:49 -07:00",
    "latitude": 61.899648,
    "longitude": 153.258772,
    "tags": [
      "deserunt",
      "ipsum",
      "consectetur",
      "Lorem",
      "veniam",
      "nulla",
      "voluptate"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Paula Flowers"
      },
      {
        "id": 1,
        "name": "Dina Summers"
      },
      {
        "id": 2,
        "name": "Stephenson Witt"
      }
    ],
    "greeting": "Hello, Alyssa Tanner! You have 3 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "650170492d8053c4d57c4ca7",
    "index": 6,
    "guid": "b8e2ba36-67dc-4e2a-9b20-d488804d4320",
    "isActive": true,
    "balance": "\$3,893.07",
    "picture": "http://placehold.it/32x32",
    "age": 20,
    "eyeColor": "blue",
    "name": "Jan Montgomery",
    "gender": "female",
    "company": "QUILITY",
    "email": "janmontgomery@quility.com",
    "phone": "+1 (804) 526-3861",
    "address": "260 Miller Avenue, Talpa, District Of Columbia, 2140",
    "about": "Ad ullamco esse ad magna esse nulla. Ullamco fugiat Lorem quis elit proident incididunt ullamco fugiat eu amet. Et et magna quis elit excepteur duis Lorem deserunt irure cupidatat aliqua. Cupidatat laborum laborum officia voluptate incididunt anim reprehenderit non ad esse labore. Sit nulla minim pariatur ad sunt et. Cillum officia sint amet velit veniam non ad velit ullamco labore.\r\n",
    "registered": "2017-03-18T01:32:12 -07:00",
    "latitude": 55.805956,
    "longitude": -60.009307,
    "tags": [
      "duis",
      "reprehenderit",
      "occaecat",
      "laborum",
      "amet",
      "irure",
      "aliquip"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Young Henry"
      },
      {
        "id": 1,
        "name": "Jacobson Faulkner"
      },
      {
        "id": 2,
        "name": "Battle Fowler"
      }
    ],
    "greeting": "Hello, Jan Montgomery! You have 4 unread messages.",
    "favoriteFruit": "apple"
  }
];