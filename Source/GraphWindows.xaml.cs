using System;
using System.Windows.Controls;
using System.Windows.Media;
using LiveCharts;
using LiveCharts.Defaults;
using LiveCharts.Wpf;

namespace Pamola.Viewer
{
    public partial class GraphWindows : UserControl
    {
        public Pamola.Phasor.Phasor Phasor { get; set; }

        public LineSeries PhasorSeries { get; set; }

        public GraphWindows()
        {

            InitializeComponent();

            PhasorCollection = new SeriesCollection();

            Phasor = new Phasor.Phasor();

            PhasorSeries = new LineSeries();
            PhasorSeries.Values = PhasorToChartValues();
            PhasorSeries.Title = "Phasor 1";
            PhasorSeries.LineSmoothness = 0;
            PhasorSeries.PointGeometry = DefaultGeometries.Triangle;
            PhasorSeries.PointGeometrySize = 10;
            PhasorSeries.Fill = System.Windows.Media.Brushes.Transparent;

            PhasorCollection.Add(PhasorSeries);


            DataContext = this;
        }


        public ChartValues<ObservablePoint> PhasorToChartValues()
        {
            var phasorValues = new ChartValues<ObservablePoint>();

            phasorValues.Add(new ObservablePoint { X = 0.0, Y = 0.0 });
            phasorValues.Add(new ObservablePoint { X = Phasor.Value().Real, Y = Phasor.Value().Imaginary });

            return phasorValues;
        }

        public SeriesCollection PhasorCollection { get; set; }
    }
}
