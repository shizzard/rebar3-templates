# Rebar Templates

Requirements: erlang, git, rebar3.

Based on lukyanov's [rebar3-templates](https://github.com/lukyanov/rebar3-templates).

## How to use templates

To make the templates available, you need to clone the repo to your
`~/.config/rebar3/templates` directory:

    mkdir -p ~/.config/rebar3/templates
    git clone <this_repo_url> ~/.config/rebar3/templates

## Creating Erlang/OTP service layout

If you want to create a new directory layout for your new service you can do the following:

    $ mkdir <service_name>
    $ cd <service_name>
    $ rebar3 new service name=<service_name> name_upper=<SERVICE_NAME> description="Describe your service here."
    $ ./run.me.first.sh

Note: You need `rebar3` installed in your system, or placed in `<service_name>` directory.

This will generate the initial framework of an Erlang service that supports
Erlang/OTP releases.

Now you can build your new service:

    $ make

To run release you can run:

    $ make run-release

Note: see `config/sys.config` file to understand the way release is being configured. To change configuration variable globally change it in the `Makefile`; to redefine something locally you can use something like [direnv](https://direnv.net).

You can also run dialyzer, eunit and ct:

    $ make check

See `Makefile` contents for more options.

## Creating yet another application

    $ rebar3 new application name=<name>

Here `<name>` is erlang application name.

## Creating eunit test

    $ rebar3 new eunit-test app=<app> name=<test_name>

Here `<app>` is erlang application name from your `apps` folder, and `<test_name>` is the name of the test, prepended to standard `_tests` suffix.

## Creating ct suite

    $ rebar3 new ct-suite name=<test_name>

Here  `<test_name>` is the name of the suite, prepended to standard `_SUITE` suffix.
