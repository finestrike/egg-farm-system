using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using EggFarmSystem.Client.Core.Views;
using EggFarmSystem.Client.Modules.MasterData.ViewModels;
using EggFarmSystem.Models;

namespace EggFarmSystem.Client.Modules.MasterData.Views
{
    /// <summary>
    /// Interaction logic for HenListView.xaml
    /// </summary>
    public partial class HenListView : UserControlBase, IHenListView
    {

        private HenListViewModel ViewModel { get; set; }

        public HenListView(HenListViewModel viewModel)
        {
            InitializeComponent();
            ViewModel = viewModel;
            this.DataContext = ViewModel;
            this.NavigationCommands = viewModel.NavigationCommands;
            SetEventHandlers();
        }

        private void SetEventHandlers()
        {
            lvHenList.MouseUp += lvHenList_MouseDown;
            lvHenList.MouseDoubleClick += lvHenList_MouseDoubleClick;
        }

        void lvHenList_MouseDown(object sender, MouseButtonEventArgs e)
        {
            var selectedHen = lvHenList.SelectedItem as Hen;
            if(selectedHen == null)
                return;
            
            ViewModel.EditCommand.EntityId = selectedHen.Id;
            ViewModel.DeleteCommand.EntityId = selectedHen.Id;
        }

        void lvHenList_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            ViewModel.EditCommand.Execute(null);
        }

        private void UnsetEventHandlers()
        {
            lvHenList.MouseUp -= lvHenList_MouseDown;
            lvHenList.MouseDoubleClick -= lvHenList_MouseDoubleClick;  
        }

        public override void Dispose()
        {
            UnsetEventHandlers();
        }

        private void ListView_SizeChanged(object sender, SizeChangedEventArgs e)
        {
            Resize(sender);
        }

        private void ListView_Loaded(object sender, RoutedEventArgs e)
        {
            Resize(sender);
        }

        void Resize(object sender)
        {
            //ListView lvHenList = sender as ListView;
            //GridView view = lvHenList.View as GridView;
            //GridViewColumn column = view.Columns.Last() as GridViewColumn;
            //double total = 0;
            //for (int i = 0; i < view.Columns.Count - 1; i++)
            //{
            //    total += view.Columns[i].ActualWidth ;
            //}
            //column.Width = lvHenList.ActualWidth - total;
        }
    }

    public interface IHenListView
    {
        
    }
}
