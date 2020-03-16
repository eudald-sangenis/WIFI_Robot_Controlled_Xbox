using System;
using System.Windows;
using System.Windows.Controls;
using VisioForge.Types.OutputFormat;
using System.Net.Sockets;
using System.Text;
using OpenJigWare;
using System.Timers;

namespace WIFI_Robot_Controlled_Xbox
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// 
    /// Install NuGet Pakages:
    ///     - VisioForge
    ///     - Material Theme
    ///     - Sharp DX
    ///     - Sharp DX Input
    ///     - OpenJigWare
    /// </summary>
    /// 
    public partial class MainWindow : Window
    {
        /// variables int
        int count_btn_snap = 0;
        int count_btn_recd = 0;
        /// variables bool
        bool connect_cam;
        bool XBOX_X;                ///disconnect false, raisevent Bnt X true - to avoid break program if you push twice Btn X of the controller
        bool start_pilot;
        bool lights_bool;
        /// variables string
        string leds;
        string jx0;
        string jx1;
        string jy1;
        
        ///create a new UDP object sender in the port 2000
        UdpClient udpSender = new UdpClient(2000);
        ///create a new timer
        private static Timer timer;


        public MainWindow()
        {
            InitializeComponent();

            timer = new Timer();
            timer.Interval = 40;
            timer.Elapsed += new ElapsedEventHandler(this.timer1_Tick_1);
            timer.Enabled = true;
        }

        //--------------------------
        //    CAMARA'S CONTROLS
        //--------------------------
        #region CAMARA'S CONTROLS
        ///Camara connection
        private void Connect(object sender, RoutedEventArgs e)
        {
            if(Global_Variables.ip_cam == null || Global_Variables.port_cam == 0)
            {
                MessageBox.Show("IP Camera or Port Camera isn't fulfilled.");
            }
            ///Error - Port number overflow
            else if (Global_Variables.port_cam > 65536)
            {
                MessageBox.Show("Camera's Port number is overflowed." + "\n"
                                + "It has to be smaller than 65536");
            }
            ///Error - IP number overflow
            else if (Global_Variables.ip_cam.Length > 15)
            {
                MessageBox.Show("Camera's IP number is overflowed." + "\n"
                                + "It has to be smaller than 15 digits");
            }
            ///Error - First fill the Ip Configuration:
            else
            {
                ///initialize the image
                videoCapture1.IP_Camera_Source = new VisioForge.Types.Sources.IPCameraSourceSettings()
                {
                    ///Especific URL to connect to S8
                    URL = "http://" + Global_Variables.ip_cam + ":" + Global_Variables.port_cam.ToString() + "/video",
                    ///Type HTTP: we obtein the image through and URL, LowLatency: we want the image in real time, but we lost resolution.
                    Type = VisioForge.Types.VFIPSource.HTTP_MJPEG_LowLatency
                };
                ///initialize the audio
                videoCapture1.Audio_PlayAudio = videoCapture1.Audio_RecordAudio = false;
                videoCapture1.Mode = VisioForge.Types.VFVideoCaptureMode.IPPreview;

                connect_cam = true;
                videoCapture1.Start();
            }
        }

        ///Camara disconnection
        private void Disconnect(object sender, RoutedEventArgs e)
        {
            connect_cam = false;
            videoCapture1.Stop();
            XBOX_X = false;
        }

        ///Camera record
        private void Record(object sender, RoutedEventArgs e)
        {
            if (connect_cam == false)
            {
                MessageBox.Show("First Connect the Camera");
            }
            else
            {
                ///number of record button clicks 
                count_btn_recd++;

                ///if the streaming is enable it close the object videoCapture1
                if (videoCapture1.IsEnabled)
                {
                    videoCapture1.Stop();
                }

                ///Create a new videoCapture1 object
                videoCapture1.IP_Camera_Source = new VisioForge.Types.Sources.IPCameraSourceSettings()
                {
                    URL = "http://" + Global_Variables.ip_cam + ":" + Global_Variables.port_cam.ToString() + "/video",
                    Type = VisioForge.Types.VFIPSource.HTTP_MJPEG_LowLatency
                };
                ///Audio Settings
                videoCapture1.Audio_PlayAudio = videoCapture1.Audio_RecordAudio = false;
                ///save the video to myvideos folder with the name of vid_{count_btn_recd}.mp4
                videoCapture1.Output_Filename = Environment.GetFolderPath(Environment.SpecialFolder.MyVideos) + $"\\vid_{count_btn_recd}.mp4";
                ///Output video format
                videoCapture1.Output_Format = new VFWMVOutput();
                ///Type of video
                videoCapture1.Mode = VisioForge.Types.VFVideoCaptureMode.IPCapture;

                videoCapture1.Start();
            }
        }

        ///Camara snapshoot
        private void Snapshot(object sender, RoutedEventArgs e)
        {
            if (connect_cam == false)
            {
                MessageBox.Show("First Connect the Camera");
            }
            else
            {
                ///number of snapshot button clicks 
                count_btn_snap++;
                ///save the snapshot to mypictures folder with the name of frame_{count_btn_snap}.jpg
                videoCapture1.Frame_Save(Environment.GetFolderPath(Environment.SpecialFolder.MyPictures) + $"\\frame_{count_btn_snap}.jpg", VisioForge.Types.VFImageFormat.JPEG, 85);
            }

        }
        #endregion CAMARA'S CONTROLS



        //--------------------------
        //    IP CONFING WINDOW
        //--------------------------
        #region IP CONFING WINDOW
        private void Ip_config_Click(object sender, RoutedEventArgs e)
        {
            IP_Window iP_Window = new IP_Window();
            iP_Window.Show();
        }
        #endregion IP CONFING WINDOW



        //--------------------------
        //         Joystick
        //--------------------------
        #region Joystick

        private Ojw.CJoystick m_CJoy = new Ojw.CJoystick(Ojw.CJoystick._ID_0);  ///Joystick Declaration
        private Ojw.CTimer m_CTmr_Joystick = new Ojw.CTimer();                  ///Timer to periodically check joystick connection

        //analize data and send it
        #region Joystick data
        private void FJoystick_Check_Data()
        {
            #region Joystick Check Data

            //arrows
            #region arrows

            if (m_CJoy.IsDown(Ojw.CJoystick.PadKey.POVLeft)) ///leds off
            {
                leds = "2";
            }

            else if (m_CJoy.IsDown(Ojw.CJoystick.PadKey.POVDown) == true) ///leds on
            {
                leds = "1";
            }

            else
            {
                leds = "0";
            }

            #endregion arrows

            //butons
            #region buttons
            if (m_CJoy.IsDown(Ojw.CJoystick.PadKey.Button1) == true) // A
            {
                ///Error - Null values ip_rob or port_rob
                if (Global_Variables.ip_rob == null || Global_Variables.port_rob == 0)
                {
                    MessageBox.Show("IP Robot or Port Robot isn't fulfilled.");
                }
                ///Error - Port number overflow
                else if (Global_Variables.port_rob > 65536)
                {
                    MessageBox.Show("Robot's Port number is overflowed." + "\n"
                                    + "It has to be smaller than 65536");
                }
                ///Error - IP number overflow
                else if (Global_Variables.ip_rob.Length > 15)
                {
                    MessageBox.Show("Robot's IP number is overflowed." + "\n"
                                    + "It has to be smaller than 15 digits");
                }
                ///Error - First fill the Ip Configuration:
                else
                {
                    start_pilot = true; ///To be able to send the joysitcks value data to the robot
                }
            }

            if (m_CJoy.IsDown_Event(Ojw.CJoystick.PadKey.Button3) == true && XBOX_X == false) // X
            {
                this.Dispatcher.Invoke(() =>
                {
                    BtnConnect.RaiseEvent(new RoutedEventArgs(Button.ClickEvent));
                });
                XBOX_X = true;
            }

            if (m_CJoy.IsDown_Event(Ojw.CJoystick.PadKey.Button4) == true) // Y
            {
                this.Dispatcher.Invoke(() =>
                {
                    BtnDisconnect.RaiseEvent(new RoutedEventArgs(Button.ClickEvent));
                });
            }
            #endregion buttons

            //R & L buttons
            #region R & L buttons

            if (m_CJoy.IsDown_Event(Ojw.CJoystick.PadKey.Button5) == true) //press LB -- Photo
            {
                this.Dispatcher.Invoke(() =>
                {
                    BtnSnap.RaiseEvent(new RoutedEventArgs(Button.ClickEvent));
                });
            }

            if (m_CJoy.IsDown_Event(Ojw.CJoystick.PadKey.Button6) == true) //press RB -- Record
            {
                this.Dispatcher.Invoke(() =>
                {
                    BtnRecord.RaiseEvent(new RoutedEventArgs(Button.ClickEvent));
                });
            }

            #endregion R & L buttons

            //Joysticks
            #region Joysticks values

            //data to send
            jx0 = Math.Round(m_CJoy.dX0, 1).ToString(); //camera servo
            jx1 = Math.Round(m_CJoy.dX1, 1).ToString(); //steer  servo
            jy1 = (1-Math.Round(m_CJoy.dY1, 1)).ToString(); //velocity and direction

            jx0 = jx0.Replace(",", ".");
            jx1 = jx1.Replace(",", ".");
            jy1 = jy1.Replace(",", ".");

            if (jx0 == "0") jx0 = "0.0";
            if (jx1 == "0") jx1 = "0.0";
            if (jy1 == "0") jy1 = "0.0";
            if (jx0 == "1") jx0 = "1.0";
            if (jx1 == "1") jx1 = "1.0";
            if (jy1 == "1") jy1 = "1.0";

            //data to show to the screen
            var camera_tilt = (Math.Round(m_CJoy.dX0, 1) - 0) * (170 - 10) / (1 - 0) + 10;
            var steer = (Math.Round(m_CJoy.dX1, 1) - 0)*(110 - 70) / (1 - 0) + 70;
            var velocity = 0.0;
            var lights = "";
            var drive = "";
            if((1 - Math.Round(m_CJoy.dY1, 1)) >= 0.5)  velocity = ((1 - Math.Round(m_CJoy.dY1, 1)) - 0.5 - 0) * (100 - 0) / (0.5 - 0) + 0;
            else  velocity = ((1 - Math.Round(m_CJoy.dY1, 1)) - 0.5 - 0) * (100 - 0) / (0.5 - 0) + 0;
            if (leds == "1")
            {
                lights = "on";
                lights_bool = true;
            }
            if (leds == "2")
            {
                lights = "off";
                lights_bool = false;
            }
            if (leds == "0")
            {
                if (lights_bool == true) lights = "on";
                else lights = "off";
            }
            if (start_pilot == true) drive = "Available";
            else drive = "Disable";
            

            #endregion Joysticks values

            //Send data
            #region Send & print data

            this.Dispatcher.Invoke(() =>
            {
                //send data
                if (start_pilot == true)
                {
                    var joystick_values = "jx0" + jx0 + "jx1" + jx1 + "jy1" + jy1 + "LED" + leds;
                    udpSender.Connect(Global_Variables.ip_rob, Global_Variables.port_rob);
                    Byte[] sendBytes_jx0 = Encoding.ASCII.GetBytes(joystick_values);
                    udpSender.Send(sendBytes_jx0, sendBytes_jx0.Length);
                }

                //print data
                lb_joysticks.Text = "  Camera: " + camera_tilt + " degrees" + "\n\n" + "  Steer: " + steer + " degrees \n\n"  + "  Velocity: " + velocity;
                lb_buttons.Text = "  Drive: " + drive + "\n\n" + "  Lights: " + lights;
            });

            #endregion Send & print data

            #endregion Joystick Check Data
        }
        #endregion Joystick data

        //timer event
        #region timer event
        public void timer1_Tick_1(object sender, EventArgs e)
        {
            // update joystick information
            m_CJoy.Update();
            // Joystick Data Check
            FJoystick_Check_Data();            
        }
        #endregion timer event

        #endregion Joystick
    }
}