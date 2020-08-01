# Bulletin

## Docker Commands
* To verify that docker is pulling images and running as expected:  
**docker run hello-world**
* To see all docker images:  
**docker images**
* To run ubuntu bash:  
**docker run -it ubuntu bash**
* To see all docker containers:  
**doctor container ls**
* To install ruby:  
**docker run ruby:2.6.6**
* To open interactive ruby console:  
**docker run -it ruby:2.6.6 irb**
* can explore different repositories in dockerhub
* To build container:  
**docker-compose build**
* To start container:  
**docker-compose up**
* To run container in the background (detached mode) and keep terminal clear:  
**docker-compose up -d**
* To move into running container instance (and be able to run rails commands):  
**docker-compose exec app bash**
* To display log output:  
**docker-compose logs**
* To stop container:  
**docker-compose down**
* To debug:  
**docker run -it *IMAGEID* bash**  
(find *IMAGEID* from 'docker images' call)

## Rails Commands
* To generate model:  
**rails g model NAME field:type**
* To run migrations that haven't been run yet:  
**rails db:migrate**
* To open rails console:  
**rails c**
* To run ruby code in db/seeds.rb:  
**rails db:seed**
* To destroy the database:  
**rails db:drop**
* To see all of the routes:  
**rails routes**

## Testing
* Test suites can be found in bulletin/test/models
* To run tests:  
**rails t** -or-  
**dcom exec app rails t**
* Helpful debugging gem:  
**byebug**  
(Stops interpreter and provides interactive console)
* Format:  
```ruby
test "test name" do
    assert #something (verifies true)
    refute #something (verifies false)
end
```
* Can seed test database with test data using fixtures

## Authentication
Before running the Duke authentication, need to do the following:
1. **cd ~**
2. Run **echo $SHELL**
3. If returns /bin/bash, open .bash_profile in a text editor. If zsh, open .zsh file.
4. Add to the end of the file, **export BULLETIN_OAUTH_SECRET="insert_secret_key_from_team_dropbox_folder"**  
**export FACEBOOK_OAUTH_SECRET="insert_facebook_secret_key_from_box_notes"**  
**export GOOGLE_OAUTH_SECRET="insert_google_secret_key_from_box_notes"**
**export GMAIL_SECRET="insert_gmail_secret_key_from_box_notes**
5. Terminate all terminal windows (quit application)
6. Run **env | grep BULLETIN**  
**env | grep FACEBOOK**  
**env | grep GOOGLE** 
**env | grep GMAIL**

## Authorization
To give your account site/org admin privileges:
1. **docker-compose up -d**
2. **docker-compose exec app bash**
3. **rails c**
4. **your_name = User.find_by_email("your_email")**
5. **your_name.update_attribute(:type, "OrgAdmin")**
6. **your_name.update_attribute(:admin, true)**