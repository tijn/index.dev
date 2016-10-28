# index.dev

A small app to show what's in your ~/.pow or ~/.prax

It will actually show what's in ~/.pow *and* in ~/.prax, but that's okay too I guess.

# How to use

It won't be useful to you unless you install [Pow](http://pow.cx/) or [Prax](http://ysbaddaden.github.io/prax/) so make sure you have one of those installed.

- This is a smalll Sinatra app. You should first install the nescessary Rubygems with `bundle install`.
- Then, put a symlink in your `~/{.pow|.prax}/`.
- Something like `ln -s ~/src/index.dev ~/.pow/index` would work. (Adapt it to your own situation.)
- Then open your browser and go to http://index.dev

# Attribution

This project is using some [icons from Google's Material Design](https://github.com/google/material-design-icons/) that they published under the Apache License Version 2.0.

# Icons

You may copy an icon to the `_icons` directory in `~/.pow` or `~/.prax/`.
Alternatively you may also choose to use the hidden `.icons` directory.
If the icon has the same name as your app, `{{app_name}}.svg` or `{{app_name}}.png`, then the index will show it instead of the lightbulb.

All icons will be scaled to 48x48.
I don't recommend using anything with a lower resolution since it will probably look a bit blurry.

The index will also consider parent domains to find an icon.
That means that if you didn't copy an icon for `www.example.com.dev`, the icon for `example.com.dev` or `com.dev` will be used, provided any of those exist.

I couldn't think of any useful heuristics to automatically grab favicons from the app directory. If you do, any help is appreciated!
