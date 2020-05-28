# dotfiles

Here's a bunch of settings for various tools I use.

There's also a
[complete list of tools](https://nickjanetakis.com/blog/the-tools-i-use) I use
on my site along with a
[bunch of blog posts](https://nickjanetakis.com/blog/tag/dev-environment-tips-tricks-and-tutorials)
explaining how and why I use them.

## Screenshots

Since my dotfiles are constantly evolving and I tend to reference them in
videos, blog posts and various social media posts I thought it would be a good
idea to include a screenshot of each theme I used and how to switch to it.

### April 14th 2020 (current)

The theme used in the screenshot below is [One
Dark](https://github.com/joshdick/onedark.vim).

![Dotfiles](https://nickjanetakis.com/assets/blog/dotfiles-2020-04-14-6bd45461ac04cdffd6604f35ab73388fb9da4821f55e3445a5568a9b4d2bb3d0.jpg)

#### Why did I switch to this theme?

Like Gruvbox, it has really good syntax highlighting support for the
technologies I work with on a regular basis.

I never used Atom Dark before, so it still looks fresh to me.

I still think Gruvbox is great. Truthfully after almost 18 months of using it
I started to get bored. I have nothing against Gruvbox and if you like its
colors then it's a solid pick.

When it comes to One Dark, I'm really enjoying the blue tint to things. There's
also very good contrast on most things. The only exception to that are
comments but I think I can get used to that. They are not obnoxiously dim.

### December 18th 2018

The theme used in the screenshot below is
[Gruvbox](https://github.com/gruvbox-community/gruvbox).

![Dotfiles](https://nickjanetakis.com/assets/blog/dotfiles-c85f20a61decb0d4676530ff4c65a818ee9b362cf9f380a76c9d44e1254d03f3.jpg)

If you want to use this theme instead of the current theme:

1. Edit your `.vimrc` file to make these changes:

```vim
" Gruvbox theme.
Plug 'gruvbox-community/gruvbox'

" Set the color scheme to use Gruvbox.
colorscheme gruvbox
```

2. Edit your `.tmux.conf` file to use these color settings:

```
set -g status-fg colour244
set -g status-bg default

set -g pane-border-fg default
set -g pane-border-bg default
set -g pane-active-border-fg colour250
set -g pane-active-border-bg default

set-window-option -g window-status-current-attr bold
set-window-option -g window-status-current-fg colour223
```

3. Change your terminal's theme (this will depend on which terminal you use)

#### Why did I choose this theme?

It has excellent syntax highlighting support for a bunch of popular programming
languages. It also has top notch support for both dark and light variants.

The contrast is very good in both variants which is important to me because I
record video tutorials. It also makes it easy on my eyes to pick out different
characters when programming and writing all day.

Lastly, I was a big fan of the Quake video game and its colors remind of
Quake's color palette in the dark variant.
