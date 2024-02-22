import 'package:foodeoapp/data/model/review_model.dart';

List<reviewModel> ReviewdummyData = [
  reviewModel(
    id: 1,
    productId: 101,
    userId: 201,
    userPicture:
        'https://i.pinimg.com/736x/99/b7/d4/99b7d429efb448a0839794ca065f0115.jpg',
    username: 'salman',
    comment: 'This is a great video!',
    rating: 4.5,
    createdAt: DateTime.now(),
    // updatedAt: DateTime.now(),
  ),
  reviewModel(
    id: 2,
    productId: 102,
    userId: 202,
    userPicture:
        'https://i.pinimg.com/736x/99/b7/d4/99b7d429efb448a0839794ca065f0115.jpg',
    username: 'yousuf',
    comment: 'Awesome product review.',
    rating: 5.0,
    createdAt: DateTime.now(),
    // updatedAt: DateTime.now(),
  ),
  reviewModel(
    id: 3,
    productId: 103,
    userId: 203,
    userPicture:
        'https://i.pinimg.com/736x/99/b7/d4/99b7d429efb448a0839794ca065f0115.jpg',
    username: 'kamlesh',
    comment: "I didn't like it much. ",
    rating: 3.0,
    createdAt: DateTime.now(),
    // updatedAt: DateTime.now(),
  ),
];
