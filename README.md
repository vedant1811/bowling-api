# README

## Hosted on Heroku

App is live at [https://bowling-score-api.herokuapp.com/](https://bowling-score-api.herokuapp.com/)

## Usage

*(Usage info is mentioned at the root path `/`)*

create a new game:

    POST /games

note the `id` in the response

record a new ball played:

    POST /games/:game_id/new_ball

see game score with breakdown

    GET /games

## Local Installation

`git clone` the repository

run `bundle` inside the dir

setup the database:

create the postgres user:

    postgres=# create user rails with password 'rails';
    postgres=# alter role rails  superuser createrole createdb replication;

create the database and set the schema:

    $ rails db:setup

run the server:

    $ rails server

run the tests:

    $ rails test


## About

This is a rails api to keep track of bowling games.

Multiple games can be played simultaneously. Any number of games can be created.
The game id (which is a `UUID`) serves as a secret token. Only users who have this
token can update the game, and see the progress.

#### Architecture

Due to the complicated nature of scoring of bowling game, there is **a lot of business logic;
hence a lot of unit tests.**

I tried to keep a simple architecture:

* In the database only the pins that were dropped are stored. Rest all of the score information
can be calculated based on this data

* All necessary validations are performed (pins must be between 0 and 10, game is not completed)
when a new ball play is recorded

Almost all the business logic (actions on new ball, score calculation) is performed
inside the Game model.

I avoided cyclic dependencies, by making sure that Game calls Frame, and not vice-versa.

Game -> Frame

Same for, Frame -> Ball

The app looked simple on the outside but I quickly ran into a lot of corner cases to

* record a new ball played

* calculate the score

#### Ode to TDD

I relied on TDD. Created my tests and made them pass one by one, and gradually
an architecture emerged.
