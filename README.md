# restrict.cr

Adds primitive privilege separation, and chroot to Crystal.
Currently only tested on OpenBSD and macOS.

**Note:** This shard will be removed once similar functionality is added to the standard library.
- [become](https://github.com/crystal-lang/crystal/pull/5627).
- [chroot](https://github.com/crystal-lang/crystal/pull/5577).
- restrict

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  restrict:
    github: chris-huxtable/restrict.cr
```

## Usage

```crystal
require "restrict"
```

Restricting:
``` crystal
Process.restrict("/var/empty", "user", "group")
# restricted environment
```
or,
``` crystal
Process.restrict("/var/empty", "user", "group", wait: true) {
  # restricted environment
}

# runs after block completes. `wait: false` will not wait until block completes.
```

Dropping privileges:
``` crystal
Process.become("user", "group")
```

Chrooting:
``` crystal
Process.chroot("/var/empty")
```

## Contributing

1. Fork it ( https://github.com/chris-huxtable/restict.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [Chris Huxtable](https://github.com/chris-huxtable) - creator, maintainer
