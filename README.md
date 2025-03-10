# (WIP) Gleam + Lustre SSR Demo

This is a simple SSR demo with Gleam and Lustre!

## Projects

This repo is split into three Gleam projects:

**Backend**

The backend renders the lustre components to a string and sends them
over the wire. There is routing built in.

**Frontend**

The frontend hydrates the lustre component. Again, there is routing,
and if JS is enabled in the browser, the client side router takes over.

**Shared**

This project contains shared components (and the router). It is used
by both the backend and the frontend.

## Run the app

- Install gleam and bun
- `cd frontend`, `bun install`, and run `./build.sh`
- `cd backend` and run `gleam run`
- Server will start on `${PORT:-5000}`

# WIP features

## Communication between the Frontend and Backend

There are two choices of communication between the frontend and backend:

- bi-directional websocket
- http requests

With the former, a persistent connection may speed things up, but can
also bring reliability issues and use unnecessary computing power. The
latter is more useful if the app is going to make less requests to the
backend.

For the format, I'd prefer using erlang's types that convert to `binary()`,
but JSON is also possible.

## Hot reloading

TODO
