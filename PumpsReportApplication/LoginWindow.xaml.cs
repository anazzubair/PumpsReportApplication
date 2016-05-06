using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace PumpsReportApplication
{
    /// <summary>
    /// Interaction logic for LoginWindow.xaml
    /// </summary>
    public partial class LoginWindow : Window
    {
        public LoginWindow()
        {
            InitializeComponent();
            FocusManager.SetFocusedElement(this, TextBoxUsername);
        }

        private void ButtonLogin_Click(object sender, RoutedEventArgs e)
        {
            if ((TextBoxUsername.Text.Trim().Length == 0) || (TextBoxPassword.Password.Trim().Length == 0))
                    return;

            using (var db = new PumpsDBEntities())
            {
                var user = db.Users.FirstOrDefault(u => u.Username == TextBoxUsername.Text.Trim());
                if (user == null || user.Passowrd != TextBoxPassword.Password.Trim())
                {
                    MessageBox.Show("Invalid Credentials");
                    return;
                }

                
                var mainWindow = new MainWindow();
                mainWindow.Show();
                this.Close();
            }
        }
    }
}
