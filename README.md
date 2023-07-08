# [beamring.io](https://beamring.io)

A [webring](https://en.wikipedia.org/wiki/Webring) for the BEAM community

## What is it?

A webring is a colleciton of websites linked together in a ring structure, usually organized around a specific topic.
This one is a collection of sites that talk about the BEAM, which includes Erlang, Elixir, GLEAM and any other language that uses the BEAM vm.

## How do I get added?

Simply add the required ring links to your site, and fill out [this request form](https://github.com/silbermm/beamring/issues/new?assignees=silbermm&labels=new&projects=&template=add_site.yml&title=%5BAdd%5D%3A+).

### Required Links

For the ring to work, each site must link to the next site in the ring. So simply adding a `previous` and `next` link that are available sitewide and links to `https://beamring.io/previous?host=https://yoursite.com` and `https://beamring.io/next?host=https://yoursite.com` respectively, satisfies this condition.

## Future Plans

This is a extremely simple implementation, and I would like to keep it that way.

*BUT*

There are some improvements and features that may make sense:

* I need to add a Terms of Service to indicate that we don't tolerate sites that are or promote intolerance.
* I would like to add an RSS feed that aggregates all the sites RSS feeds together at some point.
* Adding Metrics for each site could be nice.

## Feature requests

If you have a feature request, please fill out an issue in this repo or better yet, create a PR with your requested feature.








