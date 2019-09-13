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
    public partial class MainWindow : MetroWindow
    {

        public MainWindow()
        {
            InitializeComponent();
            phasorDiagram.Phasor = new Phasor.Phasor();
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

        private void MagnitudeControl_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double?> e)
        {
            phasorDiagram.Phasor.Magnitude = SetNullValue(magnitudeControl.Value);
            UpdateValues();
        }

        private void PhaseControl_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double?> e)
        {
            phasorDiagram.Phasor.Phase = Pamola.Phasor.TrigonometryExtensions.Degree2Radians(
                SetNullValue(phaseControl.Value));
            UpdateValues();
        }

        private double SetNullValue(double? nullableDouble)
        {
            if (nullableDouble == null) return 0.0;

            return (double)nullableDouble;
        }

        private void UpdateValues()
        {
            phasorDiagram.PhasorCollection[0].Values = phasorDiagram.PhasorToChartValues();
        }
    }
}
