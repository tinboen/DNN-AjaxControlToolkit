<%@ WebService Language="C#" Class="Samples.AspNet.WebService" %>

using System;
using System.Web;
using System.Web.Services;
using System.Xml;
using System.Web.Services.Protocols;
using System.Web.Script.Services;

using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace Samples.AspNet
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [ScriptService]
    public class WebService : System.Web.Services.WebService
    {

        private string _xmlString =
            @"<?xml version=""1.0"" encoding=""utf-8"" ?>
                <message>
                    <content>
                        Welcome to the asynchronous communication layer world!
                    </content>
                </message>";

        // This method returns an XmlDocument type.
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Xml)]
        public XmlDocument GetXmlDocument()
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(_xmlString);
            return xmlDoc;
        }

        // This method uses GET instead of POST.
        // For this reason its input parameters
        // are sent by the client in the
        // URL query string.
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public string EchoStringAndDate(DateTime dt, string s)
        {
            return s + ":" + dt.ToString();
        }

        [WebMethod]
        public string GetServerTime()
        {

            string serverTime =
                String.Format("The current time is {0}.", DateTime.Now);

            return serverTime;

        }

        [WebMethod]
        public string Add(int a, int b)
        {

            int addition = a + b;
            string result =
                String.Format("The addition result is {0}.",
                    addition.ToString());

            return result;

        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Xml,
            XmlSerializeString = true)]
        public string GetString()
        {
            return "Hello World";
        }

        [WebMethod]
        public static string GetCurrentTime(string name)
        {
            return "Hello " + name + Environment.NewLine + "The Current Time is: "
                + DateTime.Now.ToString();
        }

        [WebMethod]
        public static string[] GetCustomers(string prefix)
        {
            List<string> customers = new List<string>();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["Northwind"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "select ContactName, CustomerId from Customers where ContactName like @SearchText + '%'";
                    cmd.Parameters.AddWithValue("@SearchText", prefix);
                    cmd.Connection = conn;
                    conn.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            customers.Add(string.Format("{0}-{1}", sdr["ContactName"], sdr["CustomerId"]));
                        }
                    }
                    conn.Close();
                }
            }
            return customers.ToArray();
        }


    }

}
