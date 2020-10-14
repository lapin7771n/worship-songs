// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'messages';

  static m0(count) => "${Intl.plural(count, one: 'Album', other: 'Albums')}";

  static m1(count) => "${Intl.plural(count, one: 'Artist', other: 'Artists')}";

  static m2(length) => "Your password contain ${length}/6 characters";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "Accept" : MessageLookupByLibrary.simpleMessage("Accept"),
    "Account Settings" : MessageLookupByLibrary.simpleMessage("Account Settings"),
    "Admin Portal" : MessageLookupByLibrary.simpleMessage("Admin Portal"),
    "All" : MessageLookupByLibrary.simpleMessage("All"),
    "All Lyrics" : MessageLookupByLibrary.simpleMessage("All Lyrics"),
    "Already have an Account" : MessageLookupByLibrary.simpleMessage("Already have an Account"),
    "Apply" : MessageLookupByLibrary.simpleMessage("Apply"),
    "Are you sure you want to delete this artist? If deleted, artist will no longer be available to all users." : MessageLookupByLibrary.simpleMessage("Are you sure you want to delete this artist? If deleted, artist will no longer be available to all users."),
    "Are you sure you want to delete this lyrics? If deleted, album will no longer be available to all users." : MessageLookupByLibrary.simpleMessage("Are you sure you want to delete this lyrics? If deleted, album will no longer be available to all users."),
    "Are you sure you want to delete this lyrics? If deleted, lyrics will no longer be available to all users." : MessageLookupByLibrary.simpleMessage("Are you sure you want to delete this lyrics? If deleted, lyrics will no longer be available to all users."),
    "Artist Description" : MessageLookupByLibrary.simpleMessage("Artist Description"),
    "Artist Title" : MessageLookupByLibrary.simpleMessage("Artist Title"),
    "Assign Artist" : MessageLookupByLibrary.simpleMessage("Assign Artist"),
    "Assign to Album" : MessageLookupByLibrary.simpleMessage("Assign to Album"),
    "Beside lyrics you also can find the chords for guitar and notes for piano!" : MessageLookupByLibrary.simpleMessage("Beside lyrics you also can find the chords for guitar and notes for piano!"),
    "Browse our lyrics catalogue and find something for yourself" : MessageLookupByLibrary.simpleMessage("Browse our lyrics catalogue and find something for yourself"),
    "Cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "Catalog" : MessageLookupByLibrary.simpleMessage("Catalog"),
    "Change email address" : MessageLookupByLibrary.simpleMessage("Change email address"),
    "Change password" : MessageLookupByLibrary.simpleMessage("Change password"),
    "Change password, email, logout" : MessageLookupByLibrary.simpleMessage("Change password, email, logout"),
    "Chords" : MessageLookupByLibrary.simpleMessage("Chords"),
    "Content delete error" : MessageLookupByLibrary.simpleMessage("Content delete error"),
    "Content successfully deleted" : MessageLookupByLibrary.simpleMessage("Content successfully deleted"),
    "Could not launch" : MessageLookupByLibrary.simpleMessage("Could not launch"),
    "Create Password" : MessageLookupByLibrary.simpleMessage("Create Password"),
    "Creating" : MessageLookupByLibrary.simpleMessage("Creating"),
    "Database Match" : MessageLookupByLibrary.simpleMessage("Database Match"),
    "Date and Time" : MessageLookupByLibrary.simpleMessage("Date and Time"),
    "Delete Album" : MessageLookupByLibrary.simpleMessage("Delete Album"),
    "Delete Artist" : MessageLookupByLibrary.simpleMessage("Delete Artist"),
    "Delete Lyrics" : MessageLookupByLibrary.simpleMessage("Delete Lyrics"),
    "Delete Photo" : MessageLookupByLibrary.simpleMessage("Delete Photo"),
    "Describe this Artist" : MessageLookupByLibrary.simpleMessage("Describe this Artist"),
    "Easier way to login" : MessageLookupByLibrary.simpleMessage("Easier way to login"),
    "Edit" : MessageLookupByLibrary.simpleMessage("Edit"),
    "Email Address" : MessageLookupByLibrary.simpleMessage("Email Address"),
    "English" : MessageLookupByLibrary.simpleMessage("English"),
    "Error" : MessageLookupByLibrary.simpleMessage("Error"),
    "Explore Lyrics" : MessageLookupByLibrary.simpleMessage("Explore Lyrics"),
    "File should not be bigger than" : MessageLookupByLibrary.simpleMessage("File should not be bigger than"),
    "Filters" : MessageLookupByLibrary.simpleMessage("Filters"),
    "Find the lyrics of popular christian songs to sing with people you love" : MessageLookupByLibrary.simpleMessage("Find the lyrics of popular christian songs to sing with people you love"),
    "General Info" : MessageLookupByLibrary.simpleMessage("General Info"),
    "Go to the admin portal" : MessageLookupByLibrary.simpleMessage("Go to the admin portal"),
    "Home" : MessageLookupByLibrary.simpleMessage("Home"),
    "How to Add Chords" : MessageLookupByLibrary.simpleMessage("How to Add Chords"),
    "It’s really save!" : MessageLookupByLibrary.simpleMessage("It’s really save!"),
    "Language" : MessageLookupByLibrary.simpleMessage("Language"),
    "Loading..." : MessageLookupByLibrary.simpleMessage("Loading..."),
    "Login" : MessageLookupByLibrary.simpleMessage("Login"),
    "Logout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "Lyrics" : MessageLookupByLibrary.simpleMessage("Lyrics"),
    "Lyrics Title" : MessageLookupByLibrary.simpleMessage("Lyrics Title"),
    "Lyrics and Chords" : MessageLookupByLibrary.simpleMessage("Lyrics and Chords"),
    "Manage notifications" : MessageLookupByLibrary.simpleMessage("Manage notifications"),
    "My Lyrics" : MessageLookupByLibrary.simpleMessage("My Lyrics"),
    "No Album Assigned" : MessageLookupByLibrary.simpleMessage("No Album Assigned"),
    "No Artist Assigned" : MessageLookupByLibrary.simpleMessage("No Artist Assigned"),
    "No Lyrics Added" : MessageLookupByLibrary.simpleMessage("No Lyrics Added"),
    "No match found" : MessageLookupByLibrary.simpleMessage("No match found"),
    "No more passwords to forgot" : MessageLookupByLibrary.simpleMessage("No more passwords to forgot"),
    "No new requests" : MessageLookupByLibrary.simpleMessage("No new requests"),
    "Not yet implemented" : MessageLookupByLibrary.simpleMessage("Not yet implemented"),
    "Notifications" : MessageLookupByLibrary.simpleMessage("Notifications"),
    "Or" : MessageLookupByLibrary.simpleMessage("Or"),
    "Password" : MessageLookupByLibrary.simpleMessage("Password"),
    "Password has to include at least 6 characters" : MessageLookupByLibrary.simpleMessage("Password has to include at least 6 characters"),
    "Play songs you like" : MessageLookupByLibrary.simpleMessage("Play songs you like"),
    "Preview" : MessageLookupByLibrary.simpleMessage("Preview"),
    "Read the great stories of great people how God changes their lives!" : MessageLookupByLibrary.simpleMessage("Read the great stories of great people how God changes their lives!"),
    "Reject" : MessageLookupByLibrary.simpleMessage("Reject"),
    "Report about bug" : MessageLookupByLibrary.simpleMessage("Report about bug"),
    "Request Info" : MessageLookupByLibrary.simpleMessage("Request Info"),
    "Requested by" : MessageLookupByLibrary.simpleMessage("Requested by"),
    "Requests" : MessageLookupByLibrary.simpleMessage("Requests"),
    "Reset" : MessageLookupByLibrary.simpleMessage("Reset"),
    "Russian" : MessageLookupByLibrary.simpleMessage("Russian"),
    "Save" : MessageLookupByLibrary.simpleMessage("Save"),
    "Select new photo from gallery" : MessageLookupByLibrary.simpleMessage("Select new photo from gallery"),
    "Settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "Sign Up" : MessageLookupByLibrary.simpleMessage("Sign Up"),
    "Sign up with E-Mail" : MessageLookupByLibrary.simpleMessage("Sign up with E-Mail"),
    "Song Language" : MessageLookupByLibrary.simpleMessage("Song Language"),
    "Start" : MessageLookupByLibrary.simpleMessage("Start"),
    "Success" : MessageLookupByLibrary.simpleMessage("Success"),
    "The words of truth" : MessageLookupByLibrary.simpleMessage("The words of truth"),
    "This doesn’t looks like email address" : MessageLookupByLibrary.simpleMessage("This doesn’t looks like email address"),
    "To add chords to the lyrics insert “.”(Dot Sign) at start of Chords String" : MessageLookupByLibrary.simpleMessage("To add chords to the lyrics insert “.”(Dot Sign) at start of Chords String"),
    "Type artist name..." : MessageLookupByLibrary.simpleMessage("Type artist name..."),
    "Type song name, lyrics..." : MessageLookupByLibrary.simpleMessage("Type song name, lyrics..."),
    "Ukrainian" : MessageLookupByLibrary.simpleMessage("Ukrainian"),
    "Using Social Media Login you will save tremendous amount of time " : MessageLookupByLibrary.simpleMessage("Using Social Media Login you will save tremendous amount of time "),
    "Version" : MessageLookupByLibrary.simpleMessage("Version"),
    "We respect your time!" : MessageLookupByLibrary.simpleMessage("We respect your time!"),
    "Words to Pray God" : MessageLookupByLibrary.simpleMessage("Words to Pray God"),
    "Worship Songs" : MessageLookupByLibrary.simpleMessage("Worship Songs"),
    "Write us a line about problem you have" : MessageLookupByLibrary.simpleMessage("Write us a line about problem you have"),
    "albums" : m0,
    "artists" : m1,
    "ex. Alive" : MessageLookupByLibrary.simpleMessage("ex. Alive"),
    "ex. Room For More" : MessageLookupByLibrary.simpleMessage("ex. Room For More"),
    "ex. Way Maker" : MessageLookupByLibrary.simpleMessage("ex. Way Maker"),
    "yourPasswordContainChars" : m2
  };
}
