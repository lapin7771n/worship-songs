import 'package:intl/intl.dart';

mixin StringResources {
  String get home => Intl.message('Home');

  String get myLyrics => Intl.message('My Lyrics');

  String get settings => Intl.message('Settings');

  String get login {
    return Intl.message('Login');
  }

  String get createNewAccount {
    return Intl.message('Create new Account');
  }

  String get iAlreadyHaveAnAccount {
    return Intl.message('I already have an Account');
  }

  String get passwordHasToInclude {
    return Intl.message('Password has to include at least 6 characters');
  }

  String get createPassword {
    return Intl.message('Create Password');
  }

  String get emailAddress {
    return Intl.message('Email Address');
  }

  String get thisDoesntLooksLikeEmailAddress {
    return Intl.message('This doesn’t looks like email address');
  }

  String yourPasswordContainChars(int length) {
    return Intl.message(
      'Your password contain $length/6 characters',
      name: 'yourPasswordContainChars',
      args: [length],
    );
  }

  String get continueWithGoogle {
    return Intl.message('Continue with Google');
  }

  String get error {
    return Intl.message('Error');
  }

  String get typeSongName {
    return Intl.message('Type song name, lyrics...');
  }

  String get cancel {
    return Intl.message('Cancel');
  }

  String get allLyrics {
    return Intl.message('All Lyrics');
  }

  String get accountSettings {
    return Intl.message('Account Settings');
  }

  String get changeEmailAddress {
    return Intl.message('Change email address');
  }

  String get notYetImplemented {
    return Intl.message('Not yet implemented');
  }

  String get changePassword {
    return Intl.message('Change password');
  }

  String get logout {
    return Intl.message('Logout');
  }

  String get changePasswordEmailLogout {
    return Intl.message('Change password, email, logout');
  }

  String get notification => Intl.message('Notifications');

  String get manageNotifications => Intl.message('Manage notifications');

  String get reportABug => Intl.message('Report about bug');

  String get couldNotLaunch => Intl.message('Could not launch');

  String get chords => Intl.message('Chords');

  String get writeUsALineAboutProblemYouHave =>
      Intl.message('Write us a line about problem you have');

  //
  // OnBoarding
  //

  String get wordsToPrayGod {
    return Intl.message('Words to Pray God');
  }

  String get playSongsYouLike {
    return Intl.message('Play songs you like');
  }

  String get theWordsOfTruth {
    return Intl.message('The words of truth');
  }

  String get findTheLyricsOfPopular {
    return Intl.message(
        'Find the lyrics of popular christian songs to sing with people you love');
  }

  String get besideLyricsYouAlso {
    return Intl.message(
        'Beside lyrics you also can find the chords for guitar and notes for piano!');
  }

  String get readTheGreatStories {
    return Intl.message(
        'Read the great stories of great people how God changes their lives!');
  }

  String get filters => Intl.message('Filters');

  String get reset => Intl.message('Reset');

  String get songLanguage => Intl.message('Song Language');

  String get apply => Intl.message('Apply');

  String get all => Intl.message('All');

  String get english => Intl.message('English');

  String get russian => Intl.message('Russian');

  String get ukrainian => Intl.message('Ukrainian');
}
