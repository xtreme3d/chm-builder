program main;

uses Classes, SysUtils, chmfilewriter;

var
  proj: TChmProject;
  fs: TFileStream;

procedure FindAllFilesInDir(strings: TStrings; dirname: String; chmName: String);
var
  SR: TSearchRec;
  name: String;
  name2: String;
begin
  if FindFirst(
     IncludeTrailingBackslash(dirname) + '*', 
     faAnyFile, SR) = 0 then
  begin
    repeat
      name := IncludeTrailingBackslash(dirname) + SR.Name;
      if Length(chmName) <> 0 then
        name2 := chmName + '/' + SR.Name
      else
        name2 := SR.Name;
      writeln(name2);
      if (SR.Attr and faDirectory) = 0 then
      begin
        strings.Add(name2);
      end
      else if (SR.Name <> '.') and (SR.Name <> '..') then
        FindAllFilesInDir(strings, name, name2);
    until FindNext(Sr) <> 0;
    FindClose(SR);
  end;
end;

begin
  if ParamCount < 5 then 
  begin
    writeln('Usage:');
    writeln(' ' + ExtractFileName(ParamStr(0)) + 
      ' inputDir indexFile hhcFile hhkFile outputFile [LocaleID]');
    Exit;
  end;

  proj := TChmProject.Create;
  proj.Title := 'Help';
  proj.MakeSearchable := true;
  proj.AutoFollowLinks := true;
  proj.ProjectDirectory := ParamStr(1); //'html';
  proj.DefaultPage := ParamStr(2); //'xtreme3d.htm';
  proj.TableOfContentsFileName := ParamStr(3); //'html/TOC.hhc';
  proj.IndexFileName := ParamStr(4); //'html/Index.hhk';
  proj.OutputFileName := ParamStr(5); //'output.chm';

  if ParamCount = 6 then
    proj.LocaleID := StrToInt(ParamStr(6)); // default is English, $0419 = Russian

  FindAllFilesInDir(proj.Files, 'html', '');

  fs := TFileStream.Create(proj.OutputFileName, fmCreate);
  proj.WriteChm(fs);
  fs.Free;
end.

