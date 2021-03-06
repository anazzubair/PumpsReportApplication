﻿using Microsoft.Reporting.WinForms;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Globalization;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading;
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
            CultureInfo ci = CultureInfo.CreateSpecificCulture(CultureInfo.CurrentCulture.Name);
            ci.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            Thread.CurrentThread.CurrentCulture = ci;

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
            DatePickerFrom.SelectedDate = DateTime.Now.AddMonths(-1);
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
                    GenerateDailyReportST();
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
            if (!IsFormValid()) return;

            using (var db = new PumpsDBEntities())
            {
                var fromDate = DatePickerFrom.SelectedDate.Value;
                var toDate = DatePickerTo.SelectedDate.Value;
                var firstOfFromYear = new DateTime(fromDate.Year, fromDate.Month, 1);
                var firstOfYearSucceedingToDate = new DateTime(toDate.AddYears(1).Year, 1, 1);

                var yearlyReportData = db.YearlyReportViews
                                        .Where(dr => dr.StationId == (long)ListStations.SelectedValue
                                         && dr.MessageDate >= fromDate.Year
                                        && dr.MessageDate < (toDate.Year + 1))
                                        .ToList();
                var pumpReportDataSource = new ReportDataSource("YearlyReportDataSet", yearlyReportData);
                ReportViewer.LocalReport.DataSources.Add(pumpReportDataSource);
                ReportViewer.LocalReport.ReportEmbeddedResource = "PumpsReportApplication.Reports.YearlyReport.rdlc";
                DisableUnwantedExportFormat(ReportViewer, "PDF");
                DisableUnwantedExportFormat(ReportViewer, "Word");

                var stationNameParameter = new ReportParameter("StationName", ((Station)ListStations.SelectedItem).Name);
                var fromDateParameter = new ReportParameter("FromDate", DatePickerFrom.SelectedDate.Value.ToString("yyyy"));
                var toDateParameter = new ReportParameter("ToDate", DatePickerTo.SelectedDate.Value.ToString("yyyy"));

                ReportViewer.LocalReport.SetParameters(new List<ReportParameter> { stationNameParameter, fromDateParameter, toDateParameter });

                ReportViewer.LocalReport.Refresh();
                ReportViewer.RefreshReport();
            }
        }

        private void GenerateMonthlyReport()
        {
            if (!IsFormValid()) return;

            using (var db = new PumpsDBEntities())
            {
                var fromDate = DatePickerFrom.SelectedDate.Value;
                var toDate = DatePickerTo.SelectedDate.Value;
                var firstOfFromMonth = new DateTime(fromDate.Year, fromDate.Month, 1);
                var firstOfMonthSucceedingToDate = new DateTime(toDate.Year, toDate.AddMonths(1).Month, 1);

                var monthlyReportData = db.MonthlyReportViews
                                        .Where(dr => dr.StationId == (long)ListStations.SelectedValue
                                        && dr.MessageDate >= firstOfFromMonth
                                        && dr.MessageDate < firstOfMonthSucceedingToDate)
                                        .ToList();
                var pumpReportDataSource = new ReportDataSource("MonthlyReportDataSet", monthlyReportData);
                ReportViewer.LocalReport.DataSources.Add(pumpReportDataSource);
                ReportViewer.LocalReport.ReportEmbeddedResource = "PumpsReportApplication.Reports.MonthlyReport.rdlc";
                DisableUnwantedExportFormat(ReportViewer, "PDF");
                DisableUnwantedExportFormat(ReportViewer, "Word");

                var stationNameParameter = new ReportParameter("StationName", ((Station)ListStations.SelectedItem).Name);
                var fromDateParameter = new ReportParameter("FromDate", DatePickerFrom.SelectedDate.Value.ToString("MMM-yyyy"));
                var toDateParameter = new ReportParameter("ToDate", DatePickerTo.SelectedDate.Value.ToString("MMM-yyyy"));

                ReportViewer.LocalReport.SetParameters(new List<ReportParameter> { stationNameParameter, fromDateParameter, toDateParameter });

                ReportViewer.LocalReport.Refresh();
                ReportViewer.RefreshReport();
            }
        }

        private void GenerateDailyReport()
        {
            if (!IsFormValid()) return;

            using (var db = new PumpsDBEntities())
            {
                var fromDate = DatePickerFrom.SelectedDate.Value.Date;
                var toDate = DatePickerTo.SelectedDate.Value.Date.AddDays(1);
                var dailyReportData = db.DailyReportViews
                                        .Where(dr => dr.StationId == (long)ListStations.SelectedValue
                                         && dr.MessageDate >= fromDate
                                         && dr.MessageDate < toDate)
                                        .ToList();
                var pumpReportDataSource = new ReportDataSource("DailyReportDataSet", dailyReportData);
                ReportViewer.LocalReport.DataSources.Add(pumpReportDataSource);
                ReportViewer.LocalReport.ReportEmbeddedResource = "PumpsReportApplication.Reports.DailyReport.rdlc";
                DisableUnwantedExportFormat(ReportViewer, "PDF");
                DisableUnwantedExportFormat(ReportViewer, "Word");

                var stationNameParameter = new ReportParameter("StationName", ((Station)ListStations.SelectedItem).Name);
                var fromDateParameter = new ReportParameter("FromDate", DatePickerFrom.SelectedDate.Value.ToString("dd/MM/yyyy"));
                var toDateParameter = new ReportParameter("ToDate", DatePickerTo.SelectedDate.Value.ToString("dd/MM/yyyy"));

                ReportViewer.LocalReport.SetParameters(new List<ReportParameter> { stationNameParameter, fromDateParameter, toDateParameter });

                ReportViewer.LocalReport.Refresh();
                ReportViewer.RefreshReport();
            }
        }

        private void GenerateDailyReportST()
        {
            if (!IsFormValid()) return;

            using (var db = new PumpsDBEntities())
            {
                var fromDate = DatePickerFrom.SelectedDate.Value.Date;
                var toDate = DatePickerTo.SelectedDate.Value.Date.AddDays(1);
                var dailyReportData = db.GetDailyReport((long)ListStations.SelectedValue, fromDate, toDate).ToList();
                var pumpReportDataSource = new ReportDataSource("DailyReportDataSet", dailyReportData);
                ReportViewer.LocalReport.DataSources.Add(pumpReportDataSource);
                ReportViewer.LocalReport.ReportEmbeddedResource = "PumpsReportApplication.Reports.DailyReport.rdlc";
                DisableUnwantedExportFormat(ReportViewer, "PDF");
                DisableUnwantedExportFormat(ReportViewer, "Word");

                var stationNameParameter = new ReportParameter("StationName", ((Station)ListStations.SelectedItem).Name);
                var fromDateParameter = new ReportParameter("FromDate", DatePickerFrom.SelectedDate.Value.ToString("dd/MM/yyyy"));
                var toDateParameter = new ReportParameter("ToDate", DatePickerTo.SelectedDate.Value.ToString("dd/MM/yyyy"));

                ReportViewer.LocalReport.SetParameters(new List<ReportParameter> { stationNameParameter, fromDateParameter, toDateParameter });

                ReportViewer.LocalReport.Refresh();
                ReportViewer.RefreshReport();
            }
        }

        private bool IsFormValid()
        {
            if(!DatePickerFrom.SelectedDate.HasValue || !DatePickerTo.SelectedDate.HasValue)
            {
                MessageBox.Show("Invalid Dates");
                return false;
            }
            return true;
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

        private void ListReportTypes_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            switch (ListReportTypes.SelectedValue.ToString())
            {
                case "Daily":
                    DatePickerFrom.SelectedDate = DateTime.Now.AddMonths(-1);
                    DatePickerTo.SelectedDate = DateTime.Now;
                    break;
                case "Monthly":
                    DatePickerFrom.SelectedDate = DateTime.Now.AddYears(-1);
                    DatePickerTo.SelectedDate = DateTime.Now;
                    break;
                case "Yearly":
                    DatePickerFrom.SelectedDate = DateTime.Now.AddYears(-12);
                    DatePickerTo.SelectedDate = DateTime.Now;
                    break;
                default:
                    break;
            }
        }
    }
}
