[![CI-macOS](https://github.com/annasbananas/shawty/actions/workflows/ci-macos.yml/badge.svg)](https://github.com/annasbananas/shawty/actions/workflows/ci-macos.yml)
[![CI-iOS](https://github.com/annasbananas/shawty/actions/workflows/ci-ios.yml/badge.svg)](https://github.com/annasbananas/shawty/actions/workflows/ci-ios.yml)
[![Tuist badge](https://img.shields.io/badge/Powered%20by-Tuist-blue)](https://tuist.io)

# Shawty
A sample music app to search for artists and browse albums and tracks for that artist.

## Getting started
To get started you have 2 options, light or **hardcore**:

### Light
Assuming that you have Xcode installed,
Open the `Shawty.xcworkspace` file, which will load the whole project in Xcode.
Choose the `iOS` target and start browsing 🔍.

> Normally `.xcworkspace` and `.xcodeproj` files will be git-ignored, but for the purposes of this exercise it was committed as an alternate solution to view the project.

### Hardcore
Run the following command in root of the cloned repository:

```shell
make
```

The `make` command will set up the dev environment, generate and build the workspace, and finally launch Xcode with the generated workspace.
Choose the `iOS` target and start browsing 🔍.

> See the [`unbootstrap`](Documentation/Commands.md#unisntalling) command that will reverse all installations done by `make`.

## Features
The app has the following features, and detailed breakdown of each can be found on the respective page:
- [Artist Search](Documentation/ArtistFeatureSpecs.md)
- [Album List](Documentation/AlbumListFeatureSpecs.md)
- [Album Detail](Documentation/AlbumDetailFeatureSpecs.md)

## App Architecture
See the following pages for more information on the app Architecture:
- [Architecture Overview](Documentation/ArchitectureOverview.md)
- [Navigation Overview](Documentation/NavigationOverview.md)
- [Project Structure](Documentation/ProjectStructure.md)

## Behind the name
The name was inspired by the song [Replay from Iyaz](https://g.co/kgs/M1eW5e):

>" **Shawty's** _like a melody in my head \
> That I can't keep out, got me singin' like \
> Na na na na everyday \
> It's like my iPod's stuck on replay \
> Replay-ay-ay-ay_  "

## Break down of work done
See the [closed PRs](https://github.com/annasbananas/shawty/pulls?q=is%3Apr+is%3Aclosed) for a detailed break-down of the work done

## Other details
This (personal and still very much under development) [App template](https://github.com/andrelouw/app-template) was used as a starting point for this project.

See the [Commands](Documentation/Commands.md) page for a full list of `make` commands.

See the [Tools](Documentation/Tools.md) page for all the tools used in this project.
