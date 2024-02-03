# toolbox_frontend

A new Flutter project.

## Tasks

 - Create user
   - `/create-user` endpoint
   - `async fn create_user` + `CreateUserRequest` + `CreateUserResponse`
   - dart function to call this endpoint (this goes in `http.dart`)
   - connect that function to UI code (this goes in `login.dart`)


Hint for making the login page a popup: `AlertDialog` has a parameter called `content` which is "any widget"

 - Logout button
   - when pressed, show a popup saying "are you sure" (`showDialog` and `AlertDialog`)
   - if yes, print "logging out"
   - if no or cancel, do nothing
   - (extra challenge) - write the backend endpoint for "/logout"
     - for now, assume that the session token will be sent in the JSON body
     - when the user presses the logout button and confirms, send a random UUID to "/logout"
     - the backend will receive this UUID, look it up in the database, and delete the row if it exists, otherwise it will panic
     - this won't work because we are randomly generating a UUID which doesn't exist in the database, but we don't have state management yet so we can't "remember" the session token we got from when we "logged in"