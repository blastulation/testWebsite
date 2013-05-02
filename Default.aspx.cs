using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Sql;
using System.Data.SqlClient;
public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    { 
    }

    protected void DropDownDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    
    {
       
    }
    
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        String Project_Name = DropDownList1.SelectedValue;
        SqlConnection connection = new SqlConnection(TableDataSource.ConnectionString);
        connection.Open();
        SqlDataSource newDataSource = new SqlDataSource(TableDataSource.ConnectionString, @"SELECT        t1.Project_Name, t1.Build_No, TeamCity_1.TeamCity, Klocwork_1.Klocwork
FROM            (SELECT        Project_Name, Build_No
                          FROM            Klocwork
                          WHERE        (Project_Name = '"+Project_Name+@"')
                          UNION
                          SELECT        Project_Name, Build_No
                          FROM            TeamCity
                          WHERE        (Project_Name = '"+Project_Name+@"')) AS t1 FULL OUTER JOIN
                         TeamCity AS TeamCity_1 FULL OUTER JOIN
                         Klocwork AS Klocwork_1 ON Klocwork_1.Build_No = TeamCity_1.Build_No AND Klocwork_1.Project_Name = TeamCity_1.Project_Name ON 
                         TeamCity_1.Build_No = t1.Build_No AND TeamCity_1.Project_Name = t1.Project_Name OR Klocwork_1.Project_Name = t1.Project_Name AND 
                         Klocwork_1.Build_No = t1.Build_No
WHERE        (t1.Project_Name ='"+Project_Name+@"')
        ORDER BY ABS(t1.Build_No) ASC");
        InfoTable.DataSource = newDataSource;
        InfoTable.DataSourceID = ""; //Needs to be set to NULL so we don't double up onDatasource and DataSourceID
        InfoTable.DataBind();
        connection.Close();
    }
}
