﻿using EggFarmSystem.Client.Commands;
using EggFarmSystem.Client.Core;
using EggFarmSystem.Client.Modules.MasterData.Commands;
using EggFarmSystem.Models;
using EggFarmSystem.Services;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Windows;

namespace EggFarmSystem.Client.Modules.MasterData.ViewModels
{
    public class EmployeeListViewModel : ViewModelBase
    {
        private readonly IMessageBroker messageBroker;
        private readonly IEmployeeService employeeService;

        private ObservableCollection<Employee> employees;

        public EmployeeListViewModel(IMessageBroker messageBroker, IEmployeeService employeeService,
                                     NewEmployeeCommand newEmployeeCommand, EditEmployeeCommand editEmployeeCommand,
                                     DeleteEmployeeCommand deleteEmployeeCommand)
        {
            this.messageBroker = messageBroker;
            this.employeeService = employeeService;

            NewCommand = newEmployeeCommand;
            EditCommand = editEmployeeCommand;
            DeleteCommand = deleteEmployeeCommand;

            employees =new ObservableCollection<Employee>();

            NavigationCommands = new List<CommandBase>() {NewCommand, EditCommand, DeleteCommand};
            SubscribeMessages();
        }

        public NewEmployeeCommand NewCommand { get; private set; }

        public EditEmployeeCommand EditCommand { get; private set; }

        public DeleteEmployeeCommand DeleteCommand { get; private set; }

        public IList<CommandBase> NavigationCommands { get; private set; }

        public ObservableCollection<Employee> Employees
        {
            get { return employees; }
            set { 
                employees = value;
                OnPropertyChanged("Employees");
            }
        }

        void SubscribeMessages()
        {
            messageBroker.Subscribe(CommonMessages.RefreshEmployeeList, OnEmployeeRefresh);
            messageBroker.Subscribe(CommonMessages.DeleteEmployeeFailed, OnDeleteEmployeeFailed);
        }

        void OnEmployeeRefresh(object param)
        {
            var employeeList = employeeService.GetAll();
            Employees = new ObservableCollection<Employee>(employeeList);
        }

        void OnDeleteEmployeeFailed(object param)
        {
            MessageBox.Show(param.ToString());
        }

        void UnsubscribeMessages()
        {
            messageBroker.Unsubscribe(CommonMessages.RefreshEmployeeList, OnEmployeeRefresh);
            messageBroker.Unsubscribe(CommonMessages.DeleteEmployeeFailed, OnDeleteEmployeeFailed);
        }

        public override void Dispose()
        {
            UnsubscribeMessages();
            base.Dispose();
        }
    }
}