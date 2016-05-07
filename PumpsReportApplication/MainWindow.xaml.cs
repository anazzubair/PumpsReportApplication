using Microsoft.Reporting.WinForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
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

namespace PumpsReportApplication
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            InitializeForm();
        }

        private void InitializeForm()
        {
            FillStationsList();
            SetDatePickers();
            ListReportTypes.SelectedIndex = 0;
        }

        private void SetDatePickers()
        {
            DatePickerFrom.SelectedDate = DateTime.Now;
            DatePickerTo.SelectedDate = DateTime.Now;
        }

        private void FillStationsList()
        {
            using(var db = new PumpsDBEntities())
            {
                var stations = db.Stations.ToList();
                ListStations.ItemsSource = stations;
                ListStations.SelectedIndex = 0;
            }
        }

        private void ButtonGenerate_Click(object sender, RoutedEventArgs e)
        {
            ReportViewer.Reset();

            switch (ListReportTypes.SelectedValue.ToString())
            {
                case "Daily":
                    GenerateDailyReport();
                    break;
                case "Monthly":
                    GenerateMonthlyReport();
                    break;
                case "Yearly":
                    GenerateYearlyReport();
                    break;
                default:
                    break;
            }
        }

        private void GenerateYearlyReport()
        {
            throw new NotImplementedException();
        }

        private void GenerateMonthlyReport()
        {
            using (var db = new PumpsDBEntities())
            {
                var monthlyReportData = db.MonthlyReportViews.Where(dr => dr.StationId == (long)ListStations.SelectedValue).ToList();
                var pumpReportDataSource = new ReportDataSource("MonthlyReportDataSet", monthlyReportData);
                ReportViewer.LocalReport.DataSources.Add(pumpReportDataSource);
                ReportViewer.LocalReport.ReportEmbeddedResource = "PumpsReportApplication.Reports.MonthlyReport.rdlc";
                DisableUnwantedExportFormat(ReportViewer, "PDF");
                DisableUnwantedExportFormat(ReportViewer, "Word");
                ReportViewer.LocalReport.Refresh();
                ReportViewer.RefreshReport();
            }
        }

        private void GenerateDailyReport()
        {
            using (var db = new PumpsDBEntities())
            {
                var dailyReportData = db.DailyReportViews.Where(dr => dr.StationId == (long)ListStations.SelectedValue).ToList();
                var pumpReportDataSource = new ReportDataSource("DailyReportDataSet", dailyReportData);
                ReportViewer.LocalReport.DataSources.Add(pumpReportDataSource);
                ReportViewer.LocalReport.ReportEmbeddedResource = "PumpsReportApplication.Reports.DailyReport.rdlc";
                DisableUnwantedExportFormat(ReportViewer, "PDF");
                DisableUnwantedExportFormat(ReportViewer, "Word");
                ReportViewer.LocalReport.Refresh();
                ReportViewer.RefreshReport();
            }
        }

        public void DisableUnwantedExportFormat(ReportViewer ReportViewerID, string strFormatName)
        {
            FieldInfo info;

            foreach (RenderingExtension extension in ReportViewerID.LocalReport.ListRenderingExtensions())
            {
                if (extension.Name.ToUpper().Contains(strFormatName.ToUpper()))
                {
                    info = extension.GetType().GetField("m_isVisible", BindingFlags.Instance | BindingFlags.NonPublic);
                    info.SetValue(extension, false);
                }
            }
        }
    }
}
