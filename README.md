# Deckard

![Deckard from Blade Runner](assets/brand/deckard.png?raw=true)

## The Pop!_OS api server

### Requirements

- Redis server.
- Erlang/OTP and Elixir. See [.tool-versions](.tool-versions) for all the required tool versions.

#### Redis

The easiest approach is to run Redis using Docker compose, like:

```shell
docker-compose up -d
```

### Initial setup

Install the required language versions, if using [asdf](https://asdf-vm.com/), just run:

```shell
asdf install
```

Then download the dependencies and compile the app:

```shell
mix do deps.get, compile
```

### Running the application locally

You can run Deckard in interactive mode with:

```shell
iex -S mix
```

You can now visit [`localhost:4000`](http://localhost:4000) from your browser.

### Testing

```shell
mix test
```

To produce coverage reports for tests, run:

```shell
mix coveralls.html
```

Now you can view the report in `cover/excoveralls.html`.
