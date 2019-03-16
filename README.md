# thames-clippers-timetables-api

[![CircleCI](https://circleci.com/gh/johnboyes/thames-clippers-timetables-api.svg?style=shield)](https://circleci.com/gh/johnboyes/thames-clippers-timetables-api)

Thames Clippers timetable data in a [GraphQL](https://graphql.org/) API.

This GraphQL API is not itself an official TFL API - the source data is though, from [TFL's open data](https://tfl.gov.uk/info-for/open-data-users/) API.

## Prerequisites

To retrieve the source timetable data from TFL you need to:

- [Register for a TFL Application ID and Key](https://api.tfl.gov.uk/), if you do not already have one
- Set the application ID and Key as the following two environment variables:
  - `TFL_APP_ID`
  - `TFL_APP_KEY`

## Running the test suite

`bundle exec rspec`

## Continuous Integration

[CircleCI](https://circleci.com/gh/johnboyes/thames-clippers-timetables-api) is the continuous integration build server.

## Continuous Deployment

The app deploys to [Heroku](https://heroku.com), using [Heroku's automatic GitHub deploys](https://devcenter.heroku.com/articles/github-integration#automatic-deploys)
