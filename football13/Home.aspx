<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="football13.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    
    <div class="row">
        
        <div class="col-md-6">
            <h3>Your Picks</h3>
            <!--<ul data-bind="foreach: pickedGames"><li data-bind="text: $data"></li></ul>-->
            <table class="table table-condensed">
                <thead>
                    <tr>
                        <th colspan="4">Pick the Winner!</th>
                    </tr>
                </thead>
                <tbody  data-bind="foreach: { data: picks, afterAdd: $root.showProduct }" class="list-unstyled">
                <tr class="li-pick">
                    <td>
                        <span class="label label-inverse muted" data-bind="text: $root.pointVal($index()) + ' PTS'"></span>
                        <img data-bind="attr: { 'src': teamImg }" />
                        <span data-bind="text: teamName"></span>
                    </td>
                    <td>
                        <span class="label label-warning" data-bind="visible: teamName == game.favTeamName,
                            text: '- ' + game.spread"></span>
                        <span class="label label-success" data-bind="visible: teamName != game.favTeamName,
                            text: '+ ' + game.spread"></span>
                        </td>
                    <td class="margin-top-10">
                        <i class="icon-arrow-up icon-clickable text-primary" data-bind="visible: $index() > 0, click: $root.moveUp"></i>
                        <i class="icon-remove icon-clickable text-danger" data-bind="click: $root.removePick"></i>
                    </td>
                    
                </tr>
                    </tbody>
            </table>

            <table class="table table-condensed">
                <thead>
                    <tr>
                        <th colspan="4">Monday Night Football</th>
                    </tr>
                </thead>
                <tbody  data-bind="foreach: mondayNightGuesses">
                <tr>
                    <td class="text-center">
                    <img data-bind="attr: { src: game.visTeamImg }" width="25" />
                                <span data-bind="text: game.visTeamName"></span>
                        </td><td>at</td><td>
                    <img data-bind="attr: { src: game.homeTeamImg }" width="25" />
                                <span data-bind="text: game.homeTeamName"></span>
                        </td>
                    <td>
                        <input type="number" class="input input-block-level" data-bind="value: guess" />
                            </td>
                </tr>
                    </tbody>
            </table>
        </div>
        <div class="col-md-6">
            <h3>Games: Week <span data-bind="text: week"></span></h3>
            <i class="icon-star"></i> = Favorite
            <table class="table table-condensed table-hover">
                <thead>
                    <tr>
                        <th></th>
                        <th>Visitor</th>
                        <th></th>
                        <th>Home</th>
                        <!--<th>Favorite</th>-->
                        <th class="text-right">Spread</th>
                    </tr>
                </thead>
                <tbody data-bind="foreach: { data: games }">
                    <tr data-bind="css: { 'success': $root.isGamePicked($data) }">
                        <td><span data-bind="text: moment(date).format('h:mm a - ddd MMM D')"></span></td>
                        <td data-bind="css: { 'team-picked': $root.isTeamPicked(visTeamId) }">
                            <a href="#" data-bind="click: $root.chooseVisTeam" 
                                class="teamLink">
                                <img data-bind="attr: { src: visTeamImg }" width="25" />
                                <span data-bind="text: visTeamName"></span>
                                <i class="icon-star" data-bind="visible: visTeamName == favTeamName"></i>
                            </a>
                            </td>
                        <td>at</td>
                        <td data-bind="css: { 'team-picked': $root.isTeamPicked(homeTeamId) }" >
                            <a href="#" data-bind="click: $root.chooseHomeTeam" class="teamLink">
                            <img data-bind="attr: { src: homeTeamImg }" width="25" /><span data-bind="text: homeTeamName"></span>
                                
                            <i class="icon-star" data-bind="visible: homeTeamName == favTeamName"></i>
                                </a>
                                </td>
                        <!--<td><span data-bind="text: favTeamName"></span></td>-->
                        <td class="text-right"><span data-bind="text: spread"></span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    
</asp:Content>
<asp:Content ContentPlaceHolderID="Javascript" runat="server">
    <script src="_js/football.home.js"></script>
</asp:Content>