   M S B A M L   `   `   `  ����U  QWIFI_Robot_Controlled_Xbox, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullG(clr-namespace:WIFI_Robot_Controlled_XboxWIFI_Robot_Controlled_Xbox  5   	   _ [VisioForge.Controls.UI, Version=11.3.29.0, Culture=neutral, PublicKeyToken=eafa6bd21aa991fdgHclr-namespace:VisioForge.Controls.UI.WPF;assembly=VisioForge.Controls.UIVisioForge.Controls.UI.WPF 5   	   +    %WIFI_Robot_Controlled_Xbox.MainWindow   5   	   W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   :local(clr-namespace:WIFI_Robot_Controlled_Xbox     5   	   XWPFHclr-namespace:VisioForge.Controls.UI.WPF;assembly=VisioForge.Controls.UI     5   	     � Title$  WIFI RC ROBOT��5
   	   $	��515��6   $
��1000��6,    � 
ResizeMode$ NoResize=�69   
�������.��5      � -   5         �Name$ OutsideGrid��5       � ColumnDefinitions 5   
   �� 5      $��15 �6   �� 5      $	��450 �6   �� 5      $��* �6   �� 5      $��15 �6    � RowDefinitions 5   
   �� 5      $��10 �6   �� 5      $	��336 �6   �� 5      $��* �6   �� 5      $��10 �6   .+�5   
   � -   5        $ InnerCameraGrid��5      $��1��6(   $��2��68    5      �� 5      $��20 �6#   �� 5       $��* �6#   �� 5!      $��* �6#   �� 5"      $��20 �6#    5$      �� 5%      $��20 �6    �� 5&      $��50 �6    �� 5'      $��50 �6    �� 5(      $��* �6    .+�5,      �� -   5         ��Name$ 
BtnConnect��5,      $��Connect��69   $��35��5-      $	��140��6   $��1��5.      $��1��6!   5/      �� 50      -   5        $ BtnDisconnect��50      $��
Disconnect��6?   $��35��51      $	��140��6   $��2��52      $��1��6!   53      �� 54      -   5        $ 	BtnRecord��54      $��Record��67   $��35��55      $	��140��6   $��1��56      $��2��6!   ��57      �� 58      .R�59      �� $H��BC:\Users\carle\Documents\GitHub\WIFI_Robot_Controlled_Xbox\rec.png��6    $��Center=�6m   $��50��6�   5:      5<      �� 5=      -   5        $ BtnSnap��5=      $��Snapshot��67   $��35��5>      $	��140��6   $��2��5?      $��2��6!   ��5@      �� 5A      .R�5B      �� $I��CC:\Users\carle\Documents\GitHub\WIFI_Robot_Controlled_Xbox\snap.png��6    $��Center=�6n   $��20��6�   5C      5E      5F      � 5I   
   -   5        $ ControlsGrid��5I      $��2��6%   $��1��65    5J      �� 5K      $��15 �6    �� 5L      $��* �6    .+�5O      �� $R��LC:\Users\carle\Documents\GitHub\WIFI_Robot_Controlled_Xbox\xbox_controls.png��6   $
��Fill=�6j   $��1��6y   �� 5P      $��Xbox Controller Commands��6   $��1��67   $��25(�6D   $	��Top=�6R   $��Center=�6j   $
��Bold"�6�   ���#3333336�   �� 5S      -   5        $ BtnIP��5S      $��15��6$   $��15��60   $��0��6;   $��0��6K   $	��Top=�5T      $
��Left=�6-   $��5,0,0,0q�6H    ^� InitialShowDelay$	 500��5U       ^� ShowDuration$
 3000��6;    ^� BetweenShowDelay$ 10000��6^   	 � ToolTip$	 Configurate IP.��6�   ��5V      �� 5W      .R�5X      �� $I��CC:\Users\carle\Documents\GitHub\WIFI_Robot_Controlled_Xbox\gear.png��6    5Y      5[      5\      � 5_   
   -	   5        $ 	Sensoring��5_      $��2��6"   $��2��62   .+�5`      �� $��Joysticks information:��6   $
��Left=�65   $	��Top=�6Q   $��Normal$�6i   $��14(�6|   $��	65,0,10,0q�6�   $
��Bold"�6�   �� 5a      $��Buttons information:��6   $��Right=�65   $	��Top=�6Q   $��Normal$�6i   $��14(�6|   $��	10,0,65,0q�6�   $
��Bold"�6�   �� 5c      -
   5        
 ��Name$
 lb_joysticks��5c      $	��Top=�6,   $
��Left=�6D   $��
40,30,40,0q�6`   $��90��6t   $	��200��6�   
�������6�   �� 5d      -   5        $
 
lb_buttons��5d      $	��Top=�6,   $��Right=�6D   $��
40,30,40,0q�6`   $��90��6t   $	��200��6�   
�������6�   5e       � 5i   
   $��1��6   $��1��6    $	��336��6-   $	��450��6:   ���#333333��5j      �� 5k      $��	No Signal��6   $��20(�6-   $��Italic$�6;   ���#FFFFFF$��Center=�6c   $��Center=�6�   5m      -  'VisioForge.Controls.UI.WPF.VideoCapture  5o   
   -   5        $��videoCapture1��5o      $
��Left=�60   $	��Top=�6K   $	��336��5p      $	��450��6)   $��1��5q      $��1��6+   5r      5s      