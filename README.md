# Dragon Blaster

#### Contributors: [Lauren Scott](https://github.com/devdame), [Neal Peters](https://github.com/nealcpeters), [Eric Stensland](https://github.com/estensland) , [Diana Calvache](https://github.com/calvached)

## Ruby version

Built in Ruby 2.0.0p353 and Rails 4.0.3


## Configuration

Clone the repo
Then execute:
```
bundle install
```
Start server with:
```
rails s
```
Check out project at localhost:3000

## Database creation
```
rake db:create
```

## Database initialization
```
rake db:migrate
rake db:seed
```

Extensive seed file with premade games, maps, and rooms.

## How to run the test suite
```
rake rspec
```

## Game Play

1. Create a name and description for your map.
2. Click on individual boxes in the grid in order to add rooms to your map.  
3. Each room can be applied a name and description.

## Contributing
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request