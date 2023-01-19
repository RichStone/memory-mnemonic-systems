# A WIP app

![WIP screenshot](docs/WIP-screenshot.png)

## Notes for docker file

* postgresql
* brew install vips

## DB seed

To populate the DB with default images and major systems:

```shell
# locally
$ br db:seed
$ br db:seed:replant
# heroku
$ heroku run rake db:seed
$ heroku run rake db:seed:replant
```

`seeds.rb` contains more rules and instructions.

You might want to empty and clean up the AWS bucket at some point.

## TODOs

- [x] show all brain specific showing the same as in public but without the whole turbo stuff
- [x] create a major system with brain in seeds
- [x] check Brain sees good stuff when going to the brain major system show page
- [x] make quick links and metadata nice in Brain show page
- [x] use cards for Brain#show pegs
- [x] make similar in public

Conversion:

- [x] ~add `resource_id` to Conversion ActiveModel and params~
- [ ] continue with: Controller test => system test => service test
- [ ] validate resource to be copied exists
- [ ] convert a major system to a brain major system (only reference images, not hard copy)
- [ ] add conversion limit

Next up:

- [ ] add spaced repetition gem
- [ ] add footer
- [ ] add heroicon gem for icons https://github.com/bharget/heroicon
- [ ] source the peg visuals
- [ ] share with memory trainers and book authors
- [ ] add monitoring/error tracing solution
