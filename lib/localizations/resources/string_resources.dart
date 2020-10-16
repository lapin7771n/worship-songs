import 'package:intl/intl.dart';

mixin StringResources {
  String get home => Intl.message('Home');

  String get myLyrics => Intl.message('My Lyrics');

  String get settings => Intl.message('Settings');

  String get login {
    return Intl.message('Login');
  }

  String get alreadyHaveAnAccount {
    return Intl.message('Already have an Account');
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

  String get password => Intl.message('Password');

  String get worshipSongs => Intl.message('Worship Songs');

  String get version => Intl.message('Version');

  String get noLyricsAdded => Intl.message('No Lyrics Added');

  String get browseOurLyricsCatalogue => Intl.message(
      'Browse our lyrics catalogue and find something for yourself');

  String get exploreLyrics => Intl.message('Explore Lyrics');

  String getLanguageByCode(String languageCode) {
    switch (languageCode) {
      case 'en':
        return english;
      case 'ua':
        return ukrainian;
      case 'ru':
        return russian;
    }
    return null;
  }

  String get adminPortal => Intl.message('Admin Portal');

  String get goToAdminPortal => Intl.message('Go to the admin portal');

  String get requests => Intl.message('Requests');

  String get catalog => Intl.message('Catalog');

  String albums(int count) => Intl.plural(
        count,
        one: 'Album',
        other: 'Albums',
        name: 'albums',
        args: [count],
      );

  String get lyrics => Intl.message('Lyrics');

  String artists(int count) => Intl.plural(
        count,
        one: 'Artist',
        other: 'Artists',
        name: 'artists',
        args: [count],
      );

  String get creating => Intl.message('Creating');

  String get generalInfo => Intl.message('General Info');

  String get noAlbumAssigned => Intl.message('No Album Assigned');

  String get assignToAlbum => Intl.message('Assign to Album');

  String get databaseMatch => Intl.message('Database Match');

  String get requestInfo => Intl.message('Request Info');

  String get requestedBy => Intl.message('Requested by');

  String get dateAndTime => Intl.message('Date and Time');

  String get noMatchFound => Intl.message('No match found');

  String get edit => Intl.message('Edit');

  String get exampleWayMaker => Intl.message('ex. Way Maker');

  String get lyricsTitle => Intl.message('Lyrics Title');

  String get accept => Intl.message('Accept');

  String get reject => Intl.message('Reject');

  String get artistTitle => Intl.message('Artist Title');

  String get exampleRoomForMore => Intl.message('ex. Room For More');

  String get artistDescription => Intl.message('Artist Description');

  String get fileShouldNotBeBigger =>
      Intl.message('File should not be bigger than');

  String get describeThisArtist => Intl.message('Describe this Artist');

  String get selectNewPhotoFromGallery =>
      Intl.message('Select new photo from gallery');

  String get deletePhoto => Intl.message('Delete Photo');

  String get success => Intl.message('Success');

  String get noArtistAssigned => Intl.message('No Artist Assigned');

  String get assignArtist => Intl.message('Assign Artist');

  String get typeArtistName => Intl.message('Type artist name...');

  String get howToAddChords => Intl.message('How to Add Chords');

  String get toAddChordsToTheLyrics => Intl.message(
        'To add chords to the lyrics insert “.”(Dot Sign) at start of Chords String',
      );

  String get lyricsAndChords => Intl.message('Lyrics and Chords');

  String get loading => Intl.message('Loading...');

  String get noNewRequests => Intl.message('No new requests');

  String get preview => Intl.message('Preview');

  String get contentSuccessfullyDeleted =>
      Intl.message('Content successfully deleted');

  String get contentDeleteError => Intl.message('Content delete error');

  String get exampleAlive => Intl.message('ex. Alive');

  String get start => Intl.message('Start');

  String get easierWayToLogin => Intl.message('Easier way to login');

  String get weRespectYourTime => Intl.message('We respect your time!');

  String get usingSocialMediaLoginYouWill => Intl.message(
      'Using Social Media Login you will save tremendous amount of time ');

  String get itsReallySave => Intl.message('It’s really save!');

  String get noMorePasswordsToForgot =>
      Intl.message('No more passwords to forgot');

  String get or => Intl.message('Or');

  String get signUpWithEmail => Intl.message('Sign up with E-Mail');

  String get signUp => Intl.message('Sign Up');

  String get language => Intl.message('Language');

  String get save => Intl.message('Save');

  String get deleteArtist => Intl.message('Delete Artist');

  String get deleteLyrics => Intl.message('Delete Lyrics');

  String get deleteAlbum => Intl.message('Delete Album');

  String get deleteArtistMessage => Intl.message(
        'Are you sure you want to delete this artist? If deleted, artist will no longer be available to all users.',
      );

  String get deleteLyricsMessage => Intl.message(
        'Are you sure you want to delete this lyrics? If deleted, lyrics will no longer be available to all users.',
      );

  String get deleteAlbumMessage => Intl.message(
        'Are you sure you want to delete this lyrics? If deleted, album will no longer be available to all users.',
      );
  String get about => Intl.message('About');

  String get popularLyrics => Intl.message('Popular Lyrics');

  String get viewAllLyrics => Intl.message('View All Lyrics');
}
