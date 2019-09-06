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
using System.Windows.Navigation;
using System.Windows.Shapes;
using MahApps.Metro.Controls;
using MahApps.Metro.IconPacks;

namespace Pamola.Viewer
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow 
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void RotateButton_MouseEnter(object sender, MouseEventArgs e)
        {
            rotateButton.BorderThickness = new Thickness(2);
        }

        private void RotateButton_MouseLeave(object sender, MouseEventArgs e)
        {
            rotateButton.BorderThickness = new Thickness(0);
        }

        private void AddPhasorButton_MouseEnter(object sender, MouseEventArgs e)
        {
            addPhasorButton.BorderThickness = new Thickness(2);
        }

        private void AddPhasorButton_MouseLeave(object sender, MouseEventArgs e)
        {
            addPhasorButton.BorderThickness = new Thickness(0);
        }
    }
}
