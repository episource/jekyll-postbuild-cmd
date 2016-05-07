# jekyll-postbuild-cmd

A Jekyll plugin that runs arbitrary commands after the site has been build.
 
## Prerequisites
None.

## Installation
Add the plugin to your `_plugins` folder. This could be done as submodule:
```
git submodule add https://github.com/episource/jekyll-postbuild-cmd.git _plugins/jekyll-postbuild-cmd
```

## Usage
Configure the commands to be executed in your `_config.yml`:
```yaml
postbuild:
    - echo first command
    - echo command with substitution - baseurl=%{baseurl} dest=%{dest} source=%{source}
    - echo second command
```

The command may include predefined tokens to be replaced by jenkins site variables:
 - `%{baseurl}` -> `site.baseurl`
 - `%{dest}` -> `site.dest`
 - `%{source}` -> `site.source`