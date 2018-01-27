# privsep.cr

Adds primitive privilege separation to Crystal.
Currently only tested on OpenBSD and macOS.

**Note:** This shard will be removed once similar functionality is [added to the standard library](https://github.com/crystal-lang/crystal/pull/5627).

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  privsep:
    github: chris-huxtable/privsep.cr
```

## Usage

```crystal
require "privsep"
```

Restricting a process:
``` crystal
Process.become("user", "group")
```

## Contributing

1. Fork it ( https://github.com/chris-huxtable/privsep.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [Chris Huxtable](https://github.com/chris-huxtable) - creator, maintainer
