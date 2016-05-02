CHM Builder
===========
A simple cross-platform tool for generating files in MS Compiled HTMLHelp format (CHM). Written in Object Pascal, compiles with FPC/Lazarus. Fully self-contained (doesn't require installation of HTML Help Workshop).

Usage
-----
`chmbuilder inputDir startPage.html TOC.hhc Index.hhk outputFile.chm [LocaleID]`

* `inputDir` - input directory which contents will be included to CHM file
* `startPage.html` - default page file (relative to inputDir)
* `TOC.hhc` - table of contents file
* `Index.hhk` - index file
* `outputFile.chm` - output file
* `LocaleID` (optional) - CHM language hex code (LCID). Default is English - `$0409`. Russian, for example, is `$0419`. Full list can be found here: https://msdn.microsoft.com/en-us/goglobal/bb964664.aspx

Credits and license
-------------------
This project is based on CHMFileWriter by Andrew Haines. The code is distributed under GNU LGPL.
