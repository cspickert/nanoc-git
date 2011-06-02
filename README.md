## What is this?

`nanoc-git` makes deploying your [Nanoc3](http://github.com/ddfreyne/nanoc) site via git as easy as typing:

    rake deploy:git
  
## Why would I want to use it?

If you're developing a static [GitHub Pages](http://pages.github.com/) site but don't want to use [jekyll](https://github.com/mojombo/jekyll/wiki), and you want to keep your site's source and output in the same repository, `nanoc-git` is for you.
  
## How do I use it?

1. Add your git repository information to your site configuration file. You'll need to specify a destination remote and branch, and a source branch like so:

        deploy:
          default:
            dst_remote: origin
            dst_branch: master
            src_branch: source

      You should set these branches up in advance. The [project pages](http://pages.github.com/#project_pages) section of the GitHub Pages documentation has some good tips on how to do this (take a look at the `gh-pages` setup instructions).

2. Add `nanoc-git` to your `Gemfile` or install it manually via `gem install nanoc-git`.

3. Add `require 'nanoc-git/tasks'` to your `Rakefile`.

4. Type `rake deploy:git` at the command line to send your compiled site to its destination.

## Does it work?

**Consider this project alpha quality**. It works for me, but I can't make any guarantees for other users. It shouldn't do any damage (you can always revert to an earlier commit), but use it at your own risk.

## License

You're free to do whatever you like with the code. I welcome any and all improvements and suggestions.
