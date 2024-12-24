# Blog Application | Ruby on Rails
[API DOCS](https://documenter.getpostman.com/view/23734957/2sAYJ3G2SJ)

Building a Ruby on Rails API for a blog application that uses JWT-based authentication to secure all endpoints. The API includes CRUD operations for posts and comments, with authorization policies to control user access. Additionally, posts are automatically scheduled for deletion 24 hours after creation, ensuring a dynamic and secure application flow.

## Installation


```bash
docker-compose up --build
```

## Features

### 1. Token Generation and Validation
- JWT is integrated to generate and validate tokens.
- A service class `JsonWebToken` is created to handle token operations. The service class is located in:

### 2. Authentication Methods
- The `authenticate_user` method is implemented in `ApplicationController` to ensure authentication for requests.
- A method to retrieve the current authenticated user, accessible using `current_user` in the controllers.

### 3. Usage
- Use the `before_action :authenticate_user` in any controller to ensure that all actions require authentication.
- Access the currently authenticated user using `current_user` within the controllers.


### 3. Post CRUD Operations
- Full CRUD operations on Posts:
  - Create, Read, Update, Delete
- A Post has many Comments and belongs to a User.
- Each Comment is a separate entity and belongs to both a User and a Post.
- Tags can be added to a Post via a request as an array. The tags will be joined by a comma and stored as a string in the database.

### 4. Comment Management
- A Post has many Comments.
- A Comment belongs to a Post and a User.
- Comments can be created, updated, or deleted by their respective authors.
- The Post's author can delete any Comment associated with their Post.
- A Comment’s author can edit or delete their own Comment.

### 5. Policies
- **Post Policies**:
  - The Post’s author can only delete or edit their own Post.
- **Comment Policies**:
  - The Post’s author can delete any Comment associated with their Post.
  - A Comment’s author can edit or delete their own Comment.

### 6. Background Jobs with Sidekiq
- Integration with **Sidekiq** for background tasks.
- Posts are automatically deleted **24 hours after their creation**. A Sidekiq job checks for posts older than 24 hours and deletes them.


