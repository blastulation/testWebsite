<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    </asp:Content>
<asp:Content ID="Content1" runat="server" contentplaceholderid="MainContent">
    <p>
        <strong>Project Name:</strong><asp:DropDownList ID="DropDownList1" 
            runat="server" AutoPostBack="True" 
            DataSourceID="DropDownDataSource" DataTextField="Project_Name" 
            DataValueField="Project_Name" 
            onselectedindexchanged="DropDownList1_SelectedIndexChanged" Height="26px" 
            Width="155px"
            AppendDataBoundItems="true">

        <asp:ListItem Text="" Value="" />

        </asp:DropDownList>

        <asp:SqlDataSource ID="DropDownDataSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="SELECT DISTINCT(Project_Name) FROM Klocwork 
                           UNION
                           SELECT DISTINCT(Project_Name) FROM TeamCity " ></asp:SqlDataSource>
        <br />
        
        <asp:GridView ID="InfoTable" runat="server" AutoGenerateColumns="False" 
            DataSourceID="TableDataSource" style="margin-top: 0px" BackColor="White" 
            BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
            GridLines="Vertical" Width="225px">
            <AlternatingRowStyle BackColor="#DCDCDC" />
            <Columns>
                <asp:hyperlinkfield DataTextField="Build_No" navigateurl="https://www.google.com"
                HeaderText="Build Number" />
                <asp:hyperlinkfield DataTextField="Klocwork" navigateurl="https://www.google.com"
                HeaderText="Klocwork" />
               <asp:hyperlinkfield DataTextField="TeamCity" navigateurl="https://www.google.com" 
               HeaderText="TeamCity"/>
            </Columns>
            <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
            <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
            <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
            <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#0000A9" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#000065" />
        </asp:GridView>
        <asp:SqlDataSource ID="TableDataSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="SELECT        t1.Project_Name, t1.Build_No, TeamCity_1.TeamCity, Klocwork_1.Klocwork
FROM            (SELECT        Project_Name, Build_No
                          FROM            Klocwork
                          WHERE        (Project_Name = @Project_Name)
                          UNION
                          SELECT        Project_Name, Build_No
                          FROM            TeamCity
                          WHERE        (Project_Name = @Project_Name)) AS t1 FULL OUTER JOIN
                         TeamCity AS TeamCity_1 FULL OUTER JOIN
                         Klocwork AS Klocwork_1 ON Klocwork_1.Build_No = TeamCity_1.Build_No AND Klocwork_1.Project_Name = TeamCity_1.Project_Name ON 
                         TeamCity_1.Build_No = t1.Build_No AND TeamCity_1.Project_Name = t1.Project_Name OR Klocwork_1.Project_Name = t1.Project_Name AND 
                         Klocwork_1.Build_No = t1.Build_No
WHERE        (t1.Project_Name = @Project_Name)
ORDER BY ABS(t1.Build_No) ASC">
            <SelectParameters>
                <asp:Parameter DefaultValue="" Name="Project_Name" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

