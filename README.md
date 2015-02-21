jurny
-----

An app to track your journeys.

- - -

# Public API

## New User

Creates a user in the system.

/users (POST)

* email (required)
* password (required)

Success Response: 201

Example:

    {
      "users": {
        "id": "NEW_USER_ID"
      }
    }

## Login

Creates (and replaces) the token for the user with the given email as long as the password matches.

/tokens (POST)

* email (required)
* password (required)

Success Response: 201

Example:

    {
      "tokens": {
        "id": "NEW_TOKEN_ID"
      }
    }

# User API

All User API endpoints must include the HTTP Authorization header in the following format:

    Token token="TOKEN_ID", email="USER_EMAIL"

## Logout

/tokens/:token_id (DELETE)

Token ID must match the current user's token. A user cannot log out another user.

Success Response: 200

Empty response body.

- - -

Copyright David Sewell 2015
