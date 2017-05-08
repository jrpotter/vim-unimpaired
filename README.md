# unimpaired.vim

Much of unimpaired.vim was extracted from my vimrc when I noticed a
pattern: complementary pairs of mappings.  They mostly fall into four
categories.

There are mappings which are simply short normal mode aliases for
commonly used ex commands. `]q` is :cnext. `[q` is :cprevious. `]a` is
:next.  `[b` is :bprevious.  See the documentation for the full set of
20 mappings and mnemonics.  All of them take a count.

There are linewise mappings. `[<Space>` and `]<Space>` add newlines
before and after the cursor line. `[e` and `]e` exchange the current
line with the one above or below it.

There are mappings for toggling options. `[os`, `]os`, and `cos` perform
`:set spell`, `:set nospell`, and `:set invspell`, respectively.  There's also
`l` (`list`), `n` (`number`), `w` (`wrap`), `x` (`cursorline cursorcolumn`),
and several others. Consult the documentation.

## Installation

If you don't have a preferred installation method, I recommend
installing [pathogen.vim](https://github.com/tpope/vim-pathogen), and
then simply copy and paste:

    cd ~/.vim/bundle
    git clone git://github.com/tpope/vim-unimpaired.git

Once help tags have been generated, you can view the manual with
`:help unimpaired`.

## FAQ

> My non-US keyboard makes it hard to type `[` and `]`.  Can I configure
> different prefix characters?

Not en masse, but you can just map to `[` and `]` directly:

    nmap < [
    nmap > ]
    omap < [
    omap > ]
    xmap < [
    xmap > ]

Note we're not using the `noremap` family because we *do* want to recursively
invoke unimpaired.vim's maps.

There are also `<Plug>` maps if you want a more granular approach.

## Contributing

See the contribution guidelines for
[pathogen.vim](https://github.com/tpope/vim-pathogen#readme).

## Self-Promotion

Like unimpaired.vim? Follow the repository on
[GitHub](https://github.com/tpope/vim-unimpaired) and vote for it on
[vim.org](http://www.vim.org/scripts/script.php?script_id=1590).  And if
you're feeling especially charitable, follow [tpope](http://tpo.pe/) on
[Twitter](http://twitter.com/tpope) and
[GitHub](https://github.com/tpope).

## License

Copyright (c) Tim Pope.  Distributed under the same terms as Vim itself.
See `:help license`.
