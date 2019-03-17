# thames-clippers-timetables-api

https://thames-clippers-timetables-api.herokuapp.com/graphql

[![CircleCI](https://circleci.com/gh/johnboyes/thames-clippers-timetables-api.svg?style=shield)](https://circleci.com/gh/johnboyes/thames-clippers-timetables-api)

Thames Clippers timetable data in a [GraphQL](https://graphql.org/) API.

This GraphQL API is not itself an official TFL API - the source data is though, from [TFL's open data](https://tfl.gov.uk/info-for/open-data-users/) API.

## Getting started

1. Install [Graph*i*QL](https://github.com/skevy/graphiql-app)
2. Open Graph*i*QL
3. Set the GraphQL Endpoint in Graph*i*QL to be: https://thames-clippers-timetables-api.herokuapp.com/graphql
4. Try out some queries.  Graph*i*QL has automatic documentation explaining how to structure your queries

Here is an example query:
```
{
    routing(from: WANDSWORTH_RIVERSIDE_QUARTER_PIER, to: BLACKFRIARS_PIER) {
        from
        to
        sailings {
            departureTime
            arrivalTime
        }
    }
}
```


## Prerequisites for deployment

To retrieve the source timetable data from TFL you need to:

- [Register for a TFL Application ID and Key](https://api.tfl.gov.uk/), if you do not already have one
- Set the application ID and Key as the following two environment variables:
  - `TFL_APP_ID`
  - `TFL_APP_KEY`

## Running the app locally

`bundle exec rails server`

## Running the test suite

`bundle exec rspec`

## Continuous Integration

[CircleCI](https://circleci.com/gh/johnboyes/thames-clippers-timetables-api) is the continuous integration build server.

## Continuous Deployment

The app deploys to [Heroku](https://heroku.com), using [Heroku's automatic GitHub deploys](https://devcenter.heroku.com/articles/github-integration#automatic-deploys)
