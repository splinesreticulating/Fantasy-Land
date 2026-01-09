# Fantasy-Land MUD

This is a modern fork of the Fantasy-Land MUD codebase, updated to build and run on modern Linux systems (Ubuntu 20.04+). It is based on the Realm of Thorns (RoT) codebase, which derives from Rom2.4, Merc, and DikuMUD.

## Features (Modernization)

- **Build Fixes:** Updated code to compile with modern GCC versions.
- **Repository Cleanup:** Removed tracked build artifacts, binaries, and log files.
- **Startup Script:** Included a robust `startup.sh` script for managing the game server.
- **Git Friendly:** Properly configured `.gitignore` for development.

## Getting Started

### Prerequisites

You need a Linux environment with the standard build tools:

```bash
sudo apt update
sudo apt install build-essential zlib1g-dev libcrypt-dev git
```

### Building the Game

1. Navigate to the source directory:
   ```bash
   cd src
   ```

2. Compile the code:
   ```bash
   make
   ```

3. Install the binary (copies it to the `area/` directory):
   ```bash
   make copy
   ```

### Running the Game

Use the provided startup script from the root directory:

```bash
./startup.sh
```

By default, the game runs on port **4000**. You can specify a different port:

```bash
./startup.sh 9000
```

To connect to the game, use a telnet client or a MUD client (like Mudlet, Tintin++, or PuTTY):

```bash
telnet localhost 4000
```

### Administration

- The first character created will typically not be an Immortal automatically. You may need to edit the player file or use an existing admin account if one was provided in the database (check `player/` if available, though cleared in this repo for cleanliness).
- Logs are stored in the `log/` directory.

## License

This codebase is subject to the original DikuMUD, Merc, and ROM licenses. Please see the `doc/` directory (if available) or the headers in source files for license details. You must comply with all original license requirements when hosting or distributing this game.
