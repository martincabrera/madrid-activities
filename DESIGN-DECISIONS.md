# Design decisions

I approached this project as an MVP (minimum viable product)

I chose **SQLite** for a storage solution just because, even though we store coordinates, we do not process them in any way. We only have to store these coordinates and display them within a geoJSON format.

ActiveRecord Models:

    1) Activity model
    2) OpeningHour model

All hh:mm ranges are stored in seconds from midnight.
**Activity** fields **category**, **district** & **location** could have had their own models if we continued to normalize our database. But, for the purpose of the task and without losing any functionality, it was kept as simple string fields inside Activity model.

Lib classes:

Inside /lib directory I added the following classes:

    1) TimeFormatter
    2) ActivityPrescriptor

**TimeFormatter** class groups time related features, mostly conversion from hh:mm to seconds and viceversa.
**ActivityPrescriptor** is the class that handles the recommendation of a single activity exposed in Endpoint #2. (See README.md)

There is also a rake task ```rake import:json_file```that imports the madrid.json file that was given as a starting point. As a matter of fact, ```rake db:seed``` invokes internally this rake task to populate the database for the first time.

# Future enhancements

    1) Do not recommend outdors activity on a rainy day
    
    weather could simply be a different param and have some logic around the location filter (Activity model)

    2) Support getting information about activities in multiple cities
    
    We could have a new model called City. A city has many activities and from there, do the search.

    3) Extend the recommendation API to fill the given time range with multiple activities
    
    ActivityPrescriptor now orders by hours_spent and returns just 1 one record with the highest hours. It could just return all instead of only one. (recommend method)
