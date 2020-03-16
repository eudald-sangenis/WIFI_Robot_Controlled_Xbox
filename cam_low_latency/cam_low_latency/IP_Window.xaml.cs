using System;
using System.Windows;

namespace WIFI_Robot_Controlled_Xbox
{
    /// <summary>
    /// Interaction logic for Window1.xaml
    /// </summary>
    public partial class IP_Window : Window
    {
        public IP_Window()
        {
            InitializeComponent();
        }
               
        private void Apply_Click(object sender, RoutedEventArgs e)
        {
            Global_Variables. ip_cam = txb_Ip_cam.Text;
            Global_Variables.ip_rob = txb_Ip_rob.Text;
            Global_Variables.port_cam = Convert.ToInt32(txb_Port_cam.Text);
            Global_Variables.port_rob = Convert.ToInt32(txb_Port_rob.Text);
        }
    }
}


