# Bundler Bug with Git Cached Gems

## Initial setup

To get started, clone this repo locally, `cd` into that directory, and switch to the `wrong_structure` branch:

```console
git switch wrong_structure
```

## Build successfully with older Bundler

We've set a `BUNDLER_VERSION` argument in the Dockerfile to a known working version: `2.5.10`.

Build the Docker image (naming it "cache_bug"):

```console
docker build --no-cache --tag=cache_bug --progress=plain ./
```

Then run the `hello` executable:

```console
docker run -it cache_bug
```

### What do we expect to happen?

If you look at the build output you'll notice that the RubyGem dependencies were not met, so they were installed.
Those Gems are vendored in `vendor/cache` and we `COPY`'d that entire directory into the image.
So they were installed from the cache, as expected.

```log
#11 [5/6] RUN gem install bundler -v 2.5.10 --no-document &&     bundle _2.5.10_ config set --local deployment "true" &&     bundle _2.5.10_ config set --local path "vendor/bundle" &&     bundle _2.5.10_ check || bundle _2.5.10_ install --local --retry=3 &&     bundle _2.5.10_ clean
#11 0.595 Successfully installed bundler-2.5.10
#11 0.595 1 gem installed
#11 0.825 The following gems are missing
#11 0.825  * puma (6.4.3)
#11 0.825  * nio4r (2.7.4)
#11 0.825 Install missing gems with `bundle install`
#11 0.999 Installing nio4r 2.7.4 with native extensions
#11 3.109 Installing puma 6.4.3 with native extensions
#11 5.237 Bundle complete! 2 Gemfile dependencies, 4 gems now installed.
#11 5.237 Bundled gems are installed into `./vendor/bundle`
#11 DONE 5.4s
```

## Trigger the bug

Open the `Dockerfile` and change `BUNDLER_VERSION` to `2.5.23`, which is the latest Bundler release as of today.
Re-build the image:

```console
docker build --no-cache --tag=cache_bug --progress=plain ./
```

Bundler will again see that the dependencies are not satisfied.
But rather than install from the `vendor/cache`, it fetches the git-sourced dependency (puma-plugin-telemetry) from GitHub.

```log
#11 [5/6] RUN gem install bundler -v 2.5.23 --no-document &&     bundle _2.5.23_ config set --local deployment "true" &&     bundle _2.5.23_ config set --local path "vendor/bundle" &&     bundle _2.5.23_ check || bundle _2.5.23_ install --local --retry=3 &&     bundle _2.5.23_ clean
#11 0.595 Successfully installed bundler-2.5.23
#11 0.595 1 gem installed
#11 0.829 Bundler can't satisfy your Gemfile's dependencies.
#11 0.829 Install missing gems with `bundle install`.
#11 0.997 Fetching https://github.com/stevenharman/puma-plugin-telemetry.git
#11 1.722 Installing nio4r 2.7.4 with native extensions
#11 3.771 Installing puma 6.4.3 with native extensions
#11 5.874 Bundle complete! 2 Gemfile dependencies, 4 gems now installed.
#11 5.874 Bundled gems are installed into `./vendor/bundle`
#11 DONE 6.0s
```

Even though the Git-sourced dependency is in `vendor/cache`, Bundler is fetching it from the GitHub.
I suspect this is due to the cache structure being the "old" shallow checkout structure?

## Try the new structure

At this point on my machine (outside of the Docker image) I deleted the git-sourced directory from `vendor/cache`, switched to the latest Bundler, and re-installed the Git-sourced dependency.
I then committed that to Git.
That is, I did this (but you don't need to):

```console
rm -rf vendor/cache/puma-plugin-telemetry-d904b8429739
gem install bundler -v 2.5.23
bundle _2.5.23_ install
git add --all && git commit
```

Instead of all of that, please check out the `new_structure` branch with those changes already done.

```console
git switch new_structure
```
