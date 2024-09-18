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

	
  ### Concerts
	•	GET /api/v1/concerts - Gets the top concert for the artist chosen
	

 ### Example Requests
    Deployed URL: https://concertmate-rails-9f7aa871924c.herokuapp.com/

  Http Method, Route, Body
  
 1. Create a user
    POST http://localhost:3000/api/v1/users 
<img width="691" alt="Screenshot 2024-09-13 at 2 39 45 PM" src="https://github.com/user-attachments/assets/c35bfe05-3d5d-4d05-9947-a52aa972d49e">
<hr>


2. Add an Artist to a Users saved artist
   POST http://localhost:3000/api/v1/artists
<img width="652" alt="Screenshot 2024-09-13 at 3 02 18 PM" src="https://github.com/user-attachments/assets/4551116f-ee69-4069-8d0d-cbc8359ce8ba">
<hr>

2. Creating an Event
  POST http://localhost:3000/api/v1/users/1/user_events 
<img width="810" alt="Screenshot 2024-09-13 at 2 56 07 PM" src="https://github.com/user-attachments/assets/3018de10-e5c8-4ffc-b80f-db3844681418">
<hr>


3. Deleting an Event
   DELETE http://localhost:3000/api/v1/users/1/user_events/1
   <img width="666" alt="Screenshot 2024-09-13 at 3 12 25 PM" src="https://github.com/user-attachments/assets/33be3ce9-4945-4837-b50b-900de5ea5413">
<hr>

4. Adding a User to and Event as an Attendee
  POST http://localhost:3000/api/v1/attendees
<img width="565" alt="Screenshot 2024-09-13 at 3 23 11 PM" src="https://github.com/user-attachments/assets/e9db6535-de6c-4a51-a658-c86ac678a9f0">
<hr>

5. Removing a User from an Event
  DELETE http://localhost:3000/api/v1/attendees/:user_id
<img width="598" alt="Screenshot 2024-09-13 at 3 57 21 PM" src="https://github.com/user-attachments/assets/3cb142f0-1fbf-4f7f-9019-9460663af3f2">

<hr>

6. Getting All Attendees for an Event
  GET http://localhost:3000/api/v1/attendees?event_id=:event_id
<img width="592" alt="Screenshot 2024-09-13 at 3 33 05 PM" src="https://github.com/user-attachments/assets/e50a57e6-b22c-4e33-b9e4-e36f78455574">

<hr>

7. Getting All Events for a User
  GET http://localhost:3000/api/v1/users/:user_id/user_events
<img width="646" alt="Screenshot 2024-09-13 at 4 01 26 PM" src="https://github.com/user-attachments/assets/8b847fbf-6ad6-46b4-9c69-74d7052d79e9">
<hr>

8. Getting a specific Event for a User
  GET http://localhost:3000/api/v1/users/:user_id/user_events/:event_id
<img width="607" alt="Screenshot 2024-09-13 at 4 02 25 PM" src="https://github.com/user-attachments/assets/038a4553-e6c4-4232-8f65-effc39ffa845">
<hr>

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
