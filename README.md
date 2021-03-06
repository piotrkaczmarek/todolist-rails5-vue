## Stack
Rails 5.2 (backend) + Vue (frontend) - the very productive modern stack with minimal boilerplate code and elegant conventions that allow implementation of business logic with a very few lines of code. The less code, the more readable it is, the easier it is to change and maintain it.


## Implementation Walkthrough
The starting point is the `GET /`[root endpoint](https://github.com/piotrkaczmarek/todolist-rails5-vue/blob/master/config/routes.rb#L2) which serves [the Vue frontend](https://github.com/piotrkaczmarek/todolist-rails5-vue/tree/master/app/javascript).

The frontend [fetches the item list](https://github.com/piotrkaczmarek/todolist-rails5-vue/blob/master/app/javascript/components/items.vue) from API `GET /items` [endpoint](https://github.com/piotrkaczmarek/todolist-rails5-vue/blob/master/app/controllers/items_controller.rb#L3) and exposes [addItem, deleteItem, updateItem,  upvoteItem, downvoteItem](https://github.com/piotrkaczmarek/todolist-rails5-vue/blob/master/app/javascript/components/items.vue#L39-L75) methods that communicate with [API endpoints handled by ItemsController](https://github.com/piotrkaczmarek/todolist-rails5-vue/blob/master/app/controllers/items_controller.rb#L6-L46). As most backend business logic is handled by ItemsController it is covered with [items_controller_spec](https://github.com/piotrkaczmarek/todolist-rails5-vue/blob/master/spec/controllers/items_controller_spec.rb).
Database communication together with validations and downvote, upvote methods are handled by [Item model class](https://github.com/piotrkaczmarek/todolist-rails5-vue/blob/master/app/models/item.rb) (tested with [item_spec](https://github.com/piotrkaczmarek/todolist-rails5-vue/blob/master/spec/models/item_spec.rb)).


## Setup
````
gem install foreman
bundle
rails db:create
rails db:migrate
````

## Running App
````
foreman start
````
Visit `http://localhost:3000/`

## Running Tests
````
rspec
````
