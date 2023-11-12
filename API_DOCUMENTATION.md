# TimeManager API

## API DOCUMENTATION

### Authentication

Our API uses Bearer authentication. If you are a new user you must first register so we can add your credentials to the database. After registering you must use the sign-in endpoint to obtain a Bearer token which must be embedded in your request headers for every request you make to the remaining endpoints.

#### Register

A register payload should look like this: 

```
{
    "user":
    {
        "username": "example_username",
        "email": "example_email@email.com",
        "password": "1234ThisIsAPassword!"
    }
}
```

To register you must send a POST request with the payload above to the following endpoint : ```/api/register```

#### Sign-in

A sign-in payload should look like this:

```
{
    "email": "example_email@email.com",
    "password": "1234ThisIsAPassword!"
}
```

To sign-in you must send a POST request with the payload above to the following endpoint : ```/api/signin```

You will recieve a token in your response which should then be added to your request headers for the next API calls.

### Users

A default user payload should look like this:

```
{
    "username": "example_username" (string),
    "email": "example_email@email.com" (string)
}
```

<details>
    <summary><span style="font-size: 15px">GET</span></summary>
        <div style="margin-left: 20px;">
            <details>
                <summary><span style="font-size: 15px">/api/users</span></summary>
                <div style="margin-left: 20px;">
                Returns a JSON list of all available users.
                </div>
            </details>
            <details>
                <summary><span style="font-size: 15px">/api/users?email=XXX&username=YYY</span></summary>
                <div style="margin-left: 20px;">
                Returns a JSON element corresponding to the username and email.
            </div>
            </details>
            <details>
                <summary><span style="font-size: 15px">/api/users/:userID</span></summary>
                <div style="margin-left: 20px;"> 
                Returns a JSON element corresponding to the specified userID.
            </div>
            </details>
        </div>
</details>

<details>
    <summary><span style="font-size: 15px">PUT</span></summary>
        <div style="margin-left: 20px;">
            <details>
                <summary><span style="font-size: 15px">/api/users/userID</span></summary>
                <div style="margin-left: 20px;">
                Updates an entry in the database. Use default user payload in every request.
            </div>
            </details>
        </div>
</details>

<details>
    <summary><span style="font-size: 15px">DELETE</span></summary>
        <div style="margin-left: 20px;">
            <details>
                <summary><span style="font-size: 15px">/api/users/userID</span></summary>
                <div style="margin-left: 20px;">
                Deletes the specified entry in the database.
            </div>
            </details>
        </div>
</details>

### Workingtimes

A default working_time payload should look like this:

```
{
    "workingtime":
        {
            "start": "2023-10-23 09:30:00" (datetime),
            "end": "2023-10-23 17:30:00" (datetime),
            "user": {id} (int)
        }
}
```

<details>
    <summary><span style="font-size: 15px">GET</span></summary>
        <div style="margin-left: 20px;">
            <details>
                <summary><span style="font-size: 15px">/api/users</span></summary>
                <div style="margin-left: 20px;">
                Returns a JSON list of all available workingtimes.
            </div>
            </details>
            <details>
                <summary><span style="font-size: 15px">/api/workingtimes/userID?start=XXX&end=YYY</span></summary>
                <div style="margin-left: 20px;">
                Returns a JSON element corresponding to the start and end.
            </div>
            </details>
            <details>
                <summary><span style="font-size: 15px">/api/workingtimes/userID</span></summary>
                <div style="margin-left: 20px;">
                Returns all JSON elements corresponding to the specified userID's workingtimes.
            </div>
            </details>
            <details>
                <summary><span style="font-size: 15px">/api/workingtimes/userID/:id</span></summary>
                <div style="margin-left: 20px;">    
                Returns a JSON element corresponding to the specified userID and workingtime id.
            </div>
            </details>
        </div>
</details>

<details>
    <summary><span style="font-size: 15px">POST</span></summary>
        <div style="margin-left: 20px;">
            <details>
                <summary><span style="font-size: 15px">/api/workingtimes/userID</span></summary>
                <div style="margin-left: 20px;">
                Creates an entry in the database for the user with userID. Use default user payload in every request.
            </div>
            </details>
        </div>
</details>

<details>
    <summary><span style="font-size: 15px">PUT</span></summary>
        <div style="margin-left: 20px;">
            <details>
                <summary><span style="font-size: 15px">/api/workingtimes/id</span></summary>
                <div style="margin-left: 20px;">
                Updates an entry in the database at workingtime id. Use default user payload in every request.
            </div>
            </details>
        </div>
</details>

<details>
    <summary><span style="font-size: 15px">DELETE</span></summary>
        <div style="margin-left: 20px;">
            <details>
                <summary><span style="font-size: 15px">/api/workingtimes/id</span></summary>
                <div style="margin-left: 20px;">
                Deletes the specified entry in the database.
            </div>
            </details>
        </div>
</details>

### Clocks

A default clock payload should look like this:

```
{
    "clock":
        {
            "status": true,
            "time": "2023-10-23 17:30:00",
            "user": {id} (int)
        }
}
```

<details>
    <summary><span style="font-size: 15px">GET</span></summary>
        <div style="margin-left: 20px;">
            <details>
                <summary><span style="font-size: 15px">/api/clocks/userID</span></summary>
                <div style="margin-left: 20px;">
                Returns a JSON element of the userID's corresponding clock.
                </div>
            </details>
        </div>
</details>

<details>
    <summary><span style="font-size: 15px">POST</span></summary>
        <div style="margin-left: 20px;">
            <details>
                <summary><span style="font-size: 15px">/api/clocks/userID</span></summary>
                <div style="margin-left: 20px;">
                Modifies the specified user's clock.
            </div>
            </details>
        </div>
</details>
