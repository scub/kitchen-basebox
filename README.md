# kitchen-basebox

test-kitchen driven collection of formulas meant to form a testable system baseline


### Project Layout

The following tree is an attempt to describe the structure of the project

```

 .
 |__ formulas # This is a place holder for any private
 |            # formula repositories that would be supplied
 |            # through the `path` subsystem as git-submodules
 |
 |
 |__ pillars  # Contains the pillar trees for inclusion in our available `suites`,
 |    |       # In this approach each suite is broken into its own defintion and
 |    |       # supplied using the `pillar-from-files` hook.
 |    |
 |    |_ basebox.sls   # Example pillar definition used to create a boxes "state"
 |
 |
 |
 |__ sbin # General utitilty scripts for interacting with the project
 |
 |__ test
      |
      |_ mockup   # Contains one-off states
      |
      |
      |_ integration # Contains integration tests for the frameworks of your choice
          |          # Folders are nested using <suite-name>/<testing-framework>
          |
          |_ helpers  # These contain project-wide hooks for testing frameworks
          |   |
          |   |__ serverspec  # I've defaulted to using `busser-serverspec`, youre
          |        |          # good here until busser-servspec loses support.
          |        |
          |        |_ Gemfile    # Contains environment specific pinning abilities,
          |                      # an semi-reprieve from the Gem ecosystem.
          |
          |_ <suite-name>/serverspec # Example definition for using serverspec

```


### Environmental Dependencies

`test-kitchen` and `vagrant` are the main drivers of this project, along with the
awesome work done by the https://www.github.com/saltstack-formulas team.


Required gems:
```
test-kitchen
kitchen-salt
kitchen-vagrant
```

Provider specific gems can be utilized for creating live environments,
I like `kitchen-linode` but there are a myriad of others.

Recommmended gems:
```
kitchen-linode
```


### Debugging and live hacking

All state and pillar data is synced into `/tmp/kitchen`, if youre in a pinch
where logs aren't helping you can fire salt-call's from inside the container.

`kitchen login <suite_name>` is the way into any container, from there you
are able to manipulate salt like so:

```
$ salt-call -c /tmp/kitchen/etc/salt state.show_top
$ salt-call -c /tmp/kitchen/etc/salt state.highstate test=true
```
