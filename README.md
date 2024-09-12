# Concertmate Backend App

## Description
### This is a backend application built with Ruby on Rails. It serves as the backend for managing users, events, and artist data. The application provides RESTful APIs for creating, reading, updating, and deleting (CRUD) resources like users, artists, and events.

## Features Provided
	•	Manage users and their saved artists.
	•	Create and manage events.
	•	Associate users with events and allow users to attend events.
	•	RESTful API endpoints for handling various resources.

## Setup Guide
1. Clone the Repository
2. Install App Dependencies (bundle install)
3. Set up Database (rails db:drop, rails db:create, rails db:migrate, rails db:seed)
4. Run the server locally (rails s)

## Endpoints
### Users
	•	GET /api/v1/users - Get a list of all users
	•	GET /api/v1/users/:id - Get a specific user
	•	POST /api/v1/users - Create a new user
	•	PATCH/PUT /api/v1/users/:id - Update a user
	•	DELETE /api/v1/users/:id - Delete a user
 
 ### Artists
	•	GET /api/v1/artists - Get a list of artists (with optional search parameters)
	•	POST /api/v1/artists - Add an artist to a user’s saved artists
	•	DELETE /api/v1/artists/:id - Remove an artist from a user’s saved artists

 ### Events 
	•	GET /api/v1/events - Get a list of all events
	•	GET /api/v1/events/:id - Get a specific event
 	•	POST /api/v1/user_events - Create an event for a user
	•	DELETE /api/v1/user_events/:id - Remove a user from an event
	•	GET /api/v1/users/:user_id/user_events - Get all events associated with a specific user
	•	GET /api/v1/users/:user_id/user_events/:id - Get a specific event associated with a specific user

  ### Attendees 
	•	POST /api/v1/attendees - Add a user to an event's attendees
	•	DELETE /api/v1/attendees/:id - Remove a user from an event's attendees
	•	GET /api/v1/events/:event_id/attendees - Get a list of all attendees for a specific event



 ### Example Requests
    Deployed URL: https://concertmate-rails-9f7aa871924c.herokuapp.com/

 1. Create a user
    POST http://localhost:3000/api/v1/users 
  {
    "name": "John Doe",
    "email": "john.doe@example.com"
  }

2. Add an Artist to a Users saved artist
   POST http://localhost:3000/api/v1/artists
   {
    "artist": {
      "name": "The Beatles",
      "musicbrainz_id": "some-unique-id"
    },
    "user_id": 1
  }

3. Creating an Event
  POST http://localhost:3000/api/v1/users/1/user_events 
  {
    "event_name": "Concert Event",
    "venue_name": "Stadium",
    "date_time": "2024-12-01T18:00:00",
    "location": "New York"
  }

4. Deleting an Event
   DELETE http://localhost:3000/api/v1/users/1/user_events/1

5. Adding a User to and Event as an Attendee
  POST http://localhost:3000/api/v1/attendees
  {
    "user_id": 1,
    "event_id": 1
  }

6. Removing a User from an Event
  DELETE http://localhost:3000/api/v1/attendees
  {
    "user_id": 1,
    "event_id": 1
  }

7. Getting All Attendees for an Event
  GET http://localhost:3000/api/v1/events/1/attendees

8. Getting All Events for a User
  GET http://localhost:3000/api/v1/events/1/attendees

9. Getting a specific Event for a User
  GET http://localhost:3000/api/v1/users/1/user_events/1

## Database Schema
<img width="1056" alt="Screenshot 2024-09-12 at 12 44 29 PM" src="https://github.com/user-attachments/assets/d3bf9539-faa6-4ed8-b847-c3de5f3867cd">



## Current Contributors 
- Rodrigo Chavez
  - [Github](https://github.com/RodrigoACG)
  - [Linkedin](https://www.linkedin.com/in/rodrigo%2Dchavez1/)

- Clyde Autin
  - [Github](https://github.com/clydeautin)
  - [Linkedin](https://www.linkedin.com/in/clydeautin/)

- Garrett Bowman
  - [Github](https://github.com/GBowman1)
  - [Linkedin](https://www.linkedin.com/in/gbowman3/)
