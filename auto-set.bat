@echo off
title BLOCK Win10AU!
mode con cols=70 lines=15
color 1f
echo ������������������������������������������������������������������������������
echo ��                    ����Windows10�Զ�����                                        ��
echo ��                                                                  		            ��
echo ��          Block Windows X Automatic Update By F1tz                    ��
echo ��                                                                  		            ��
echo ��                   �����˳�360�Ȱ�ȫ�ܼң�                                         ��
echo ��           ��ȷ���Ҽ�ѡ���Թ���Ա�������С��˽ű�                      ��
echo ��                                                                  		            ��
echo ��         Please quit your Anti-Malware software first!                    ��
echo ��  Make sure Right-click on script select "Run as administrator".  ��
echo ��                                  ��  levi  ��                                                 ��
echo ������������������������������������������������������������������������������
echo.
pause

echo ����������������������������������������������������������������������
echo ��                                                                  		��
echo ��                  �������� / Stopping Process...                  	��
echo ��                                                                  		��
echo ����������������������������������������������������������������������

taskkill /im Windows10UpgraderApp.exe 2>nul
del /f /q "%USERPROFILE%\Desktop\΢�� Windows 10 ����.lnk" 2>nul
del /f /q "%USERPROFILE%\Desktop\Windows 10 Update Assistant.lnk" 2>nul

echo ����������������������������������������������������������������������
echo ��                                                                  		 ��
echo ��           ���ӷ���ǽ���� / Adding firewall rules...                ��
echo ��                                                                 		 ��
echo ����������������������������������������������������������������������

netsh advfirewall firewall add rule name="Block_Windows10UpgraderApp" dir=in program="%SYSTEMDRIVE%\Windows10Upgrade\Windows10UpgraderApp.exe" action=block
netsh advfirewall firewall add rule name="Block_WinREBootApp32" dir=in program="%SYSTEMDRIVE%\Windows10Upgrade\WinREBootApp32.exe" action=block
netsh advfirewall firewall add rule name="Block_WinREBootApp64" dir=in program="%SYSTEMDRIVE%\Windows10Upgrade\WinREBootApp64.exe" action=block
netsh advfirewall firewall add rule name="Block_bootsect" dir=in program="%SYSTEMDRIVE%\Windows10Upgrade\bootsect.exe" action=block
netsh advfirewall firewall add rule name="Block_DW20" dir=in program="%SYSTEMDRIVE%\Windows10Upgrade\DW20.EXE" action=block
netsh advfirewall firewall add rule name="Block_DWTRIG20" dir=in program="%SYSTEMDRIVE%\Windows10Upgrade\DWTRIG20.EXE" action=block
netsh advfirewall firewall add rule name="Block_GatherOSState" dir=in program="%SYSTEMDRIVE%\Windows10Upgrade\GatherOSState.EXE" action=block
netsh advfirewall firewall add rule name="Block_GetCurrentRollback" dir=in program="%SYSTEMDRIVE%\Windows10Upgrade\GetCurrentRollback.EXE" action=block
netsh advfirewall firewall add rule name="Block_HttpHelper" dir=in program="%SYSTEMDRIVE%\Windows10Upgrade\HttpHelper.exe" action=block
netsh advfirewall firewall add rule name="Block_UpdateAssistant" dir=in program="%SYSTEMROOT%\UpdateAssistant\UpdateAssistant.exe" action=block
netsh advfirewall firewall add rule name="Block_UpdateAssistantCheck" dir=in program="%SYSTEMROOT%\UpdateAssistant\UpdateAssistantCheck.exe" action=block
netsh advfirewall firewall add rule name="Block_Windows10Upgrade" dir=in program="%SYSTEMROOT%\UpdateAssistant\Windows10Upgrade.exe" action=block
netsh advfirewall firewall add rule name="Block_UpdateAssistantV2" dir=in program="%SYSTEMROOT%\UpdateAssistantV2\UpdateAssistant.exe" action=block
netsh advfirewall firewall add rule name="Block_UpdateAssistantCheckV2" dir=in program="%SYSTEMROOT%\UpdateAssistantV2\UpdateAssistantCheck.exe" action=block
netsh advfirewall firewall add rule name="Block_Windows10UpgradeV2" dir=in program="%SYSTEMROOT%\UpdateAssistantV2\Windows10Upgrade.exe" action=block

echo ����������������������������������������������������������������������
echo ��                                                                  		��
echo ��                 ����ACL / Configurating ACL...                      ��
echo ��                                                                  		��
echo ����������������������������������������������������������������������

echo y|cacls C:\Windows\UpdateAssistant\*.exe /t /p everyone:n 2>nul
echo y|cacls C:\Windows10Upgrade\*.exe /t /p everyone:n 2>nul
echo.
echo ������������������������������������������������������������������������������
echo ��                                                                  		           ��
echo ��         ֹͣWindows Update���� / Disable Windows Update      ��
echo ��                                                                                                ��
echo ������������������������������������������������������������������������������

net stop wuauserv
sc config wuauserv start= disabled

echo ����������������������������������������������������������������������
echo ��                                                                 		 ��
echo ��                   ɾ���ƻ����� / Delete task...                  	 ��
echo ��                                                                  		 ��
echo ����������������������������������������������������������������������

schtasks /delete /TN "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistant" /f 2>nul
schtasks /delete /TN "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistantAllUsersRun" /f 2>nul
schtasks /delete /TN "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistantCalendarRun" /f 2>nul
schtasks /delete /TN "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistantWakeupRun" /f 2>nul

echo ����������������������������������������������������������������������
echo ��                                                                  		��
echo ��                 ����ע��� / Editing Registry...                       ��
echo ��                                                                  		��
echo ����������������������������������������������������������������������

del /q /f %SYSTEMDRIVE%\NAU.reg 2>nul
echo Windows Registry Editor Version 5.00 >> %SYSTEMDRIVE%\NAU.reg
echo.>> %SYSTEMDRIVE%\NAU.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate]>> %SYSTEMDRIVE%\NAU.reg
echo "DoNotConnectToWindowsUpdateInternetLocations"=dword:00000001 >> %SYSTEMDRIVE%\NAU.reg
echo.>> %SYSTEMDRIVE%\NAU.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]>> %SYSTEMDRIVE%\NAU.reg
echo "NoAutoUpdate"=dword:00000001>> %SYSTEMDRIVE%\NAU.reg
REG IMPORT %SYSTEMDRIVE%\NAU.reg
del /q /f %SYSTEMDRIVE%\NAU.reg 2>nul

echo ����������������������������������������������������������������������
echo ��                                                                      	 ��
echo ��                 ��Զ������/...                                              ��
echo ��                                                                                      ��
echo ����������������������������������������������������������������������

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
  

echo ����������������������������������������������������������������������
echo ��                                                                      	 ��
echo ��                 �رշ���ǽ/Desliguem o firewall...                  ��
echo ��                                                                                      ��
echo ����������������������������������������������������������������������

netsh advfirewall set allprofiles state off



echo ����������������������������������������������������������������������
echo ��                                                                      	 ��
echo ��                 �����ļ�/copy dir...                                        ��
echo ��                                                                                      ��
echo ����������������������������������������������������������������������

XCOPY \\172.16.30.19\share\tool\�Զ�������\auto_tool C:\testtool\  /s/e/i/y


echo ����������������������������������������������������������������������
echo ��                                                                  		��
echo ��                       ������� / All Done��                      	��
echo ��                                                                  		��
echo ����������������������������������������������������������������������
pause