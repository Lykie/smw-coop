Building
--------
- Stick the clean rom in the rom directory, named something convenient (I used 
coop.smc)
- Rename the folder of graphics in `rom` you want to just "Graphics"
- Open the ROM in Lunar Magic
- Check the checkbox in the Options menu for "Used joined GFX files"
- Press the green mushroom button to insert AllGFX.bin
- Click the rainbow star, then the red star with the red arrow
- Select one of the .pal files from the rom directory
- Click the save button in the Palette Editor
- Run the following, in the project root: `<path to asar> co-op.asm rom/coop.smc`
- Bam.
Forker's note
-------------
This is not really a continuation of this, more of breaking it if anything.
I disabled some things that player 1 has that I didn't think was really useful.

-No longer able to punch the chain fence (looked buggy)
-Player 1 doesn't float after letting go of B button with cape (Player 2 doesn't have it)
-Flying is disabled (buggy)