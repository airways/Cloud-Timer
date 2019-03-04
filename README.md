## About
This example is provided by Near North Software. Please visit us online at https://www.nearnorthsoftware.com


## Timer Logic

Customize the ServiceTimer class' Action event handler to do whateve ryou need.

Change kInterval to the number of seconds between each run you wish the timer to run at.

Change kFirstRunInterval to the number of seconds after the app starts you want the timer to run for the first time.
After this first run, the timer will thereafter run at the kInterval period instead.


## Authentication

Please change the kAdminUsername, kAdminPassword, and kAdminSalt values to something specific for your application.
kAdminPassword may be plain text but you should instead set it to a hashed value with the following code added to the
App.Open() event handler:

App.Log(MD5("your_new_password_here!!123" + kAdminSalt))

Take the value from the app log, remove this line of code, and use the hashed value in kAdminPassword. If you change
kAdminSalt after doing this, you will need to recalculate the hash.


## Email

To use SendEmail method you will need to set all of the kEmail* and kSMTP* constants on the App object correctly.


## License

Copyright (c)2018-2019. Near North Software.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


"Near North", "Near North Software", and "Near North Screenshots" are trademarks of Near North Software. All other
trademarks cited herein are the property of their respective owners. All company, product and service names used in
this software are for identification purposes only. Use of these names, logos, and brands does not imply endorsement.
