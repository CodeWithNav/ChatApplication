import 'package:chat/global/Locator.dart';
import 'package:chat/models/User.dart';
import 'package:chat/repository_impl/UserRepository_impl.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  List<AppUser>? _users;
  int selectedFriend = -1;
  List<AppUser>? get users => _users;

  UserRepository_Impl _userRepository = getIt<UserRepository_Impl>();

  setUp() async {
    _users = await _userRepository.getAllUser();
    notifyListeners();
  }

  HomeViewModel() {
    setUp();
  }
  setSelectedFriend(int v) {
    selectedFriend = v;
    notifyListeners();
  }
}
