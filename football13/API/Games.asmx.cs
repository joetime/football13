using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace football13.API
{
    /// <summary>
    /// Summary description for Games
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class Games : System.Web.Services.WebService
    {
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        DataModel.kfpoolsaEntities DB = new DataModel.kfpoolsaEntities();

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        public object ByWeek(int week)
        {
            object list = (from g in DB.Games.Where(x => x.Week == week)
                   select new {
                       id = g.Id,
                       
                       homeTeamId = g.HomeId,
                       homeTeamName = g.HomeTeam.Mascot,
                       homeTeamImg = g.HomeTeam.Image,

                       visTeamId = g.VisId,
                       visTeamName = g.VisTeam.Mascot,
                       visTeamImg = g.VisTeam.Image,

                       //favTeamId = g.Favorite,
                       favTeamName = g.Favorite.Value == g.HomeId ?
                            g.HomeTeam.Mascot :
                            g.VisTeam.Mascot,

                       date = g.GameDate,
                       
                       spread = g.Spread
                   }).ToList();

            return serializer.Serialize(list);
        }
    }
}
