## How to use

1. Download the `convert.ps1` script.
2. Open PowerShell in the directory where `convert.ps1` is located.
3. Run the script by providing two arguments:
    - The path to your font file (e.g., `C:\path\to\your\font.ttf`).
    - The desired font name (optional; if not provided, the script will use the font file name without extension).
   
   Example of how to run the script:
   ```powershell
   .\convert.ps1 -filePath "C:\path\to\your\font.ttf" -fontName "MyCustomFont"
   ```
   If you don't provide a `fontName`, it will be automatically set to the font's filename without the extension:
   ```powershell
   .\convert.ps1 -filePath "C:\path\to\your\font.ttf"
   ```

4. The script will create a `.gfx` file in the `output` folder.
5. Move the newly created `.gfx` file from the `output` folder to your script's `stream` folder.
6. Register the font in the game.

#### Example of registering the custom font in game:
```lua
RegisterFontFile('Arial') -- File name without file extension
local fontId = RegisterFontId('Arial') -- Font name you entered in the convert script
local fontText = '<font face="Arial">This text will have the Arial font</font>'
```

## Common issues

### PowerShell closes automatically after running it
To fix that you need to change the execution policy.
1. Open PowerShell **as Administrator**.
2. Type `Set-ExecutionPolicy RemoteSigned`.
3. Type `Y` to confirm.

### "FreeType does not like"...
This is caused by having a whitespace in the font file path.  
The only way to fix this is by moving the font file to another folder, without a whitespace in its path.  
More info can be found in [issue #1](https://github.com/antond15/gfx-font-converter/issues/1).

## Credits
- [swfmill.exe](https://github.com/djcsdy/swfmill) ([direct download](https://www.swfmill.org/releases/swfmill-0.3.6-win32.zip))
- [gfxexport.exe](https://docs.unrealengine.com/udk/Three/DownloadsPage.html) ([direct download](https://docs.unrealengine.com/udk/Three/rsrc/Three/DownloadsPage/gfxexport.zip))