;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;此脚本主要模仿并实现“好压”安装程序的界面                                                           ;
;请使用 Unicode 版 Inno Setup 5.5.9（或更新） 编译器编译                                            ;
;经测试，此脚本可以在官方原版编译器、SkyGZ增强版编译器和Restools增强版编译器上完美编译通过并正常运行;
;令人遗憾的是原始脚本作者已不可考                                                                   ;
;代码主要思路来源于：http://blog.csdn.net/oceanlucy/article/details/50033773                        ;
;感谢博主 “沉森心” （oceanlucy）                                                                    ;
;此脚本也经过了几个网友的改进，但已无法具体考证，但我仍然很感谢他们                                 ;
;最终版本由 “赵宇航”/“糖鸭君”/“糖鸭”/“唐雅”/“wangwenx190” 修改得到                                  ;
;欢迎大家传播和完善此脚本                                                                           ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IF VER < EncodeVer(5,5,0)
  #error 请升级您的 Inno Setup 编译器到 V5.5.0 或更新的版本
#endif

#ifndef UNICODE
  #error 请使用 Unicode 版 Inno Setup 编译器
#endif

;指定是否为64位安装程序
#define x64Build

;指定是否只能在 Windows 7 SP1 及更新版本的操作系统上安装
#define Windows7SP1AndNewer

;指定是否要注册相关后缀名
#define RegisteAssociations

;指定是否为绿色版安装程序（仅释放文件，不写入注册表条目，也不生成卸载程序）
;#define PortableBuild

;指定是否只能安装新版本，而不能用旧版本覆盖新版本
#define OnlyInstallNewVersion 

#ifdef x64Build
  #define MyAppID "{078B5815-7CD4-4CFE-B0AD-1A1136BDC998}"
  #define MyAppName "SPlayer"
  #define MyAppExeName "SPlayer64.exe"
  #define MyAppMutex "SPlayer64Mutex"
#else
  #define MyAppID "{6F44C754-77E7-4687-80D4-B48E574DF023}"
  #define MyAppName "SPlayer"
  #define MyAppExeName "SPlayer.exe"
  #define MyAppMutex "SPlayerMutex"
#endif

;若想开启禁止安装旧版本的功能，此处版本号请注意一定要是
;点分十进制的正整数，除数字和英文半角句点以外不允许出现任何其他字符，
;否则程序无法判断版本的高低。
#define MyAppVersion "1.0.0"
#define MyAppPublisher "赵宇航"
#define MyAppPublisherURL "https://github.com/wangwenx190"
#define MyAppSupportURL "https://github.com/wangwenx190/SPlayer-Installer/wiki"
#define MyAppUpdatesURL "https://github.com/wangwenx190/SPlayer-Installer/releases"
#define MyAppSourceCodeURL "https://github.com/wangwenx190/SPlayer-Installer"
#define MyAppComments "本软件以MIT协议开放所有源代码。所有代码均已托管到GitHub：https://github.com/wangwenx190/SPlayer-Installer。"
#define MyAppContact MyAppPublisher
#define MyAppSupportPhone "10010102020"
#define MyAppReadmeURL "https://github.com/wangwenx190/SPlayer-Installer/blob/master/README.md"
#define MyAppLicenseURL "https://github.com/wangwenx190/SPlayer-Installer/blob/master/LICENSE"
#define MyAppCopyright "本软件以MIT协议开放所有源代码。所有代码均已托管到GitHub：https://github.com/wangwenx190/SPlayer-Installer。"

[Setup]
AppId={{#MyAppID}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppPublisherURL}
AppSupportURL={#MyAppSupportURL}
AppUpdatesURL={#MyAppUpdatesURL}
AppComments={#MyAppComments}
AppContact={#MyAppContact}
AppSupportPhone={#MyAppSupportPhone}
AppReadmeFile={#MyAppReadmeURL}
AppCopyright={#MyAppCopyright}
DefaultGroupName={#MyAppPublisher}\{#MyAppName}
VersionInfoDescription={#MyAppName} Installer
VersionInfoProductName={#MyAppName}
VersionInfoCompany={#MyAppPublisher}
VersionInfoCopyright={#MyAppCopyright}
VersionInfoProductVersion={#MyAppVersion}
VersionInfoProductTextVersion={#MyAppVersion}
VersionInfoTextVersion={#MyAppVersion}
VersionInfoVersion={#MyAppVersion}
OutputDir=.\Output\
SetupIconFile=.\icon_installer_splayer.ico
Compression=lzma2/ultra64
InternalCompressLevel=ultra64
SolidCompression=yes
DisableProgramGroupPage=yes
DisableDirPage=yes
DisableReadyMemo=yes
DisableReadyPage=yes
TimeStampsInUTC=yes
SetupMutex={{#MyAppID}Installer,Global\{{#MyAppID}Installer
AppMutex={#MyAppMutex}
ShowLanguageDialog=no
AllowCancelDuringInstall=no
#ifdef x64Build
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
DefaultDirName={pf64}\{#MyAppPublisher}\{#MyAppName}
#else
ArchitecturesAllowed=x86 x64
DefaultDirName={pf32}\{#MyAppPublisher}\{#MyAppName}
#endif
#ifdef Windows7SP1AndNewer
MinVersion=0,6.1.7601
#else
MinVersion=0,5.1.2600
#endif
#ifdef RegisteAssociations
ChangesAssociations=yes
#else
ChangesAssociations=no
#endif
#ifdef PortableBuild
Uninstallable=no
PrivilegesRequired=lowest
OutputBaseFilename={#MyAppName}_{#MyAppVersion}_Portable
#else
Uninstallable=yes
PrivilegesRequired=admin
OutputBaseFilename={#MyAppName}_{#MyAppVersion}_Setup
UninstallDisplayName={#MyAppName}
UninstallDisplayIcon={uninstallexe},0
UninstallFilesDir={app}\Uninstaller
#endif

[Languages]
Name: "en_US"; MessagesFile: ".\lang\en-US.isl"

[Files]
Source: ".\app\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: ".\tmp\SamsungSharpSans-Bold.ttf"; DestDir: "{tmp}\SamsungSharpSans-Bold.ttf"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\license.txt"; DestDir: "{tmp}\license.txt"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\botva2.dll"; DestDir: "{tmp}\botva2.dll"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\InnoCallback.dll"; DestDir: "{tmp}\InnoCallback.dll"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\background_form_license.png"; DestDir: "{tmp}\background_form_license.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\background_messagebox.png"; DestDir: "{tmp}\background_messagebox.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\background_progressbar.png"; DestDir: "{tmp}\background_progressbar.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\background_wizardform_finish.png"; DestDir: "{tmp}\background_wizardform_finish.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\background_wizardform_installing.png"; DestDir: "{tmp}\background_wizardform_installing.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\background_wizardform_welcome.png"; DestDir: "{tmp}\background_wizardform_welcome.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\background_wizardform_welcome_large.png"; DestDir: "{tmp}\background_wizardform_welcome_large.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_agree.png"; DestDir: "{tmp}\button_agree.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_browse.png"; DestDir: "{tmp}\button_browse.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_close.png"; DestDir: "{tmp}\button_close.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_customize_setup.png"; DestDir: "{tmp}\button_customize_setup.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_disagree.png"; DestDir: "{tmp}\button_disagree.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_finish.png"; DestDir: "{tmp}\button_finish.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_get_source_code.png"; DestDir: "{tmp}\button_get_source_code.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_install.png"; DestDir: "{tmp}\button_install.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_minimize.png"; DestDir: "{tmp}\button_minimize.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_no.png"; DestDir: "{tmp}\button_no.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_uncustomize_setup.png"; DestDir: "{tmp}\button_uncustomize_setup.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_yes.png"; DestDir: "{tmp}\button_yes.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
#ifdef RegisteAssociations
Source: ".\tmp\checkbox_setdefault.png"; DestDir: "{tmp}\checkbox_setdefault.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
#endif
Source: ".\tmp\foreground_progressbar.png"; DestDir: "{tmp}\foreground_progressbar.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\label_already_installed.png"; DestDir: "{tmp}\label_already_installed.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system

#ifndef PortableBuild
[Dirs]
Name: "{app}\Uninstaller"; Attribs: hidden system
#endif

#ifndef PortableBuild
[INI] 
Filename: "{userappdata}\{#MyAppPublisher}\{#MyAppName}\Config.ini"; Section: "Setup"; Key: "AppID"; String: "{{#MyAppID}"; Flags: createkeyifdoesntexist uninsdeleteentry uninsdeletesectionifempty
Filename: "{userappdata}\{#MyAppPublisher}\{#MyAppName}\Config.ini"; Section: "Setup"; Key: "Version"; String: "{#MyAppVersion}"; Flags: createkeyifdoesntexist uninsdeleteentry uninsdeletesectionifempty
Filename: "{userappdata}\{#MyAppPublisher}\{#MyAppName}\Config.ini"; Section: "Setup"; Key: "InstallPath"; String: "{app}"; Flags: createkeyifdoesntexist uninsdeleteentry uninsdeletesectionifempty
Filename: "{userappdata}\{#MyAppPublisher}\{#MyAppName}\Config.ini"; Section: "Setup"; Key: "Uninstaller"; String: "{uninstallexe}"; Flags: createkeyifdoesntexist uninsdeleteentry uninsdeletesectionifempty
#endif

;若有写入注册表条目的需要，请取消此区段的注释并自行添加相关脚本
;[Registry]
;Root: HKCU; Subkey: "Software\My Company"; Flags: uninsdeletekeyifempty
;Root: HKCU; Subkey: "Software\My Company\My Program"; Flags: uninsdeletekey
;Root: HKLM; Subkey: "Software\My Company"; Flags: uninsdeletekeyifempty
;Root: HKLM; Subkey: "Software\My Company\My Program"; Flags: uninsdeletekey
;Root: HKLM; Subkey: "Software\My Company\My Program\Settings"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"

;若有创建快捷方式的需要，请取消此区段的注释并自行添加相关脚本
;[Icons]
;Name: "{group}\My Program"; Filename: "{app}\MYPROG.EXE"; Parameters: "/play filename.mid"; WorkingDir: "{app}"; Comment: "This is my program"; IconFilename: "{app}\myicon.ico"
;Name: "{group}\Documents"; Filename: "{app}\Doc"; Flags: foldershortcut

#ifdef RegisteAssociations
[UninstallRun]
Filename: "{app}\{#MyAppExeName}"; Parameters: "--uninstall"; WorkingDir: "{app}"; Flags: waituntilterminated skipifdoesntexist
#endif

#ifndef PortableBuild
[UninstallDelete]
Type: filesandordirs; Name: "{app}"
#endif

[Code]
CONST
  PRODUCT_REGISTRY_KEY_32 = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{#MyAppID}_is1';
  PRODUCT_REGISTRY_KEY_64 = 'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{#MyAppID}_is1';
  WM_SYSCOMMAND = $0112;
  FR_PRIVATE = $10;
  FR_NOT_ENUM = $20;
  ID_BUTTON_ON_CLICK_EVENT = 1;
  WIZARDFORM_WIDTH_NORMAL = 1024;
  WIZARDFORM_HEIGHT_NORMAL = 488;
  WIZARDFORM_HEIGHT_MORE = 572;

VAR
  label_wizardform_main, label_messagebox_main, label_form_license_main, label_install_progress : TLabel;
  image_wizardform_label_already_installed, image_wizardform_background, image_messagebox_background, image_form_license_background, image_progressbar_background, image_progressbar_foreground, PBOldProc : LONGINT;
  button_wizardform_get_source_code, button_form_license_agree, button_form_license_disagree, button_form_license_close, button_finish, button_minimize, button_close, button_browse, button_install, button_customize_setup, button_uncustomize_setup, checkbox_setdefault, button_messagebox_close, button_messagebox_yes, button_messagebox_no : HWND;
  is_wizardform_show_normal, is_installer_initialized, is_platform_windows_7, is_wizardform_released, can_exit_setup, need_to_change_associations, can_install : BOOLEAN;
  edit_target_path : TEdit;
  richedit_license : TRichEditViewer;
  version_installed_before : STRING;
  messagebox_close, form_license : TSetupForm;

TYPE
  TBtnEventProc = PROCEDURE(h : HWND);
  TPBProc = FUNCTION(h : hWnd; Msg, wParam, lParam : LONGINT) : LONGINT;

FUNCTION  ImgLoad(h : HWND; FileName : PAnsiChar; Left, Top, Width, Height : INTEGER; Stretch, IsBkg : BOOLEAN) : LONGINT; EXTERNAL 'ImgLoad@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE ImgSetVisibility(img : LONGINT; Visible : BOOLEAN); EXTERNAL 'ImgSetVisibility@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE ImgApplyChanges(h : HWND); EXTERNAL 'ImgApplyChanges@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE ImgSetPosition(img : LONGINT; NewLeft, NewTop, NewWidth, NewHeight : INTEGER); EXTERNAL 'ImgSetPosition@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE ImgRelease(img : LONGINT); EXTERNAL 'ImgRelease@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE CreateFormFromImage(h : HWND; FileName : PAnsiChar); EXTERNAL 'CreateFormFromImage@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE gdipShutdown();  EXTERNAL 'gdipShutdown@files:botva2.dll STDCALL DELAYLOAD';
FUNCTION  WrapBtnCallback(Callback : TBtnEventProc; ParamCount : INTEGER) : LONGWORD; EXTERNAL 'wrapcallback@files:innocallback.dll STDCALL DELAYLOAD';
FUNCTION  BtnCreate(hParent : HWND; Left, Top, Width, Height : INTEGER; FileName : PAnsiChar; ShadowWidth : INTEGER; IsCheckBtn : BOOLEAN) : HWND;  EXTERNAL 'BtnCreate@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE BtnSetVisibility(h : HWND; Value : BOOLEAN); EXTERNAL 'BtnSetVisibility@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE BtnSetEvent(h : HWND; EventID : INTEGER; Event : LONGWORD); EXTERNAL 'BtnSetEvent@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE BtnSetEnabled(h : HWND; Value : BOOLEAN); EXTERNAL 'BtnSetEnabled@files:botva2.dll STDCALL DELAYLOAD';
FUNCTION  BtnGetChecked(h : HWND) : BOOLEAN; EXTERNAL 'BtnGetChecked@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE BtnSetChecked(h : HWND; Value : BOOLEAN); EXTERNAL 'BtnSetChecked@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE BtnSetPosition(h : HWND; NewLeft, NewTop, NewWidth, NewHeight : INTEGER);  EXTERNAL 'BtnSetPosition@files:botva2.dll STDCALL DELAYLOAD';
FUNCTION  SetWindowLong(h : HWnd; Index : INTEGER; NewLong : LONGINT) : LONGINT; EXTERNAL 'SetWindowLongA@user32.dll STDCALL';
FUNCTION  PBCallBack(P : TPBProc; ParamCount : INTEGER) : LONGWORD; EXTERNAL 'wrapcallback@files:innocallback.dll STDCALL DELAYLOAD';
FUNCTION  CallWindowProc(lpPrevWndFunc : LONGINT; h : HWND; Msg : UINT; wParam, lParam : LONGINT) : LONGINT; EXTERNAL 'CallWindowProcA@user32.dll STDCALL';
PROCEDURE ImgSetVisiblePart(img : LONGINT; NewLeft, NewTop, NewWidth, NewHeight : INTEGER); EXTERNAL 'ImgSetVisiblePart@files:botva2.dll STDCALL DELAYLOAD';
FUNCTION  ReleaseCapture() : LONGINT; EXTERNAL 'ReleaseCapture@user32.dll STDCALL';
FUNCTION  AddFontResourceEx(lpszFilename : STRING; fl : LONGINT; pdv : LONGINT) : LONGINT; EXTERNAL 'AddFontResourceExW@gdi32.dll STDCALL';
FUNCTION  RemoveFontResourceEx(lpszFilename : STRING; fl : LONGINT; pdv : LONGINT) : BOOLEAN; EXTERNAL 'RemoveFontResourceExW@gdi32.dll STDCALL';
FUNCTION  CreateRoundRectRgn(p1, p2, p3, p4, p5, p6 : INTEGER) : THandle; EXTERNAL 'CreateRoundRectRgn@gdi32.dll STDCALL';
FUNCTION  SetWindowRgn(h : HWND; hRgn : THandle; bRedraw : BOOLEAN) : INTEGER; EXTERNAL 'SetWindowRgn@user32.dll STDCALL';

//调用这个函数可以使矩形窗口转变为圆角矩形窗口
PROCEDURE shape_form_round(aForm : TForm; edgeSize : INTEGER);
VAR
  FormRegion : LONGWORD;
BEGIN
  FormRegion := CreateRoundRectRgn(0, 0, aForm.Width, aForm.Height, edgeSize, edgeSize);
  SetWindowRgn(aForm.Handle, FormRegion, TRUE);
END;

FUNCTION is_installed_before() : BOOLEAN;
BEGIN
#ifndef x64Build
  IF is_platform_windows_7 THEN
  BEGIN
    IF IsWin64 THEN
    BEGIN
      IF RegKeyExists(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_64) THEN
      BEGIN
        RegQueryStringValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_64, 'DisplayVersion', version_installed_before);
        Result := TRUE;
      END ELSE
      BEGIN
        version_installed_before := '0.0.0';
        Result := FALSE;
      END;
    END ELSE
    BEGIN
      IF RegKeyExists(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32) THEN
      BEGIN
        RegQueryStringValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32, 'DisplayVersion', version_installed_before);
        Result := TRUE;
      END ELSE
      BEGIN
        version_installed_before := '0.0.0';
        Result := FALSE;
      END;
    END;
  END ELSE
  BEGIN
    IF RegKeyExists(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32) THEN
      BEGIN
        RegQueryStringValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32, 'DisplayVersion', version_installed_before);
        Result := TRUE;
      END ELSE
      BEGIN
        version_installed_before := '0.0.0';
        Result := FALSE;
      END;
  END;
#else
  IF RegKeyExists(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32) THEN
  BEGIN
    RegQueryStringValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32, 'DisplayVersion', version_installed_before);
    Result := TRUE;
  END ELSE
  BEGIN
    version_installed_before := '0.0.0';
    Result := FALSE;
  END;
#endif
END;

FUNCTION is_installing_older_version() : BOOLEAN;
VAR
  installedVer : ARRAY[1..10] OF LONGINT;
  installingVer : ARRAY[1..10] OF LONGINT;
  oldVer, nowVer, version_installing_now : STRING;
  i, oldTotal, nowTotal, total : INTEGER;
BEGIN
  oldTotal := 1;
  WHILE (Pos('.', version_installed_before) > 0) DO
  BEGIN
    oldVer := version_installed_before;
    Delete(oldVer, Pos('.', oldVer), ((Length(oldVer) - Pos('.', oldVer)) + 1));
    installedVer[oldTotal] := StrToIntDef(oldVer, 0);
    oldTotal := oldTotal + 1;
    version_installed_before := Copy(version_installed_before, (Pos('.', version_installed_before) + 1), (Length(version_installed_before) - Pos('.', version_installed_before)));
  END;
  IF (version_installed_before <> '') THEN
  BEGIN
    installedVer[oldTotal] := StrToIntDef(version_installed_before, 0);
  END ELSE
  BEGIN
    oldTotal := oldTotal - 1;
  END;
  version_installing_now := '{#MyAppVersion}';
  nowTotal := 1;
  WHILE (Pos('.', version_installing_now) > 0) DO
  BEGIN
    nowVer := version_installing_now;
    Delete(nowVer, Pos('.', nowVer), ((Length(nowVer) - Pos('.', nowVer)) + 1));
    installingVer[nowTotal] := StrToIntDef(nowVer, 0);
    nowTotal := nowTotal + 1;
    version_installing_now := Copy(version_installing_now, (Pos('.', version_installing_now) + 1), (Length(version_installing_now) - Pos('.', version_installing_now)));
  END;
  IF (version_installing_now <> '') THEN
  BEGIN
    installingVer[nowTotal] := StrToIntDef(version_installing_now, 0);
  END ELSE
  BEGIN
    nowTotal := nowTotal - 1;
  END;
  IF (oldTotal < nowTotal) THEN
  BEGIN
    FOR i := (oldTotal + 1) TO nowTotal DO
    BEGIN
      installedVer[i] := 0;
      total := nowTotal;
    END;
  END ELSE IF (oldTotal > nowTotal) THEN
  BEGIN
    FOR i := (nowTotal + 1) TO oldTotal DO
    BEGIN
      installingVer[i] := 0;
      total := oldTotal;
    END;
  END ELSE
  BEGIN
    total := nowTotal;
  END;
  FOR i := 1 TO total DO
  BEGIN
    IF (installedVer[i] > installingVer[i]) THEN
    BEGIN
      Result := TRUE;
      Exit;
    END ELSE IF (installedVer[i] < installingVer[i]) THEN
    BEGIN
      Result := FALSE;
      Exit;
    END ELSE
    BEGIN
      Continue;
    END;
  END;
  Result := FALSE;
END;

PROCEDURE button_close_on_click(hBtn : HWND);
BEGIN
  WizardForm.CancelButton.OnClick(WizardForm);
END;

PROCEDURE button_minimize_on_click(hBtn : HWND);
BEGIN
  SendMessage(WizardForm.Handle, WM_SYSCOMMAND, 61472, 0);
END;

PROCEDURE button_customize_setup_on_click(hBtn : HWND);
BEGIN
  IF is_wizardform_show_normal THEN
  BEGIN
    WizardForm.Height := WIZARDFORM_HEIGHT_MORE;
    image_wizardform_background := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\background_wizardform_welcome_large.png'), 0, 0, WIZARDFORM_WIDTH_NORMAL, WIZARDFORM_HEIGHT_MORE, FALSE, TRUE);
    edit_target_path.Show();
    BtnSetVisibility(button_browse, TRUE);
#ifdef RegisteAssociations
    BtnSetVisibility(checkbox_setdefault, TRUE);
#endif
    BtnSetVisibility(button_customize_setup, FALSE);
    BtnSetVisibility(button_uncustomize_setup, TRUE);
#ifndef PortableBuild
    IF is_installed_before() THEN
    BEGIN
      edit_target_path.Enabled := FALSE;
      BtnSetEnabled(button_browse, FALSE);
      ImgSetVisibility(image_wizardform_label_already_installed, TRUE);
    END;
#endif
    is_wizardform_show_normal := FALSE;
  END ELSE
  BEGIN
    edit_target_path.Hide();
    ImgSetVisibility(image_wizardform_label_already_installed, FALSE);
    BtnSetVisibility(button_browse, FALSE);
#ifdef RegisteAssociations
    BtnSetVisibility(checkbox_setdefault, FALSE);
#endif
    WizardForm.Height := WIZARDFORM_HEIGHT_NORMAL;
    image_wizardform_background := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\background_wizardform_welcome.png'), 0, 0, WIZARDFORM_WIDTH_NORMAL, WIZARDFORM_HEIGHT_NORMAL, FALSE, TRUE);
    BtnSetVisibility(button_customize_setup, TRUE);
    BtnSetVisibility(button_uncustomize_setup, FALSE);
    is_wizardform_show_normal := TRUE;
  END;
  ImgApplyChanges(WizardForm.Handle);
END;

PROCEDURE button_browse_on_click(hBtn : HWND);
BEGIN
  WizardForm.DirBrowseButton.OnClick(WizardForm);
  edit_target_path.Text := WizardForm.DirEdit.Text;
END;

PROCEDURE edit_target_path_on_change(Sender : TObject);
BEGIN
  WizardForm.DirEdit.Text := edit_target_path.Text;
END;

PROCEDURE checkbox_setdefault_on_click(hBtn : HWND);
BEGIN
  IF BtnGetChecked(checkbox_setdefault) THEN
  BEGIN
    need_to_change_associations := TRUE;  
  END ELSE
  BEGIN
    need_to_change_associations := FALSE;
  END;
END;

FUNCTION is_setdefault_checkbox_checked() : BOOLEAN;
BEGIN
  Result := need_to_change_associations;
END;

PROCEDURE check_if_need_change_associations();
BEGIN
  IF is_setdefault_checkbox_checked() THEN
  BEGIN
    //TODO
    MsgBox('此处执行注册文件后缀名的操作。', mbInformation, MB_OK);
  END;
END;

PROCEDURE button_install_on_click(hBtn : HWND);
BEGIN
  form_license.Center();
  form_license.ShowModal();
  IF can_install THEN
  BEGIN
    WizardForm.NextButton.OnClick(WizardForm);
  END;
END;

PROCEDURE button_finish_on_click(hBtn : HWND);
BEGIN
  WizardForm.NextButton.OnClick(WizardForm);
END;

FUNCTION PBProc(h : hWnd; Msg, wParam, lParam : LONGINT) : LONGINT;
VAR
  pr, i1, i2 : EXTENDED;
  pr2, w : INTEGER;
  p : STRING;
BEGIN
  Result := CallWindowProc(PBOldProc, h, Msg, wParam, lParam);
  IF ((Msg = $402) AND (WizardForm.ProgressGauge.Position > WizardForm.ProgressGauge.Min)) THEN
  BEGIN
    i1 := WizardForm.ProgressGauge.Position - WizardForm.ProgressGauge.Min;
    i2 := WizardForm.ProgressGauge.Max - WizardForm.ProgressGauge.Min;
    pr := (i1 * 100) / i2;
    pr2 := Round(pr);
    p := Format('%d', [pr2]) + '%';
    IF (pr2 < 10) THEN
    BEGIN
      p := '  ' + Trim(p);
    END
    ELSE IF ((pr2 >= 10) AND (pr2 < 100)) THEN
    BEGIN
      p := ' ' + Trim(p);
    END ELSE
    BEGIN
      p := Trim(p);
    END;
    label_install_progress.Caption := p;
    w := Round((WIZARDFORM_WIDTH_NORMAL * pr) / 100);
    ImgSetPosition(image_progressbar_foreground, 0, 0, w, WIZARDFORM_HEIGHT_NORMAL);
    ImgSetVisiblePart(image_progressbar_foreground, 0, 0, w, WIZARDFORM_HEIGHT_NORMAL);
    ImgApplyChanges(WizardForm.Handle);
  END;
END;

PROCEDURE button_get_source_code_on_click(hBtn : HWND);
VAR
  ErrorCode : INTEGER;
BEGIN
  ShellExec('', '{#MyAppSourceCodeURL}', '', '', SW_SHOW, ewNoWait, ErrorCode);
END;

PROCEDURE button_messagebox_yes_on_click(hBtn : HWND);
BEGIN
  can_exit_setup := TRUE;
  messagebox_close.Close();
END;

PROCEDURE button_messagebox_no_on_click(hBtn : HWND);
BEGIN
  can_exit_setup := FALSE;
  messagebox_close.Close();
END;

PROCEDURE button_form_license_close_on_click(hBtn : HWND);
BEGIN
  can_install := FALSE;
  form_license.Close();
END;

PROCEDURE button_form_license_agree_on_click(hBtn : HWND);
BEGIN
  can_install := TRUE;
  form_license.Close();
END;

PROCEDURE wizardform_on_mouse_down(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : INTEGER);
BEGIN
  ReleaseCapture();
  SendMessage(WizardForm.Handle, WM_SYSCOMMAND, $F012, 0);
END;

PROCEDURE messagebox_on_mouse_down(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : INTEGER);
BEGIN
  ReleaseCapture();
  SendMessage(messagebox_close.Handle, WM_SYSCOMMAND, $F012, 0);
END;

PROCEDURE form_license_on_mouse_down(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : INTEGER);
BEGIN
  ReleaseCapture();
  SendMessage(form_license.Handle, WM_SYSCOMMAND, $F012, 0);
END;

PROCEDURE determine_wether_is_windows_7_or_not();
VAR
  sysVersion : TWindowsVersion;
BEGIN
  GetWindowsVersionEx(sysVersion);
  IF sysVersion.NTPlatform AND (sysVersion.Major = 6) AND (sysVersion.Minor = 1) THEN
  BEGIN
    is_platform_windows_7 := TRUE;
  END ELSE
  BEGIN
    is_platform_windows_7 := FALSE;
  END;
END;

PROCEDURE messagebox_close_create();
BEGIN
  messagebox_close := CreateCustomForm();
  WITH messagebox_close DO
  BEGIN
    BorderStyle := bsNone;
    Width := 522;
    Height := 254;
    Color := clWhite;
    Caption := '';
  END;
  label_messagebox_main := TLabel.Create(messagebox_close);
  WITH label_messagebox_main DO
  BEGIN
    Parent := messagebox_close;
    AutoSize := FALSE;
    Left := 0;
    Top := 0;
    Width := messagebox_close.Width;
    Height := messagebox_close.Height;
    Caption := '';
    Transparent := TRUE;
    OnMouseDown := @messagebox_on_mouse_down;
  END;
  image_messagebox_background := ImgLoad(messagebox_close.Handle, ExpandConstant('{tmp}\background_messagebox.png'), 0, 0, 522, 254, FALSE, TRUE);
  button_messagebox_close := BtnCreate(messagebox_close.Handle, 476, 1, 45, 29, ExpandConstant('{tmp}\button_close.png'), 0, FALSE);
  BtnSetEvent(button_messagebox_close, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_messagebox_no_on_click, 1));
  button_messagebox_yes := BtnCreate(messagebox_close.Handle, 143, 193, 86, 33, ExpandConstant('{tmp}\button_yes.png'), 0, FALSE);
  BtnSetEvent(button_messagebox_yes, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_messagebox_yes_on_click, 1));
  button_messagebox_no := BtnCreate(messagebox_close.Handle, 293, 193, 86, 33, ExpandConstant('{tmp}\button_no.png'), 0, FALSE);
  BtnSetEvent(button_messagebox_no, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_messagebox_no_on_click, 1));
  ImgApplyChanges(messagebox_close.Handle);
END;

PROCEDURE form_license_create();
BEGIN
  form_license := CreateCustomForm();
  WITH form_license DO
  BEGIN
    BorderStyle := bsNone;
    Width := 510;
    Height := 447;
    Color := clWhite;
    Caption := '';
  END;
  richedit_license := TRichEditViewer.Create(form_license);
  WITH richedit_license DO
  BEGIN
    Parent := form_license;
    BorderStyle := bsNone;
    Left := 16;
    Top := 32;
    Width := 478;
    Height := 370;
    //SetBounds(16, 32, 478, 370);
    Font.Name := 'Samsung Sharp Sans Bold';
    Font.Size := 10;
    Font.Color := clBlack;
    Lines.LoadFromFile(ExpandConstant('{tmp}\license.txt'));
    ScrollBars := ssVertical;
    TabStop := FALSE;
    ReadOnly := TRUE;
  END;
  label_form_license_main := TLabel.Create(form_license);
  WITH label_form_license_main DO
  BEGIN
    Parent := form_license;
    AutoSize := FALSE;
    Left := 0;
    Top := 0;
    Width := form_license.Width;
    Height := form_license.Height;
    Caption := '';
    Transparent := TRUE;
    OnMouseDown := @form_license_on_mouse_down;
  END;
  image_form_license_background := ImgLoad(form_license.Handle, ExpandConstant('{tmp}\background_form_license.png'), 0, 0, 510, 447, FALSE, TRUE);
  button_form_license_close := BtnCreate(form_license.Handle, 464, 1, 45, 29, ExpandConstant('{tmp}\button_close.png'), 0, FALSE);
  BtnSetEvent(button_form_license_close, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_form_license_close_on_click, 1));
  button_form_license_agree := BtnCreate(form_license.Handle, 114, 412, 106, 24, ExpandConstant('{tmp}\button_agree.png'), 0, FALSE);
  BtnSetEvent(button_form_license_agree, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_form_license_agree_on_click, 1));
  button_form_license_disagree := BtnCreate(form_license.Handle, 285, 412, 106, 24, ExpandConstant('{tmp}\button_disagree.png'), 0, FALSE);
  BtnSetEvent(button_form_license_disagree, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_form_license_close_on_click, 1));
  ImgApplyChanges(form_license.Handle);
END;

PROCEDURE release_installer();
BEGIN
  RemoveFontResourceEx(ExpandConstant('{tmp}\SamsungSharpSans-Bold.ttf'), FR_PRIVATE, 0);
  gdipShutdown();
  form_license.Release();
  messagebox_close.Release();
  WizardForm.Release();
END;

PROCEDURE release_installer_before_init();
BEGIN
  form_license.Release();
  messagebox_close.Release();
  WizardForm.Release();
END;

PROCEDURE CancelButtonClick(CurPageID : INTEGER; VAR Cancel, Confirm: BOOLEAN);
BEGIN
  Confirm := FALSE;
  messagebox_close.Center();
  messagebox_close.ShowModal();
  IF can_exit_setup THEN
  BEGIN
    release_installer();
    Cancel := TRUE;
  END ELSE
  BEGIN
    Cancel := FALSE;
  END;
END;

FUNCTION InitializeSetup() : BOOLEAN;
BEGIN
#ifndef PortableBuild
#ifdef OnlyInstallNewVersion
  IF is_installed_before() THEN
  BEGIN
    IF is_installing_older_version() THEN
    BEGIN
      MsgBox('You have already installed a newer version of {#MyAppName}，thus you are not allowed to continue，please click <OK> to exit setup.', mbInformation, MB_OK);
      Result := FALSE;
    END ELSE
    BEGIN
      Result := TRUE;
    END;
  END ELSE
  BEGIN
    Result := TRUE;
  END;
#else
  Result := TRUE;
#endif
#else
  Result := TRUE;
#endif
END;

PROCEDURE InitializeWizard();
BEGIN
  ExtractTemporaryFile('SamsungSharpSans-Bold.ttf');
  AddFontResourceEx(ExpandConstant('{tmp}\SamsungSharpSans-Bold.ttf'), FR_PRIVATE, 0);
  ExtractTemporaryFile('license.txt');
  ExtractTemporaryFile('background_form_license.png');
  ExtractTemporaryFile('background_messagebox.png');
  ExtractTemporaryFile('background_progressbar.png');
  ExtractTemporaryFile('background_wizardform_finish.png');
  ExtractTemporaryFile('background_wizardform_installing.png');
  ExtractTemporaryFile('background_wizardform_welcome.png');
  ExtractTemporaryFile('background_wizardform_welcome_large.png');
  ExtractTemporaryFile('button_agree.png');
  ExtractTemporaryFile('button_browse.png');
  ExtractTemporaryFile('button_close.png');
  ExtractTemporaryFile('button_customize_setup.png');
  ExtractTemporaryFile('button_disagree.png');
  ExtractTemporaryFile('button_finish.png');
  ExtractTemporaryFile('button_get_source_code.png');
  ExtractTemporaryFile('button_install.png');
  ExtractTemporaryFile('button_minimize.png');
  ExtractTemporaryFile('button_no.png');
  ExtractTemporaryFile('button_uncustomize_setup.png');
  ExtractTemporaryFile('button_yes.png');
#ifdef RegisteAssociations
  ExtractTemporaryFile('checkbox_setdefault.png');
#endif
  ExtractTemporaryFile('foreground_progressbar.png');
  ExtractTemporaryFile('label_already_installed.png');
  is_installer_initialized := TRUE;
  is_wizardform_show_normal := TRUE;
  is_wizardform_released := FALSE;
  need_to_change_associations := TRUE;
  can_install := FALSE;
  can_exit_setup := FALSE;
  determine_wether_is_windows_7_or_not();
  WizardForm.InnerNotebook.Hide();
  WizardForm.OuterNotebook.Hide();
  WizardForm.Bevel.Hide();
  WITH WizardForm DO
  BEGIN
    BorderStyle := bsNone;
    Position := poDesktopCenter;
    Width := WIZARDFORM_WIDTH_NORMAL;
    Height := WIZARDFORM_HEIGHT_MORE;
    Color := clWhite;
    NextButton.Height := 0;
    CancelButton.Height := 0;
    BackButton.Visible := FALSE;
  END;
  label_wizardform_main := TLabel.Create(WizardForm);
  WITH label_wizardform_main DO
  BEGIN
    Parent := WizardForm;
    AutoSize := FALSE;
    Left := 0;
    Top := 0;
    Width := WizardForm.Width;
    Height := WizardForm.Height;
    Caption := '';
    Transparent := TRUE;
    OnMouseDown := @wizardform_on_mouse_down;
  END;
  edit_target_path:= TEdit.Create(WizardForm);
  WITH edit_target_path DO
  BEGIN
    Parent := WizardForm;
    BorderStyle := bsNone;
    Left := 210;
    Top := 496;
    Width := 700;
    Height := 15;
    //SetBounds(210, 496, 700, 15);
    Font.Name := 'Samsung Sharp Sans Bold';
    Font.Size := 10;
    Font.Color := clBlack;
    Text := WizardForm.DirEdit.Text;
    OnChange := @edit_target_path_on_change;
    Color := clWhite;
    TabStop := FALSE;
  END;
  edit_target_path.Hide();
  button_close := BtnCreate(WizardForm.Handle, 978, 1, 45, 29, ExpandConstant('{tmp}\button_close.png'), 0, FALSE);
  BtnSetEvent(button_close, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_close_on_click, 1));
  button_minimize := BtnCreate(WizardForm.Handle, 933, 1, 45, 29, ExpandConstant('{tmp}\button_minimize.png'), 0, FALSE);
  BtnSetEvent(button_minimize, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_minimize_on_click, 1));
  button_install := BtnCreate(WizardForm.Handle, 446, 231, 131, 27, ExpandConstant('{tmp}\button_install.png'), 0, FALSE);
  BtnSetEvent(button_install, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_install_on_click, 1));
  button_browse := BtnCreate(WizardForm.Handle, 928, 491, 84, 25, ExpandConstant('{tmp}\button_browse.png'), 0, FALSE);
  BtnSetEvent(button_browse, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_browse_on_click, 1));
  BtnSetVisibility(button_browse, FALSE);
  button_customize_setup := BtnCreate(WizardForm.Handle, 22, 405, 195, 17, ExpandConstant('{tmp}\button_customize_setup.png'), 0, FALSE);
  BtnSetEvent(button_customize_setup, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_customize_setup_on_click, 1));
  button_uncustomize_setup := BtnCreate(WizardForm.Handle, 22, 405, 195, 17, ExpandConstant('{tmp}\button_uncustomize_setup.png'), 0, FALSE);
  BtnSetEvent(button_uncustomize_setup, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_customize_setup_on_click, 1));
  BtnSetVisibility(button_uncustomize_setup, FALSE);
  image_wizardform_label_already_installed := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\label_already_installed.png'), 12, 520, 894, 20, FALSE, FALSE);
  ImgSetVisibility(image_wizardform_label_already_installed, FALSE);
  PBOldProc := SetWindowLong(WizardForm.ProgressGauge.Handle, -4, PBCallBack(@PBProc, 4));
  ImgApplyChanges(WizardForm.Handle);
  messagebox_close_create();
  form_license_create();
END;

PROCEDURE DeinitializeSetup();
BEGIN
  IF ((is_wizardform_released = FALSE) AND (can_exit_setup = FALSE)) THEN
  BEGIN
    gdipShutdown();
    IF is_installer_initialized THEN
    BEGIN
      release_installer_before_init();
    END;
  END;
END;

PROCEDURE CurPageChanged(CurPageID : INTEGER);
BEGIN
  IF (CurPageID = wpWelcome) THEN
  BEGIN
    image_wizardform_background := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\background_wizardform_welcome.png'), 0, 0, WIZARDFORM_WIDTH_NORMAL, WIZARDFORM_HEIGHT_NORMAL, FALSE, TRUE);
    button_wizardform_get_source_code := BtnCreate(WizardForm.Handle, 22, 442, 402, 24, ExpandConstant('{tmp}\button_get_source_code.png'), 0, FALSE);
    BtnSetEvent(button_wizardform_get_source_code, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_get_source_code_on_click, 1));
#ifdef RegisteAssociations
    checkbox_setdefault := BtnCreate(WizardForm.Handle, 13, 544, 364, 20, ExpandConstant('{tmp}\checkbox_setdefault.png'), 0, TRUE);
    BtnSetEvent(checkbox_setdefault, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@checkbox_setdefault_on_click, 1));
    BtnSetChecked(checkbox_setdefault, TRUE);
    BtnSetVisibility(checkbox_setdefault, FALSE);
#endif
    WizardForm.Height := WIZARDFORM_HEIGHT_NORMAL;
    ImgApplyChanges(WizardForm.Handle);
  END;
  IF (CurPageID = wpInstalling) THEN
  BEGIN
    edit_target_path.Hide();
    ImgSetVisibility(image_wizardform_label_already_installed, FALSE);
    BtnSetVisibility(button_browse, FALSE);
    WizardForm.Height := WIZARDFORM_HEIGHT_NORMAL;
    is_wizardform_show_normal := TRUE;
    BtnSetVisibility(button_customize_setup, FALSE);
    BtnSetVisibility(button_uncustomize_setup, FALSE);
    BtnSetVisibility(button_close, FALSE);
    BtnSetPosition(button_minimize, 978, 1, 45, 29);
#ifdef RegisteAssociations
    BtnSetVisibility(checkbox_setdefault, FALSE);
#endif
    BtnSetVisibility(button_wizardform_get_source_code, FALSE);
    label_install_progress := TLabel.Create(WizardForm);
    WITH label_install_progress DO
    BEGIN
      Parent := WizardForm;
      AutoSize := FALSE;
      Left := 429;
      Top := 205;
      Width := 160;
      Height := 65;
      //SetBounds(429, 205, 160, 65);
      Font.Name := 'Samsung Sharp Sans Bold';
      Font.Size := 50;
      Font.Color := $0ae223;
      Alignment := taRightJustify;
      Caption := '';
      Transparent := TRUE;
      OnMouseDown := @wizardform_on_mouse_down;
    END;
    image_wizardform_background := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\background_wizardform_installing.png'), 0, 0, WIZARDFORM_WIDTH_NORMAL, WIZARDFORM_HEIGHT_NORMAL, FALSE, TRUE);
    image_progressbar_background := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\background_progressbar.png'), 0, 0, WIZARDFORM_WIDTH_NORMAL, WIZARDFORM_HEIGHT_NORMAL, FALSE, TRUE);
    image_progressbar_foreground := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\foreground_progressbar.png'), 0, 0, 0, 0, TRUE, TRUE);
    BtnSetVisibility(button_install, FALSE);
    ImgApplyChanges(WizardForm.Handle);
  END;
  IF (CurPageID = wpFinished) THEN
  BEGIN
    label_install_progress.Caption := '';
    label_install_progress.Visible := FALSE;
    ImgSetVisibility(image_progressbar_background, FALSE);
    ImgSetVisibility(image_progressbar_foreground, FALSE);
    BtnSetPosition(button_minimize, 933, 1, 45, 29);
    BtnSetVisibility(button_close, TRUE);
    button_finish := BtnCreate(WizardForm.Handle, 461, 231, 101, 27, ExpandConstant('{tmp}\button_finish.png'), 0, FALSE);
    BtnSetEvent(button_finish, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_finish_on_click, 1));
    BtnSetEvent(button_close, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_finish_on_click, 1));
    image_wizardform_background := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\background_wizardform_finish.png'), 0, 0, WIZARDFORM_WIDTH_NORMAL, WIZARDFORM_HEIGHT_NORMAL, FALSE, TRUE);
    ImgApplyChanges(WizardForm.Handle);
  END;
END;

PROCEDURE CurStepChanged(CurStep : TSetupStep);
BEGIN
  IF (CurStep = ssPostInstall) THEN
  BEGIN
#ifdef RegisteAssociations
    check_if_need_change_associations();
#endif
    //AND DO OTHER THINGS
  END;
  IF (CurStep = ssDone) THEN
  BEGIN
    is_wizardform_released := TRUE;
    release_installer();
  END;
END;

FUNCTION ShouldSkipPage(PageID : INTEGER) : BOOLEAN;
BEGIN
  IF (PageID = wpLicense) THEN Result := TRUE;
  IF (PageID = wpPassword) THEN Result := TRUE;
  IF (PageID = wpInfoBefore) THEN Result := TRUE;
  IF (PageID = wpUserInfo) THEN Result := TRUE;
  IF (PageID = wpSelectDir) THEN Result := TRUE;
  IF (PageID = wpSelectComponents) THEN Result := TRUE;
  IF (PageID = wpSelectProgramGroup) THEN Result := TRUE;
  IF (PageID = wpSelectTasks) THEN Result := TRUE;
  IF (PageID = wpReady) THEN Result := TRUE;
  IF (PageID = wpPreparing) THEN Result := TRUE;
  IF (PageID = wpInfoAfter) THEN Result := TRUE;
END;

PROCEDURE CurUninstallStepChanged(CurUninstallStep : TUninstallStep);
BEGIN
  IF (CurUninstallStep = usAppMutexCheck) THEN
  BEGIN
    //此阶段为检查应用程序互斥的阶段，请在此进行互斥操作
  END;
END;

