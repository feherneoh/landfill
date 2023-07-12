# Bash webradio player

Intended to be used with Icecast

### Setting up

- Create a stream folder to hold your music files
  Suggested location: `~/streams/<stream name>`
- Create a `.streaminfo` file in the stream folder
  Configure it with your Icecast server's parameters

### Usage

Start streaming music by feeding the stream folder's name to `pv-startstream`
If it can't find the specified folder relative to `$PWD` it'll try looking for it relative to `~/streams` next

To stop the stream after the current track, create a file called `.streamstop` in the stream folder

`pv-filter-*` scripts are used to apply filters to specific music files.
Scripts were planned to automatize this, but were never implemented.

`pv-oggstream-*` scripts handle converting the music files into OGG format for streaming

To add support for other file formats, add new scripts named `pv-oggstream-<file extension>` to your `$PATH`

### Example `.streaminfo` file
```
STREAMHOST=localhost
STREAMPORT=8000
STREAMPASS=password
STREAMMOUNT=/mount.ogg
```
