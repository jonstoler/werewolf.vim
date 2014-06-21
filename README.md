# werewolf.vim

Werewolf changes your vim colorscheme automatically based on the time of day, allowing you to use a light theme during the day but "transform" to a dark theme once the sun goes down.

# Installation

## Manual

```
git clone https://github.com/jonstoler/werewolf.vim.git
cp -R werewolf.vim .vim
```

## Pathogen

```
cd ~/.vim/bundle
git clone https://github.com/jonstoler/werewolf.vim.git
```

# Settings

## Theme Matching

You need to set day/night themes. Each day theme needs a single corresponding night theme.

Note that you're free to use themes not defined in either of these lists, but Werewolf will ignore them.

In your `.vimrc`:

```
let g:werewolf_day_themes = ['day1', 'day2', 'day3']
let g:werewolf_night_themes = ['night1', 'night2', 'night3']
```

## Time of Day

Werewolf will transform between day and night based on two variables:

```
" default 8, use 24 hour format
let g:werewolf_day_start = 8

" default 20, 24 hour format
let g:werewolf_day_end = 20
```

The default settings have Werewolf transform to day at 8:00 AM and transform to night at 8:00 PM.

## Automatic Transformation and Toggling

By default, Werewolf will automatically transform at the hours you specify. However, you can also control it manually if you wish:

```
" this defaults to 1, set it to 0 to control Werewolf manually
let g:werewolf_change_automatically = 0
```

You can then call `WerewolfToggle()` to switch between day and night themes at any time, or call `Werewolf()` to change to the proper theme based on your `day_start` and `day_end` settings.
