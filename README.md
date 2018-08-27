# What to do in Madrid

The goal of this project is to write a web API to help select activities to do in Madrid.


## Solution

#### This task was coded using Ruby 2.5.1 and Rails 5.2.1

* Make sure Ruby version 2.5.1 is installed and bundler gem available.
* Execute:
 ```console
git clone https://github.com/martincabrera/madrid-activities.git
```
* Execute:
 ```console
cd madrid-activities
```
* Execute:
 ```console
bundle install
```


### SQLite Setup ###

 ```console
rails db:create
```
 ```console
 rails db:migrate
```
 ```console
rails db:seed
```

After this last command has been executed, seed data should be created in the database.
To run this localhost server:


* Run ```rails s``` to start the development server at port 3000
* Open this URL in your browser ```http://localhost:3000/api/v1/activities``` for the first endpoint
* Open this URL in your browser ```http://localhost:3000/api/v1/activities/recommendation?start_hour=10:00&end_hour=14:00&category=shopping&day_of_the_week=mo``` for an example of the second endpoint
* Run specs suite with ```bundle exec rspec```
* Check Ruby linter with ```rubocop```