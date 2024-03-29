# Monkey
Monkey (%monkey) is an app and agent that binds to eyre and intercepts/relays requests to allow you to:

- inject your code into http responses from other apps
  (poor man's chrome extension, but for Urbit)
- define and handle custom `web+urbitgraph://` links,
  so you can actually redirect to your app
  and then render something relevant

Monkey is used in the background by other apps. For now, there's nothing to do with Monkey as a user, but hopefully one day it will have an app store and management UI for extensions.

# Proposal
You can read the proposal and discuss in the dedicated group on Urbit: `~poster-hoster-midlev-mindyr/monkey`

# The Code
## Desk

The `desk` folder contains all monkey-specific files. `base-desk` contains other hoon files from various places.

### Testing
Tests go in `desk/tests`. To run a test, use the `test` thread in dojo, e.g.:
`-test %%%/monkey/=/tests/lib/monkey ~`

## UI

Monkey is built primarily using [Svelte], [Typescript], and [Tailwind CSS]. [Vite] ensures that all code and assets are loaded appropriately, bundles the application for distribution and provides a functional dev environment.

### Getting Started

To get started using Monkey first you need to run `npm install` inside the `ui` directory.

To develop you'll need a running ship to point to. If it's running somewhere other than `http://localhost:8081`, make a copy of `.env` in the `ui` directory and name it `.env.local`. This file will not be committed. Change `VITE_SHIP_URL` to the URL of the ship you would like to point to.

Once your URL is correctly configured, you can run `npm run dev`. This will proxy all requests to the ship except for those powering the interface, allowing you to see live data.

Regardless of what you run to develop, Vite will hot-reload code changes as you work so you don't have to constantly refresh.

# Deploying

1. Spin up a comet or distribution ship.
2. Mount an `%monkey` desk. In Dojo:
    1. `|merge %monkey our %base` to create a new desk.
    2. `|mount %monkey` to mount it.
    3. Set `MONKEY_DESK` in `.env.local` if the path to your desk is different.
3. Create and upload `glob-http`, if applicable (see below)
3. Install the desk
    1. From the `ui` folder: `npm run install:desk`
    2. From the distribution ship's dojo: `:treaty|unpublish %monkey`
    2. From middleman or distribution ship's dojo: `|commit %monkey`
    3. (if using a comet as a middleman) `|public %monkey`
    4. (if using a comet as a middleman) from the actual distribution ship: `|install ~comet-name %monkey` or `|resume %monkey`
    5. (if using a comet as a middleman) from the actual distribution ship: `|pause %monkey`
4. Build UI and upload `glob-ames` 
5. Publish the desk from dojo: `:treaty|publish %monkey`

## Deploying with `glob-ames` glob
Initial Setup:
1. Put the line `glob-ames+[~dister-midlev-mindyr 0v0]` in `desk.docket-0` if it's not there, where `~dister-midlevi-mindyr` is the `@p` of the distribution ship.

Every Time:
4. Build the UI with `npm run build` in the `ui` directory which will bundle all the code and assets into the `dist/` folder.
5. Upload the `dist/` folder as a glob to your distribution ship. Example url: https://distribution.urbit-ship.com/docket/upload

## Deploying with `glob-http` glob
Initial Setup:
1. Spin up a globber ship (comet or fakezod) (or just reuse your dev ship for this).
2. Mount an `%globber` desk. In Dojo:
    1. `|merge %globber our %base` to create a new desk.
    2. `|mount %globber` to mount it.
    3. Set `GLOBBER_DESK` in `.env.local` if the path to your globber desk is different.

Every Time:
3. From the `ui` directory, run `npm run release` to build the ui, make the glob, and copy it to the `globs` folder. The command will also print out the glob hash/id.
4. Copy the string printed by the last step, and paste it into `desk.docket-0`.
5. Upload the glob in `/globs/` to any publicly available HTTP endpoint that can serve files. This allows the glob to be distributed over HTTP.
6. Once you've uploaded the glob, paste the url into `desk/desk.docket-0`. Both the full URL and the hash should be updated to match the glob we just created, on the line that looks like this:
    ```hoon
        glob-http+['https://bootstrap.urbit.org/glob-0v5.fdf99.nph65.qecq3.ncpjn.q13mb.glob' 0v5.fdf99.nph65.qecq3.ncpjn.q13mb]
    ```

[svelte]: https://svelte.dev/
[typescript]: https://www.typescriptlang.org/
[tailwind css]: https://tailwindcss.com/
[vite]: https://vitejs.dev/
