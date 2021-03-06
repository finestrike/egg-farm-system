﻿using EggFarmSystem.Models;
using ServiceStack.OrmLite;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EggFarmSystem.Services
{
    public interface IHenService : IDataService<Hen>
    {
        SearchResult<Hen> Search();
    }

    public class HenService : DataService<Hen>, IHenService
    {
        IDbConnectionFactory factory;

        public HenService(IDbConnectionFactory factory) : base(factory)
        {
            this.factory = factory;
        }

        public SearchResult<Hen> Search()
        {
            var result = new SearchResult<Hen>();

            using (var db = factory.CreateDbConnection())
            {
                db.Open();
                result.Items = db.Select<Hen>().ToList();
                result.Total = (int) db.Count<Hen>();
            }

            return result;
        }

        public override IList<Hen> GetAll()
        {
            return base.GetAll().OrderBy(h => h.Name).ToList();
        }
    }
}
