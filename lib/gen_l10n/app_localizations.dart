import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// Overview
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// Inbox
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get inbox;

  /// Calendar
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// MyPICOS
  ///
  /// In en, this message translates to:
  /// **'MyPICOS'**
  String get myPicos;

  /// My medications
  ///
  /// In en, this message translates to:
  /// **'My medications'**
  String get myMedications;

  /// Morning
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get inTheMorning;

  /// Evening
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get inTheEvening;

  /// Noon
  ///
  /// In en, this message translates to:
  /// **'Noon'**
  String get noon;

  /// To the night
  ///
  /// In en, this message translates to:
  /// **'To the night'**
  String get toTheNight;

  /// Unit
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// Unit
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get medicalProduct;

  /// Add medication
  ///
  /// In en, this message translates to:
  /// **'Add medication'**
  String get addMedication;

  /// Edit medication
  ///
  /// In en, this message translates to:
  /// **'Edit medication'**
  String get editMedication;

  /// Patient advice for adding medication schedules. (Part 1)
  ///
  /// In en, this message translates to:
  /// **'Please enter '**
  String get addMedicationInfoPart1;

  /// Patient advice for adding medication schedules. (Part 2)
  ///
  /// In en, this message translates to:
  /// **'accurate and current medication schedules'**
  String get addMedicationInfoPart2;

  /// Patient advice for adding medication schedules. (Part 3)
  ///
  /// In en, this message translates to:
  /// **'. These can be be of great use to the treating facilities and be incorporated into your treatment.'**
  String get addMedicationInfoPart3;

  /// Enter compound
  ///
  /// In en, this message translates to:
  /// **'Enter compound'**
  String get enterCompound;

  /// Compound
  ///
  /// In en, this message translates to:
  /// **'Compound'**
  String get compound;

  /// Intake
  ///
  /// In en, this message translates to:
  /// **'Intake'**
  String get intake;

  /// Add
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// Save
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// My health
  ///
  /// In en, this message translates to:
  /// **'My health'**
  String get myHealth;

  /// Medical data
  ///
  /// In en, this message translates to:
  /// **'Medical data'**
  String get medicalData;

  /// Medication scheme
  ///
  /// In en, this message translates to:
  /// **'Medication scheme'**
  String get medicationScheme;

  /// Physicians
  ///
  /// In en, this message translates to:
  /// **'Physicians'**
  String get physicians;

  /// Family members
  ///
  /// In en, this message translates to:
  /// **'Family members'**
  String get familyMembers;

  /// Documents
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documents;

  /// More
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// Notifications
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Profile
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Privacy notice
  ///
  /// In en, this message translates to:
  /// **'Privacy notice'**
  String get privacyNotice;

  /// Legals
  ///
  /// In en, this message translates to:
  /// **'Legals'**
  String get legals;

  /// Logout
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Father
  ///
  /// In en, this message translates to:
  /// **'Father'**
  String get father;

  /// No description provided for @mother.
  ///
  /// In en, this message translates to:
  /// **'Mother'**
  String get mother;

  /// Brother
  ///
  /// In en, this message translates to:
  /// **'Brother'**
  String get brother;

  /// Sister
  ///
  /// In en, this message translates to:
  /// **'Sister'**
  String get sister;

  /// Life partner
  ///
  /// In en, this message translates to:
  /// **'Life partner'**
  String get lifePartner;

  /// Edit
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Delete
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Mr.
  ///
  /// In en, this message translates to:
  /// **'Mr.'**
  String get mr;

  /// Mrs.
  ///
  /// In en, this message translates to:
  /// **'Mrs.'**
  String get mrs;

  /// Diverse
  ///
  /// In en, this message translates to:
  /// **'Diverse'**
  String get diverse;

  /// Choose your family member
  ///
  /// In en, this message translates to:
  /// **'Choose your family member'**
  String get chooseFamilyMember;

  /// Title
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// First name
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// Family name
  ///
  /// In en, this message translates to:
  /// **'Family name'**
  String get familyName;

  /// E-Mail
  ///
  /// In en, this message translates to:
  /// **'E-Mail'**
  String get email;

  /// Telephone number
  ///
  /// In en, this message translates to:
  /// **'Telephone number'**
  String get phoneNumber;

  /// Cell phone
  ///
  /// In en, this message translates to:
  /// **'Cell phone'**
  String get mobilePhone;

  /// Address
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// Abort
  ///
  /// In en, this message translates to:
  /// **'Abort'**
  String get abort;

  /// Continue
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get proceed;

  /// My Entries
  ///
  /// In en, this message translates to:
  /// **'My Entries'**
  String get myEntries;

  /// How do I feel today?
  ///
  /// In en, this message translates to:
  /// **'How do I feel today?'**
  String get howFeel;

  /// The data is transmitted.
  ///
  /// In en, this message translates to:
  /// **'The data is transmitted.'**
  String get submitData;

  /// Husband
  ///
  /// In en, this message translates to:
  /// **'Husband'**
  String get husband;

  /// Spouse
  ///
  /// In en, this message translates to:
  /// **'Spouse'**
  String get spouse;

  /// Siblings
  ///
  /// In en, this message translates to:
  /// **'Siblings'**
  String get siblings;

  /// Roommates
  ///
  /// In en, this message translates to:
  /// **'Roommates'**
  String get roommates;

  /// Other relatives
  ///
  /// In en, this message translates to:
  /// **'Other relatives'**
  String get otherRelatives;

  /// Edit family member
  ///
  /// In en, this message translates to:
  /// **'Edit family member'**
  String get editFamilyMember;

  /// Type of relation
  ///
  /// In en, this message translates to:
  /// **'Type of relation'**
  String get typeOfRelation;

  /// Wife
  ///
  /// In en, this message translates to:
  /// **'Wife'**
  String get wife;

  /// Please enter the e-mail-address!
  ///
  /// In en, this message translates to:
  /// **'Please enter the e-mail-address!'**
  String get entryEmail;

  /// Please enter a valid e-mail-address!
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid e-mail-address!'**
  String get entryValidEmail;

  /// Please enter the first name!
  ///
  /// In en, this message translates to:
  /// **'Please enter the first name!'**
  String get entryFirstName;

  /// Please enter the family name!
  ///
  /// In en, this message translates to:
  /// **'Please enter the family name!'**
  String get entryFamilyName;

  /// Please enter the address!
  ///
  /// In en, this message translates to:
  /// **'Please enter the address!'**
  String get entryAddress;

  /// Please enter the phone number!
  ///
  /// In en, this message translates to:
  /// **'Please enter the phone number!'**
  String get entryPhoneNumber;

  /// My physicians
  ///
  /// In en, this message translates to:
  /// **'My physicians'**
  String get myPhysicians;

  /// Practice
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get practice;

  /// Name of practice
  ///
  /// In en, this message translates to:
  /// **'Name of practice'**
  String get practiceName;

  /// Website
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// Ophthalmology
  ///
  /// In en, this message translates to:
  /// **'Ophthalmology'**
  String get ophthalmology;

  /// Gynecology
  ///
  /// In en, this message translates to:
  /// **'Gynecology'**
  String get gynecology;

  /// Otolaryngology
  ///
  /// In en, this message translates to:
  /// **'Otolaryngology'**
  String get otolaryngology;

  /// General practitioner
  ///
  /// In en, this message translates to:
  /// **'General practitioner'**
  String get generalPractitioner;

  /// Skin and venereal diseases
  ///
  /// In en, this message translates to:
  /// **'Skin and venereal diseases'**
  String get skinAndVenerealDiseases;

  /// Internal medicine
  ///
  /// In en, this message translates to:
  /// **'Internal medicine'**
  String get internalMedicine;

  /// Microbiology
  ///
  /// In en, this message translates to:
  /// **'Microbiology'**
  String get microbiology;

  /// Neurology
  ///
  /// In en, this message translates to:
  /// **'Neurology'**
  String get neurology;

  /// Pathology
  ///
  /// In en, this message translates to:
  /// **'Pathology'**
  String get pathology;

  /// Pulmonology
  ///
  /// In en, this message translates to:
  /// **'Pulmonology'**
  String get pulmonology;

  /// Psychiatry
  ///
  /// In en, this message translates to:
  /// **'Psychiatry'**
  String get psychiatry;

  /// Urology
  ///
  /// In en, this message translates to:
  /// **'Urology'**
  String get urology;

  /// Add family member
  ///
  /// In en, this message translates to:
  /// **'Add family member'**
  String get addFamilyMember;

  /// Add physician
  ///
  /// In en, this message translates to:
  /// **'Add physician'**
  String get addPhysician;

  /// Edit physician
  ///
  /// In en, this message translates to:
  /// **'Edit physician'**
  String get editPhysician;

  /// Choose your medical field
  ///
  /// In en, this message translates to:
  /// **'Choose your medical field'**
  String get chooseField;

  /// Please enter the website!
  ///
  /// In en, this message translates to:
  /// **'Please enter the website!'**
  String get entryWebsite;

  /// Please enter a valid website!
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid website!'**
  String get entryValidWebsite;

  /// Please enter the practice name!
  ///
  /// In en, this message translates to:
  /// **'Please enter the practice name!'**
  String get entryPracticeName;

  /// My medical data
  ///
  /// In en, this message translates to:
  /// **'My medical data'**
  String get myMedicalData;

  /// Submitted values (14 days)
  ///
  /// In en, this message translates to:
  /// **'Submitted values (14 days)'**
  String get submittedValues;

  /// days
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// month
  ///
  /// In en, this message translates to:
  /// **'month'**
  String get month;

  /// months
  ///
  /// In en, this message translates to:
  /// **'months'**
  String get months;

  /// Configuration
  ///
  /// In en, this message translates to:
  /// **'Configuration'**
  String get configuration;

  /// Start configuration
  ///
  /// In en, this message translates to:
  /// **'Start configuration'**
  String get startConfiguration;

  /// Let's start
  ///
  /// In en, this message translates to:
  /// **'Let\'s start'**
  String get letsStart;

  /// Back
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Next
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// That's it! - PICOS is now ready!
  ///
  /// In en, this message translates to:
  /// **'That\'s it! - PICOS is now ready!'**
  String get configurationFinished;

  /// That's it! - thank you for your participation!
  ///
  /// In en, this message translates to:
  /// **'That\'s it! - thank you for your participation!'**
  String get questionnaireFinished;

  /// End configuration
  ///
  /// In en, this message translates to:
  /// **'End configuration'**
  String get endConfiguration;

  /// Discharge: Entries of the initial values..
  ///
  /// In en, this message translates to:
  /// **'Discharge: Entries of the initial values..'**
  String get finishText;

  /// Medication
  ///
  /// In en, this message translates to:
  /// **'Medication'**
  String get medication;

  /// Therapy
  ///
  /// In en, this message translates to:
  /// **'Therapy'**
  String get therapy;

  /// Doctor's visit
  ///
  /// In en, this message translates to:
  /// **'Doctor\'s visit'**
  String get doctorsVisit;

  /// Medication & Therapy
  ///
  /// In en, this message translates to:
  /// **'Medication & Therapy'**
  String get medicationAndTherapy;

  /// Patient ID-12345 takes part in the section
  ///
  /// In en, this message translates to:
  /// **'Patient ID-12345 takes part in the section'**
  String get infoText1;

  /// with the following information:
  ///
  /// In en, this message translates to:
  /// **'with the following information:'**
  String get infoText2;

  /// Body & Mind
  ///
  /// In en, this message translates to:
  /// **'Body & Mind'**
  String get bodyAndMind;

  /// Pain
  ///
  /// In en, this message translates to:
  /// **'Pain'**
  String get pain;

  /// Activity & Rest
  ///
  /// In en, this message translates to:
  /// **'Activity & Rest'**
  String get activityAndRest;

  /// Walk distance
  ///
  /// In en, this message translates to:
  /// **'Walk distance'**
  String get walkDistance;

  /// Sleep duration
  ///
  /// In en, this message translates to:
  /// **'Sleep duration'**
  String get sleepDuration;

  /// Sleep quality
  ///
  /// In en, this message translates to:
  /// **'Sleep quality'**
  String get sleepQuality;

  /// Vital values
  ///
  /// In en, this message translates to:
  /// **'Vital values'**
  String get vitalValues;

  /// Weight & BMI
  ///
  /// In en, this message translates to:
  /// **'Weight & BMI'**
  String get weightBMI;

  /// Heart frequency
  ///
  /// In en, this message translates to:
  /// **'Heart frequency'**
  String get heartFrequency;

  /// Blood pressure
  ///
  /// In en, this message translates to:
  /// **'Blood pressure'**
  String get bloodPressure;

  /// Blood sugar
  ///
  /// In en, this message translates to:
  /// **'Blood sugar'**
  String get bloodSugar;

  /// My Therapy
  ///
  /// In en, this message translates to:
  /// **'My Therapy'**
  String get myTherapy;

  /// Add therapy
  ///
  /// In en, this message translates to:
  /// **'Add therapy'**
  String get addTherapy;

  /// Date
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// Day
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// Year
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// Select date
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// Edit therapy
  ///
  /// In en, this message translates to:
  /// **'Edit therapy'**
  String get editTherapy;

  /// Body weight
  ///
  /// In en, this message translates to:
  /// **'Body weight'**
  String get bodyWeight;

  /// Possible walking distance within 2 minutes
  ///
  /// In en, this message translates to:
  /// **'Possible walking distance within 2 minutes (meters)'**
  String get possibleWalkDistance;

  /// Hrs.
  ///
  /// In en, this message translates to:
  /// **'Hrs.'**
  String get hrs;

  /// (auto. calculation)
  ///
  /// In en, this message translates to:
  /// **'(auto. calculation)'**
  String get autoCalc;

  /// Sleep quality during the last 7 days
  ///
  /// In en, this message translates to:
  /// **'Sleep quality during the last 7 days'**
  String get sleepQuality7Days;

  /// During the past 2 weeks, how often did you feel affected by the following complaints?
  ///
  /// In en, this message translates to:
  /// **'During the past 2 weeks, how often did you feel affected by the following complaints?'**
  String get howOftenAffected;

  /// a) little interest or pleasure in your activities
  ///
  /// In en, this message translates to:
  /// **'a) little interest or pleasure in your activities'**
  String get lowInterest;

  /// b) dejection, melancholy or hopelessness
  ///
  /// In en, this message translates to:
  /// **'b) dejection, melancholy or hopelessness'**
  String get dejection;

  /// c) nervousness, anxiety or strain
  ///
  /// In en, this message translates to:
  /// **'c) nervousness, anxiety or strain'**
  String get nervousness;

  /// d) Not being able to stop or control worries
  ///
  /// In en, this message translates to:
  /// **'d) Not being able to stop or control worries'**
  String get controlWorries;

  /// Has anything changed with your medication?
  ///
  /// In en, this message translates to:
  /// **'Has anything changed with your medication?'**
  String get changedMedication;

  /// Has anything changed in your therapy?
  ///
  /// In en, this message translates to:
  /// **'Has anything changed in your therapy?'**
  String get changedTherapy;

  /// Painless
  ///
  /// In en, this message translates to:
  /// **'Painless'**
  String get painless;

  /// Very mild
  ///
  /// In en, this message translates to:
  /// **'Very mild'**
  String get veryMild;

  /// Discomforting
  ///
  /// In en, this message translates to:
  /// **'Discomforting'**
  String get discomforting;

  /// Tolerable
  ///
  /// In en, this message translates to:
  /// **'Tolerable'**
  String get tolerable;

  /// Distressing
  ///
  /// In en, this message translates to:
  /// **'Distressing'**
  String get distressing;

  /// Very distressing
  ///
  /// In en, this message translates to:
  /// **'Very distressing'**
  String get veryDistressing;

  /// Intense
  ///
  /// In en, this message translates to:
  /// **'Intense'**
  String get intense;

  /// Very intense
  ///
  /// In en, this message translates to:
  /// **'Very intense'**
  String get veryIntense;

  /// Utterly Horrible
  ///
  /// In en, this message translates to:
  /// **'Utterly Horrible'**
  String get utterlyHorrible;

  /// Excruciating Unbearable
  ///
  /// In en, this message translates to:
  /// **'Excruciating Unbearable'**
  String get excruciatingUnbearable;

  /// Strongest imaginable
  ///
  /// In en, this message translates to:
  /// **'Strongest imaginable'**
  String get strongestImaginable;

  /// Not at all
  ///
  /// In en, this message translates to:
  /// **'Not at all'**
  String get notAtAll;

  /// On individual days
  ///
  /// In en, this message translates to:
  /// **'On individual days'**
  String get onIndividualDays;

  /// On more than half of the days
  ///
  /// In en, this message translates to:
  /// **'On more than half of the days'**
  String get onMoreThanHalfDays;

  /// Almost every day
  ///
  /// In en, this message translates to:
  /// **'Almost every day'**
  String get almostEveryDays;

  /// Yes
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Excellent
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get excellent;

  /// No description provided for @good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// Medium
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// Bad
  ///
  /// In en, this message translates to:
  /// **'Bad'**
  String get bad;

  /// Terrible
  ///
  /// In en, this message translates to:
  /// **'Terrible'**
  String get terrible;

  /// Tips for a healthy everyday life
  ///
  /// In en, this message translates to:
  /// **'Tips for a healthy everyday life'**
  String get tips;

  /// Welcome to PICOS
  ///
  /// In en, this message translates to:
  /// **'Welcome to PICOS'**
  String get welcomeToPICOS;

  /// Thank you for your participation in the DISTANCE project. We hope you enjoy using the PICOS App!
  ///
  /// In en, this message translates to:
  /// **'Thank you for your participation in the DISTANCE project. We hope you enjoy using the PICOS App!'**
  String get thankYouForParticipation;

  /// Wrong credentials
  ///
  /// In en, this message translates to:
  /// **'Wrong credentials'**
  String get wrongCredentials;

  /// Submit
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// Username
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// Password
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Have you
  ///
  /// In en, this message translates to:
  /// **'Have you '**
  String get questionaireDoctorVisit1;

  /// been to a doctor or hospital
  ///
  /// In en, this message translates to:
  /// **'been to a doctor or hospital '**
  String get questionaireDoctorVisit2;

  /// unscheduled?
  ///
  /// In en, this message translates to:
  /// **'unscheduled?'**
  String get questionaireDoctorVisitUnscheduled;

  /// Information according to § 5 TMG
  ///
  /// In en, this message translates to:
  /// **'Information according to § 5 TMG'**
  String get information5tmg;

  /// The DISTANCE project is one of the "Digital Hubs: Advances in Research and Health Care"-projects funded by the Federal Ministry of Education and Research (BMBF).
  ///
  /// In en, this message translates to:
  /// **'The DISTANCE project is one of the \"Digital Hubs: Advances in Research and Health Care\"-projects funded by the Federal Ministry of Education and Research (BMBF).'**
  String get projectDISTANCE;

  /// Head Office
  ///
  /// In en, this message translates to:
  /// **'Head Office'**
  String get headOffice;

  /// Postal Address
  ///
  /// In en, this message translates to:
  /// **'Postal Address'**
  String get postalAddress;

  /// Sales tax identification number according to § 27a sales tax law
  ///
  /// In en, this message translates to:
  /// **'Sales tax identification number according to § 27a sales tax law'**
  String get salesTaxID;

  /// Photo Credits
  ///
  /// In en, this message translates to:
  /// **'Photo Credits'**
  String get photoCredits;

  /// Contact
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// My Family Members
  ///
  /// In en, this message translates to:
  /// **'My Family Members'**
  String get myFamilyMembers;

  /// My Documents
  ///
  /// In en, this message translates to:
  /// **'My Documents'**
  String get myDocuments;

  /// Unknown height
  ///
  /// In en, this message translates to:
  /// **'Unknown height'**
  String get unknownHeight;

  /// No Pain
  ///
  /// In en, this message translates to:
  /// **'No Pain'**
  String get noPain;

  /// Minor Pain
  ///
  /// In en, this message translates to:
  /// **'Minor Pain'**
  String get minorPain;

  /// Moderate Pain
  ///
  /// In en, this message translates to:
  /// **'Moderate Pain'**
  String get moderatePain;

  /// Strong Pain
  ///
  /// In en, this message translates to:
  /// **'Strong Pain'**
  String get strongPain;

  /// Case Number
  ///
  /// In en, this message translates to:
  /// **'Case Number'**
  String get caseNumber;

  /// Patient ID
  ///
  /// In en, this message translates to:
  /// **'Patient ID'**
  String get patientID;

  /// Weight
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// Height
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// Date of Discharge
  ///
  /// In en, this message translates to:
  /// **'Date of Discharge'**
  String get dischargeDate;

  /// Institute Key
  ///
  /// In en, this message translates to:
  /// **'Institute Key'**
  String get instituteKey;

  /// Please enter the case number!
  ///
  /// In en, this message translates to:
  /// **'Please enter the case number!'**
  String get enterCaseNumber;

  /// Please enter the patient ID!
  ///
  /// In en, this message translates to:
  /// **'Please enter the patient ID!'**
  String get enterPatientID;

  /// Please enter the weight!
  ///
  /// In en, this message translates to:
  /// **'Please enter the weight!'**
  String get enterWeight;

  /// Please enter the height!
  ///
  /// In en, this message translates to:
  /// **'Please enter the height!'**
  String get enterHeight;

  /// Please enter the blood pressure value!
  ///
  /// In en, this message translates to:
  /// **'Please enter the blood pressure value!'**
  String get enterBloodPressure;

  /// Please enter the blood sugar value!
  ///
  /// In en, this message translates to:
  /// **'Please enter the blood sugar value!'**
  String get enterBloodSugar;

  /// Please enter the date of discharge!
  ///
  /// In en, this message translates to:
  /// **'Please enter the date of discharge!'**
  String get enterDischargeDate;

  /// Please enter the institute key!
  ///
  /// In en, this message translates to:
  /// **'Please enter the institute key!'**
  String get enterInstituteKey;

  /// Therapy Name
  ///
  /// In en, this message translates to:
  /// **'Therapy Name'**
  String get therapyName;

  /// Please enter the name
  ///
  /// In en, this message translates to:
  /// **'Please enter the name'**
  String get enterName;

  /// Doctor/hospital visits
  ///
  /// In en, this message translates to:
  /// **'Doctor/hospital visits'**
  String get visits;

  /// Patient advice for unplanned hospital and doctors visits. (Part 1)
  ///
  /// In en, this message translates to:
  /// **'This information is only required if you have made an '**
  String get visitInfoPart1;

  /// Patient advice for unplanned hospital and doctors visits. (Part 2)
  ///
  /// In en, this message translates to:
  /// **'unplanned'**
  String get visitInfoPart2;

  /// Patient advice for unplanned hospital and doctors visits. (Part 3)
  ///
  /// In en, this message translates to:
  /// **' visit to a doctor\'s office or hospital.'**
  String get visitInfoPart3;

  /// I was unscheduled
  ///
  /// In en, this message translates to:
  /// **'I was unscheduled'**
  String get iWasUnscheduled;

  /// to see a general practitioner
  ///
  /// In en, this message translates to:
  /// **'to see a general practitioner'**
  String get toSeeAResidentPhysician;

  /// in a hospital
  ///
  /// In en, this message translates to:
  /// **'in a hospital'**
  String get inAHospital;

  /// When did you see the physician?
  ///
  /// In en, this message translates to:
  /// **'When did you see the physician?'**
  String get whenDidYouSeeThePhysician;

  /// When were you in the hospital?
  ///
  /// In en, this message translates to:
  /// **'When were you in the hospital?'**
  String get whenWereYouInHospital;

  /// Date of admission
  ///
  /// In en, this message translates to:
  /// **'Date of admission'**
  String get dayOfRecording;

  /// Day of discharge
  ///
  /// In en, this message translates to:
  /// **'Day of discharge'**
  String get dayOfDischarge;

  /// Reason for hospitalization
  ///
  /// In en, this message translates to:
  /// **'Reason for hospitalization'**
  String get reasonForHospitalization;

  /// Reason for visit to the doctor
  ///
  /// In en, this message translates to:
  /// **'Reason for visit to the doctor'**
  String get reasonForVisitToTheDoctor;

  /// Do you need help or have a question about using the PICOS app?
  ///
  /// In en, this message translates to:
  /// **'Do you need help or have a question about using the PICOS app?'**
  String get needHelp;

  /// Specialty
  ///
  /// In en, this message translates to:
  /// **'Specialty'**
  String get specialty;

  /// Street, house no.
  ///
  /// In en, this message translates to:
  /// **'Street, house no.'**
  String get streetAndHouseNo;

  /// ZIP CODE
  ///
  /// In en, this message translates to:
  /// **'ZIP CODE'**
  String get zipCode;

  /// City
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// is invalid
  ///
  /// In en, this message translates to:
  /// **'is invalid'**
  String get isInvalid;

  /// Phone
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Add document
  ///
  /// In en, this message translates to:
  /// **'Add document'**
  String get addDocument;

  /// Edit document
  ///
  /// In en, this message translates to:
  /// **'Edit document'**
  String get editDocument;

  /// Priority
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// Important document - keep on top
  ///
  /// In en, this message translates to:
  /// **'Important document - keep on top'**
  String get importantDocument;

  /// Sort by date
  ///
  /// In en, this message translates to:
  /// **'Sort by date'**
  String get sortByDate;

  /// Document title
  ///
  /// In en, this message translates to:
  /// **'Document title'**
  String get documentTitle;

  /// Upload Document
  ///
  /// In en, this message translates to:
  /// **'Upload Document'**
  String get uploadDocument;

  /// Download document
  ///
  /// In en, this message translates to:
  /// **'Download document'**
  String get downloadDocument;

  /// Important documents
  ///
  /// In en, this message translates to:
  /// **'Important documents'**
  String get importantDocuments;

  /// Documents sorted descending
  ///
  /// In en, this message translates to:
  /// **'Documents sorted descending'**
  String get documentsSortedDesc;

  /// Document selected
  ///
  /// In en, this message translates to:
  /// **'Document selected'**
  String get documentSelected;

  /// Please complete the red and orange days
  ///
  /// In en, this message translates to:
  /// **'Please complete the red and orange days'**
  String get completeTheDays;

  /// today
  ///
  /// In en, this message translates to:
  /// **'today'**
  String get today;

  /// yesterday
  ///
  /// In en, this message translates to:
  /// **'yesterday'**
  String get yesterday;

  /// other
  ///
  /// In en, this message translates to:
  /// **'other'**
  String get other;

  /// No Data
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get noData;

  /// Please check whether your entry is correct!
  ///
  /// In en, this message translates to:
  /// **'Please check whether your entry is correct!'**
  String get checkValue;

  /// My Patients
  ///
  /// In en, this message translates to:
  /// **'My Patients'**
  String get myPatients;

  /// Edit Patient Information
  ///
  /// In en, this message translates to:
  /// **'Edit Patient Information'**
  String get editPatientInformation;

  /// Your account is locked for safety reasons. Please try again in 5 minutes.
  ///
  /// In en, this message translates to:
  /// **'Your account is locked for safety reasons. Please try again in 5 minutes.'**
  String get bruteforceLock;

  /// Connection error
  ///
  /// In en, this message translates to:
  /// **'Connection error'**
  String get connectionError;

  /// Inclusion criteria DISTANCE
  ///
  /// In en, this message translates to:
  /// **'Inclusion criteria DISTANCE'**
  String get inclusionCriteriaDistance;

  /// mechanical ventilation
  ///
  /// In en, this message translates to:
  /// **'mechanical ventilation'**
  String get mechanicalVentilation;

  /// ICU stay
  ///
  /// In en, this message translates to:
  /// **'ICU stay'**
  String get icuStay;

  /// age
  ///
  /// In en, this message translates to:
  /// **'age'**
  String get age;

  /// birthday
  ///
  /// In en, this message translates to:
  /// **'birthday'**
  String get birthDate;

  /// years
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get years;

  /// ICU Diagnosis
  ///
  /// In en, this message translates to:
  /// **'ICU Diagnosis'**
  String get icuDiagnosis;

  /// ICU main diagnosis
  ///
  /// In en, this message translates to:
  /// **'ICU main diagnosis'**
  String get mainDiagnosis;

  /// Ancillary diagnosis
  ///
  /// In en, this message translates to:
  /// **'Ancillary diagnosis'**
  String get ancillaryDiagnosis;

  /// ICUAW
  ///
  /// In en, this message translates to:
  /// **'ICUAW'**
  String get icuaw;

  /// PICS
  ///
  /// In en, this message translates to:
  /// **'PICS'**
  String get pics;

  /// PICS
  ///
  /// In en, this message translates to:
  /// **'Vital data ICU discharge'**
  String get vitalDataIcuDischarge;

  /// SAP
  ///
  /// In en, this message translates to:
  /// **'SAP'**
  String get systolicArterialPressure;

  /// MAP
  ///
  /// In en, this message translates to:
  /// **'MAP'**
  String get meanArterialPressure;

  /// DAP
  ///
  /// In en, this message translates to:
  /// **'DAP'**
  String get diastolicArterialPressure;

  /// Central venous pressure
  ///
  /// In en, this message translates to:
  /// **'Central venous pressure'**
  String get centralVenousPressure;

  /// Last
  ///
  /// In en, this message translates to:
  /// **'Last'**
  String get last;

  /// Pre-Last
  ///
  /// In en, this message translates to:
  /// **'Pre-Last'**
  String get preLast;

  /// Laboratory values (last values before discharge)
  ///
  /// In en, this message translates to:
  /// **'Laboratory values (last values before discharge)'**
  String get laboratoryValues;

  /// Leukocyte count
  ///
  /// In en, this message translates to:
  /// **'Leukocyte count'**
  String get leukocyteCount;

  /// Lymphocyte count
  ///
  /// In en, this message translates to:
  /// **'Lymphocyte count'**
  String get lymphocyteCount;

  /// Lymphocyte percentage
  ///
  /// In en, this message translates to:
  /// **'Lymphocyte percentage'**
  String get lymphocytePercentage;

  /// Platelet count
  ///
  /// In en, this message translates to:
  /// **'Platelet count'**
  String get plateletCount;

  /// C-Reactive protein level
  ///
  /// In en, this message translates to:
  /// **'C-Reactive protein level'**
  String get cReactiveProteinLevel;

  /// No description provided for @procalcitoninLevel.
  ///
  /// In en, this message translates to:
  /// **'Procalcitonin (PCT) level'**
  String get procalcitoninLevel;

  /// Interleukin (IL-6)
  ///
  /// In en, this message translates to:
  /// **'Interleukin (IL-6)'**
  String get interleukin;

  /// Blood Urea Nitrogen
  ///
  /// In en, this message translates to:
  /// **'Blood Urea Nitrogen'**
  String get bloodUreaNitrogen;

  /// Creatinine
  ///
  /// In en, this message translates to:
  /// **'Creatinine'**
  String get creatinine;

  /// No description provided for @heartFailureMarker.
  ///
  /// In en, this message translates to:
  /// **'Heart failure marker BNP'**
  String get heartFailureMarker;

  /// No description provided for @heartFailureMarkerNTProBNP.
  ///
  /// In en, this message translates to:
  /// **'Heart failure marker NT-proBNP'**
  String get heartFailureMarkerNTProBNP;

  /// Bilirubin total
  ///
  /// In en, this message translates to:
  /// **'Bilirubin total'**
  String get bilirubinTotal;

  /// Hemoglobin
  ///
  /// In en, this message translates to:
  /// **'Hemoglobin'**
  String get hemoglobin;

  /// Hematocrit
  ///
  /// In en, this message translates to:
  /// **'Hematocrit'**
  String get hematocrit;

  /// Albumin
  ///
  /// In en, this message translates to:
  /// **'Albumin'**
  String get albumin;

  /// Glutamat-Oxalacetat-Transaminase (GOT/ASAT)
  ///
  /// In en, this message translates to:
  /// **'Glutamat-Oxalacetat-Transaminase (GOT/ASAT)'**
  String get gotASAT;

  /// Glutamat-Pyruvat-Transaminase (GPT/ALAT)
  ///
  /// In en, this message translates to:
  /// **'Glutamat-Pyruvat-Transaminase (GPT/ALAT)'**
  String get gptALAT;

  /// Troponin
  ///
  /// In en, this message translates to:
  /// **'Troponin'**
  String get troponin;

  /// Creatine kinase
  ///
  /// In en, this message translates to:
  /// **'Creatine kinase'**
  String get creatineKinase;

  /// Myocardial infarction marker CK-MB
  ///
  /// In en, this message translates to:
  /// **'Myocardial infarction marker CK-MB'**
  String get myocardialInfarctionMarkerCKMB;

  /// Lactate dehydrogenase level
  ///
  /// In en, this message translates to:
  /// **'Lactate dehydrogenase level'**
  String get lactateDehydrogenaseLevel;

  /// Amylase level
  ///
  /// In en, this message translates to:
  /// **'Amylase level'**
  String get amylaseLevel;

  /// Lipase level
  ///
  /// In en, this message translates to:
  /// **'Lipase level'**
  String get lipaseLevel;

  /// D-dimere
  ///
  /// In en, this message translates to:
  /// **'D-dimere'**
  String get dDimer;

  /// International Normalized Ratio (INR)
  ///
  /// In en, this message translates to:
  /// **'International Normalized Ratio (INR)'**
  String get internationalNormalizedRatio;

  /// Partial thromboplastin time
  ///
  /// In en, this message translates to:
  /// **'Partial thromboplastin time'**
  String get partialThromboplastinTime;

  /// Respiration Parameters (last values before discharge)
  ///
  /// In en, this message translates to:
  /// **'Respiration Parameters (last values before discharge)'**
  String get respirationParameters;

  /// VT spontanous
  ///
  /// In en, this message translates to:
  /// **'VT spontanous'**
  String get vtSpontanous;

  /// 02 sat
  ///
  /// In en, this message translates to:
  /// **'O2 sat'**
  String get o2sat;

  /// Medicaments (last values before discharge)
  ///
  /// In en, this message translates to:
  /// **'Medicaments (last values before discharge)'**
  String get medicaments;

  /// Thrombosis Aggregation
  ///
  /// In en, this message translates to:
  /// **'Thrombosis Aggreagtion'**
  String get thrombosisAggregation;

  /// NOAC
  ///
  /// In en, this message translates to:
  /// **'NOAC'**
  String get noac;

  /// Thrombosis Prophylaxis
  ///
  /// In en, this message translates to:
  /// **'Thrombosis Prophylaxis'**
  String get thrombosisProphylaxis;

  /// Antihypertensives
  ///
  /// In en, this message translates to:
  /// **'Antihypertensives'**
  String get antihypertensives;

  /// Antiarrythmics
  ///
  /// In en, this message translates to:
  /// **'Antiarrythmics'**
  String get antiarrythmics;

  /// Antidiabetics
  ///
  /// In en, this message translates to:
  /// **'Antidiabetics'**
  String get antidiabetics;

  /// Antiinfectives
  ///
  /// In en, this message translates to:
  /// **'Antiinfectives'**
  String get antiinfectives;

  /// Steroids
  ///
  /// In en, this message translates to:
  /// **'Steroids'**
  String get stereoids;

  /// Inhalatives
  ///
  /// In en, this message translates to:
  /// **'Inhalatives'**
  String get inhalatives;

  /// Analgesics
  ///
  /// In en, this message translates to:
  /// **'Analgesics'**
  String get analgesics;

  /// Blood Gas Analysis
  ///
  /// In en, this message translates to:
  /// **'Blood Gas Analysis'**
  String get bloodGasAnalysis;

  /// paO2 (without Temp-correcion)
  ///
  /// In en, this message translates to:
  /// **'paO2 (without Temp-correcion)'**
  String get paO2;

  /// paCO2 (without Temp-correction)
  ///
  /// In en, this message translates to:
  /// **'paCO2 (without Temp-correction)'**
  String get paCO2;

  /// arterial PH
  ///
  /// In en, this message translates to:
  /// **'arterial PH'**
  String get arterialPH;

  /// Arterial Lactate
  ///
  /// In en, this message translates to:
  /// **'Arterial Lactate'**
  String get arterialLactate;

  /// Aterial Serum Bicarbonate Concentration
  ///
  /// In en, this message translates to:
  /// **'Aterial Serum Bicarbonate Concentration'**
  String get arterialBicarbonate;

  /// arterial base excess
  ///
  /// In en, this message translates to:
  /// **'Arterial Base Excess'**
  String get arterialBaseExcess;

  /// Gender
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// BMI
  ///
  /// In en, this message translates to:
  /// **'BMI'**
  String get bmi;

  /// Ideal Body Weight
  ///
  /// In en, this message translates to:
  /// **'Ideal Body Weight'**
  String get idealBodyWeight;

  /// Admission Time ICU
  ///
  /// In en, this message translates to:
  /// **'Admission Time ICU'**
  String get admissionTimeICU;

  /// Discharge Time ICU
  ///
  /// In en, this message translates to:
  /// **'Discharge Time ICU'**
  String get dischargeTimeICU;

  /// Ventilation Days ICU
  ///
  /// In en, this message translates to:
  /// **'Ventilation Days ICU'**
  String get ventilationDaysICU;

  /// Admission Time to the Hospital
  ///
  /// In en, this message translates to:
  /// **'Admission Time to the Hospital'**
  String get admissionTimeHospital;

  /// Discharge Time from the Hospital
  ///
  /// In en, this message translates to:
  /// **'Discharge Time from the Hospital'**
  String get dischargeTimeHospital;

  /// ICD-10 Codes
  ///
  /// In en, this message translates to:
  /// **'ICD-10 Codes'**
  String get icd10Codes;

  /// Patient Location
  ///
  /// In en, this message translates to:
  /// **'Patient Location'**
  String get patientLocation;

  /// ICU Mortality
  ///
  /// In en, this message translates to:
  /// **'ICU Mortality'**
  String get icuMortality;

  /// Hospital Mortality
  ///
  /// In en, this message translates to:
  /// **'Hospital Mortality'**
  String get hospitalMortality;

  /// No description provided for @hospitalLengthOfStay.
  ///
  /// In en, this message translates to:
  /// **'Hospital Length of Stay'**
  String get hospitalLengthOfStay;

  /// ICU Length of Stay
  ///
  /// In en, this message translates to:
  /// **'ICU Length of Stay'**
  String get icuLengthOfStay;

  /// Readmission Rate to the ICU
  ///
  /// In en, this message translates to:
  /// **'Readmission Rate to the ICU'**
  String get readmissionRateICU;

  /// Hospital Readmission
  ///
  /// In en, this message translates to:
  /// **'Hospital Readmission'**
  String get hospitalReadmission;

  /// Days until Work Reupdake
  ///
  /// In en, this message translates to:
  /// **'Days until Work Reupdake'**
  String get daysUntilWorkReuptake;

  /// Patients Movement Data
  ///
  /// In en, this message translates to:
  /// **'Patients Movement Data'**
  String get patientsMovementData;

  /// arterial oxygen saturation
  ///
  /// In en, this message translates to:
  /// **'arterial oxygen saturation'**
  String get saO2;

  /// central venous oxygen saturation
  ///
  /// In en, this message translates to:
  /// **'central venous oxygen saturation'**
  String get svO2;

  /// respiratory rate
  ///
  /// In en, this message translates to:
  /// **'respiratory rate'**
  String get af;

  /// Lung Protective Ventilation > 70%
  ///
  /// In en, this message translates to:
  /// **'Lung Protective Ventilation > 70%'**
  String get lungProtectiveVentilation70p;

  /// My profile
  ///
  /// In en, this message translates to:
  /// **'My profile'**
  String get myProfile;

  /// New Password
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// Repeat new Password
  ///
  /// In en, this message translates to:
  /// **'Repeat new Password'**
  String get newPasswordRepeat;

  /// Change Password
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// The new password has been successfully saved!
  ///
  /// In en, this message translates to:
  /// **'The new password has been successfully saved!'**
  String get passwordSavedSuccessMessage;

  /// The new passwords do not match!
  ///
  /// In en, this message translates to:
  /// **'The new passwords do not match!'**
  String get passwordMismatchErrorMessage;

  /// The new password must consist of lowercases, uppercases, special characters and at least 8 characters!
  ///
  /// In en, this message translates to:
  /// **'The new password must consist of lowercases, uppercases, special characters and at least 8 characters!'**
  String get strongPassword;

  /// New password could not be saved!
  ///
  /// In en, this message translates to:
  /// **'New password could not be saved!'**
  String get passwordSavedFailureMessage;

  /// All fields must be filled!
  ///
  /// In en, this message translates to:
  /// **'All fields must be filled!'**
  String get allFieldsMustbeFilled;

  /// Change title
  ///
  /// In en, this message translates to:
  /// **'Change title'**
  String get changeTitle;

  /// Change firstname
  ///
  /// In en, this message translates to:
  /// **'Change firstname'**
  String get changeFirstname;

  /// Change lastname
  ///
  /// In en, this message translates to:
  /// **'Change lastname '**
  String get changeLastname;

  /// Change Address
  ///
  /// In en, this message translates to:
  /// **'Change Address'**
  String get changeAddress;

  /// Change Phone number
  ///
  /// In en, this message translates to:
  /// **'Change Phone number'**
  String get changePhoneNumber;

  /// Change email
  ///
  /// In en, this message translates to:
  /// **'Change email'**
  String get changeEmail;

  /// Change unit
  ///
  /// In en, this message translates to:
  /// **'Change unit'**
  String get changeBloodSugarUnit;

  /// Unknown Error
  ///
  /// In en, this message translates to:
  /// **'Unknown Error'**
  String get unknownError;

  /// Update Failed
  ///
  /// In en, this message translates to:
  /// **'Update Failed'**
  String get updateFailed;

  /// Update Successful
  ///
  /// In en, this message translates to:
  /// **'Update Successful'**
  String get updateSuccess;

  /// Password changed successfully!
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully!'**
  String get passwordChangeSuccessful;

  /// You have been automatically logged out. Please log in again.
  ///
  /// In en, this message translates to:
  /// **'You have been automatically logged out. Please log in again.'**
  String get passwordChangeLogoutMessage;

  /// OK
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Remember me?
  ///
  /// In en, this message translates to:
  /// **'Remember me?'**
  String get rememberMe;

  /// Values
  ///
  /// In en, this message translates to:
  /// **'Values'**
  String get myValues;

  /// Keep your values in view.
  /// Select your personal entries here that should be displayed on the home page.
  ///
  /// In en, this message translates to:
  /// **'Values'**
  String get infoMyValue;

  /// Manage values
  ///
  /// In en, this message translates to:
  /// **'Manage values'**
  String get manageValues;

  /// No data available
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noDataAvailable;

  /// No description provided for @systolic.
  ///
  /// In en, this message translates to:
  /// **'Systolic'**
  String get systolic;

  /// No description provided for @diastolic.
  ///
  /// In en, this message translates to:
  /// **'Diastolic'**
  String get diastolic;

  /// Hospital
  ///
  /// In en, this message translates to:
  /// **'Hospital'**
  String get hospital;

  /// Physician
  ///
  /// In en, this message translates to:
  /// **'Physician'**
  String get physician;

  /// My Visits
  ///
  /// In en, this message translates to:
  /// **'My Visits'**
  String get myVisits;

  /// Visit Date
  ///
  /// In en, this message translates to:
  /// **'Visit Date'**
  String get visitDate;

  /// Record Date
  ///
  /// In en, this message translates to:
  /// **'Record Date'**
  String get recordDate;

  /// handbook
  ///
  /// In en, this message translates to:
  /// **'handbook'**
  String get handbook;

  /// Could not launch
  ///
  /// In en, this message translates to:
  /// **'Could not launch'**
  String get couldNotLaunch;

  /// To catalog of Items
  ///
  /// In en, this message translates to:
  /// **'To catalog of Items'**
  String get toCoi;

  /// to follow up
  ///
  /// In en, this message translates to:
  /// **'To follow up'**
  String get toFollowUp;

  /// Erroneous input
  ///
  /// In en, this message translates to:
  /// **'Erroneous input'**
  String get erroneousInput;

  /// Test result
  ///
  /// In en, this message translates to:
  /// **'Test result'**
  String get testResult;

  /// Health score
  ///
  /// In en, this message translates to:
  /// **'Health score'**
  String get healthScore;

  /// Health state
  ///
  /// In en, this message translates to:
  /// **'Health state'**
  String get healthState;

  /// Rhythm
  ///
  /// In en, this message translates to:
  /// **'Rhythm'**
  String get rhythm;

  /// Rhythm type
  ///
  /// In en, this message translates to:
  /// **'Rhythm type'**
  String get rhythmType;

  /// Electrical axis deviation
  ///
  /// In en, this message translates to:
  /// **'Electrical axis deviation'**
  String get electricalAxisDeviation;

  /// Error!
  ///
  /// In en, this message translates to:
  /// **'Error!'**
  String get error;

  /// Loading failed!
  ///
  /// In en, this message translates to:
  /// **'Loading failed!'**
  String get loadingFailed;

  /// Forgot Password?
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// Reset password
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// If correct, an mail will be sent!
  ///
  /// In en, this message translates to:
  /// **'If correct, an mail will be sent!'**
  String get ifEmailCorrect;

  /// Please enter the email address you registered with. We will send you an e-mail with a link to reset your password!
  ///
  /// In en, this message translates to:
  /// **'Please enter the email address you registered with. We will send you an e-mail with a link to reset your password!'**
  String get enterMailToResetPW;

  /// Backend is not reachable!
  ///
  /// In en, this message translates to:
  /// **'Backend is not reachable!'**
  String get backendNotReachable;

  /// Incomplete Credentials!
  ///
  /// In en, this message translates to:
  /// **'Incomplete Credentials'**
  String get incompleteCredentials;

  /// Blood sugar unit
  ///
  /// In en, this message translates to:
  /// **'Blood sugar unit'**
  String get bloodSugarUnit;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
