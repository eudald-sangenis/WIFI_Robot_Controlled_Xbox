   M S B A M L   `   `   `  ���� U  QWIFI_Robot_Controlled_Xbox, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullG(clr-namespace:WIFI_Robot_Controlled_XboxWIFI_Robot_Controlled_Xbox  _ [VisioForge.Controls.UI, Version=11.3.29.0, Culture=neutral, PublicKeyToken=eafa6bd21aa991fdgHclr-namespace:VisioForge.Controls.UI.WPF;assembly=VisioForge.Controls.UIVisioForge.Controls.UI.WPF +    %WIFI_Robot_Controlled_Xbox.MainWindow   W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     :local(clr-namespace:WIFI_Robot_Controlled_Xbox     XWPFHclr-namespace:VisioForge.Controls.UI.WPF;assembly=VisioForge.Controls.UI       � Title$  WIFI RC ROBOT��$	��515��$
��1000�� � 
ResizeMode$ NoResize=�
�������.��� -    �Name$ OutsideGrid�� � ColumnDefinitions �� $��15 ��� $	��450 ��� $��* ��� $��15 � � RowDefinitions �� $��10 ��� $	��336 ��� $��* ��� $��10 �.+�� -   $ InnerCameraGrid��$��1��$��2�� �� $��20 ��� $��* ��� $��* ��� $��20 � �� $��20 ��� $��50 ��� $��50 ��� $��* �.+��� -    ��Name$ 
BtnConnect��$��Connect��$��35��$	��140��$��1��$��1���� -   $ BtnDisconnect��$��
Disconnect��$��35��$	��140��$��2��$��1���� -   $ 	BtnRecord��$��Record��$��35��$	��140��$��1��$��2������ .R��� $H��BC:\Users\carle\Documents\GitHub\WIFI_Robot_Controlled_Xbox\rec.png��$��Center=�$��50���� -   $ BtnSnap��$��Snapshot��$��35��$	��140��$��2��$��2������ .R��� $I��CC:\Users\carle\Documents\GitHub\WIFI_Robot_Controlled_Xbox\snap.png��$��Center=�$��20��� -   $ ControlsGrid��$��2��$��1�� �� $��15 ��� $��* �.+��� $R��LC:\Users\carle\Documents\GitHub\WIFI_Robot_Controlled_Xbox\xbox_controls.png��$
��Fill=�$��1���� $��Xbox Controller Commands��$��1��$��25(�$	��Top=�$��Center=�$
��Bold"����#333333�� -   $ BtnIP��$��15��$��15��$��0��$��0��$	��Top=�$
��Left=�$��5,0,0,0q� ^� InitialShowDelay$	 500�� ^� ShowDuration$
 3000�� ^� BetweenShowDelay$ 10000��	 � ToolTip$	 Configurate IP.������ .R��� $I��CC:\Users\carle\Documents\GitHub\WIFI_Robot_Controlled_Xbox\gear.png��� -	   $ 	Sensoring��$��2��$��2��.+��� $��Joysticks information:��$
��Left=�$	��Top=�$��Normal$�$��14(�$��	65,0,10,0q�$
��Bold"��� $��Buttons information:��$��Right=�$	��Top=�$��Normal$�$��14(�$��	10,0,65,0q�$
��Bold"��� -
   
 ��Name$
 lb_joysticks��$	��Top=�$
��Left=�$��
40,30,40,0q�$��90��$	��200��
��������� -   $
 
lb_buttons��$	��Top=�$��Right=�$��
40,30,40,0q�$��90��$	��200��
������� � $��1��$��1��$	��336��$	��450�����#333333���� $��	No Signal��$��20(�$��Italic$����#FFFFFF$��Center=�$��Center=�-  'VisioForge.Controls.UI.WPF.VideoCapture  -   $��videoCapture1��$
��Left=�$	��Top=�$	��336��$	��450��$��1��$��1��