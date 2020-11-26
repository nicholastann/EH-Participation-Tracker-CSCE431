__________________________________________________

Engineering Honors - Participation Tracker V 1.0
https://eh-participation-tracker.herokuapp.com/
__________________________________________________

EH Participation Tracker is a simple Ruby on Rails CRUD application
used for tracking the participation of students in Engineering Honors
at Texas A&M University.

© 2020 EH Participation Tracker


Terms of Use
--------------------
By entering this system and entering any data requested, I am giving my consent to share data 
related to my involvement with the student organization. Should I no longer wish to share 
the data I've provided, I will notify the student organization.


--------------------
Table of Contents
--------------------
 I. Instructions
 II. Features
 III. Technology Stack
 IV. Development Team
 V. Setup
 VI. System Requirements
 VII. Testing


I. Intstructions
--------------------

 Home
_________________________________________________________________________________________
Upon launching the application, users will be asked to either sign in or create an account
 - One must be logged in to access this app's features.

On the home page, underneath the welcome tab, we can view your profile and
 any events associated with your account.

Admins are able to edit or view this information using the edit and view buttons under
 the "Actions" column.


 Students
_________________________________________________________________________________________
On the students page a table of registered students is shown.

Here, using the buttons in the "Actions" column, admins are able to edit, delete,
 or view a student's information.

Additionally, admins can add students to the table following the "+ Add Student" link.
 - All fields must be filled out to successfully add a student

Lastly, admins can import and export csv files to load students into the table
 or to download the current table.
 
To import data, you will need a csv file with the following columns, in order 
Column Name (data type/format)

firstName (string)
lastName (string)
email (string)
uin (9-digit integer)
year (4-digit integer)
major (string)
gpa (floating point, up to 4.000)
status (string, either "Good Standing" or "Bad Standing")


 Events
_________________________________________________________________________________________
On the events page a table of recorded events is shown.

This page has the same actions as the students page for events.

Admins are able to edit, view, delete, and add events in the same manner,
 as well as import and export csv files.
 
To import data, you will need a csv file with the following columns, in order 
Column Name (data type/format)

name (string)
date (integer, yyyy-mm-dd --:--:-- UTC)
description (string)
event_type (string)
location (string)


II. Features
--------------------
 - Keep track of students in Engineering Honors
 - Site is only accessed with an account
 - Users can create accounts through sign-up page
 - Passwords are encrypted and saved in PostgreSQL Database
 - Admin accounts can create, modify, and delete students/events in their respective tables
 - Admin accounts can register students for events
 - Admin accounts can import/export participation data
 - Light/Dark theme switch


III. Technology Stack
--------------------
 This app was created with:
- Ruby on Rails
- PostgreSQL
- HTML
- CSS
- AJAX
- JavaScript
- Heroku
- RSpec
- Capybara


IV. Development Team
--------------------
 Sawyer Cowan - Scrum Master, Full-Stack Developer
 Nicholas Tann - Product Owner, Full-Stack Developer
 Dawnson Abner - Assistive Technologies, Back-End Developer
 Phillip Pham - Quality Assurance Tester, Back-End Developer
 Chuck Esedebe - Assistive Technologies, Front-End Developer

