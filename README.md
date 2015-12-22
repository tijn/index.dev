# index.dev

A small app to show what's in your ~/.pow or ~/.prax

It will actually show what's in ~/.pow **and** in ~/.prax, but that's okay for you I guess.

# How to use

It won't be useful to you unless you install [Pow](http://pow.cx/) or [Prax](http://ysbaddaden.github.io/prax/) so make sure you have one of those installed.

- This is a smalll Sinatra app. You should first install the nescessary Rubygems with `bundle install`.
- Then, put a symlink in your `~/{.pow|.prax}/`.
- Something like `ln -s ~/src/index.dev ~/.pow/index` would work. (Adapt it to your own situation.)
- Then open your browser and go to http://index.dev

# Icons

I couldn't think of any useful heuristics to grab favicons from the apps. (If you do, any help is appreciated!) For now, you can copy a fairly large icon to the public/ directory in this app. If you name it as `{{app_name}}.png` (replace with the actual name of your app) the index will show it instead of the lightbulb. All icons will be scaled to 48x48. I don't recommend using anything with a lower resolution since it will probably look blurry.
