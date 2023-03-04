
# Backend Ampio

This is the backend of the application Ampio that will be presented on the 2nd Edition of the DevHunt organised by ENI Fianarantsoa.

## API Reference

### Users

#### Login

```http
  POST /api/auth/login
```

```json
{
    "identity": "nanta", # username or email
    "password": ""
}
```

#### Get all users

```http
  GET /api/users
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### Get user by id

```http
  GET /api/users/:id
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `int` | **Required**. Id of user to fetch |

#### Get current authenticated user

```http
  GET /api/users/me
```

#### SignUp

```http
  POST /api/users/signup
```

```json
{
    "matricule": 0000,
    "username": "john",
    "email": "johndoe@gmail.com",
    "avatar": "pdp.jpg",
    "password": "password"
}
```

#### Logout

```http
  POST /api/users/logout
```

#### Get user by id

```http
  PATCH /api/users/password
```

```json
{
    "old_password": "",
    "new_password": "",
    "confirm_pass": ""
}
```

| Auth | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `cookie`      | `string` | **Required**. The user's token as a cookie |

#### Change Avatar

```http
  PATCH /api/users/me/avatar
```

```json
{
    "avatar": "file.png"
}
```

### Posts

#### List all Posts

```http
  GET /api/posts
```

#### Publish a post

```http
  POST /api/posts
```

```json
{
    "title": "Title",
    "content": "Content",
    "file": "file.pdf"
}
```

| Auth | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `cookie`      | `string` | **Required**. The user's token as a cookie |

### Comments

#### Get all comments in a post

```http
  GET /api/comments/:post_id
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `post_id`      | `int` | **Required**. Id of post where to fetch comments |

#### Post a comment

```http
  POST /api/comments/:post_id/comment
```

```json
{
    "content": "This is a comment to be published",
    "file": "file.pdf"
}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `post_id`      | `int` | **Required**. Id of post where to fetch comments |

| Auth | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `cookie`      | `string` | **Required**. The user's token as a cookie |

#### Delete comment

If the connected user is the author of the comment, delete is possible

```http
  DELETE /api/comments/:id
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `int` | **Required**. Id of comment to delete |

| Auth | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `cookie`      | `string` | **Required**. The user's token as a cookie |

### Topics

#### List all available Topics

```http
  GET /api/topics
```

#### Create new topic

```http
  POST /api/topics
```

```json
{
    "content": "javascript",
    "image": "logo.png"
}
```
