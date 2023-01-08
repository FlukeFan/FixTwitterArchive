Fix Twitter Archive
===================

After downloading my Twitter archive, I've observed various errors like:

* "Something went wrong, but don’t fret"
* "TypeError: Cannot read properties of undefined"

This appears to be due to null entries in the archive JSON for the field "fullText" in the like.js JSON.

This script adds an empty field so that it doesn't break.

Running
-------

Open a command/pwsh window, and run the script using:

```
pwsh ./fix.ps1 <path to root of unzipped archive>
```
