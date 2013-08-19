
$(document).ready(function () {
    init();
    toastr.options = {
        positionClass: 'toast-top-full-width'
        }
    });

function init() {
    function AppViewModel() {
        var model = this;
        
        model.games = ko.observableArray([]);
        model.week = ko.observable(1);
        model.picks = ko.observableArray([]);
        model.mondayNightGuesses = ko.observableArray([]);



        model.pickedGames = ko.computed(function () { //observableArray([]);
            var games = ko.utils.arrayMap(model.picks(), function (item) {
                return item.game;
            });
            return games;
        });
        model.pickedTeamIds = ko.computed(function () {
            var teamIds = ko.utils.arrayMap(model.picks(), function (item) {
                return item.teamId;
            });
            return teamIds;
        });



        // just pass it along to pickTeam()
        model.chooseHomeTeam = function (game) {
            console.log('chooseHomeTeam')
            model.pickTeam(game,
                game.homeTeamId,
                game.homeTeamName,
                game.homeTeamImg);

            //console.log(game)
        };
        model.chooseVisTeam = function (game) {
            console.log('chooseAwayTeam')
            model.pickTeam(game,
                game.visTeamId,
                game.visTeamName,
                game.visTeamImg);
        };

        // an animation
        model.showProduct = function (element) {
            console.log('showProduct');
            if (element.nodeType === 1) {
                $(element).hide().fadeIn();
            }
        };


        //** pick a team! *//
        model.pickTeam = function (game, teamId, teamName, teamImg) {
            console.log('pickTeam');
           
            // if that team is already picked, 
            // dont do nothing
            if (model.pickedGames().indexOf(game) >= 0) {
                for (var i = 0; i < model.picks().length; i++)
                    if (model.picks()[i].teamId == teamId) {
                        toastr.info('Game already picked!');
                        return;
                    }
            }

            // if that game is already picked, 
            // remove the old team before putting the new one in
            if (model.pickedGames().indexOf(game) >= 0) {
                //console.log('game alreay picked');
                for (var i = 0; i < model.picks().length; i++)
                    if (model.picks()[i].game == game)
                        model.picks.remove(model.picks()[i]);
            }
            // max of 3 picks
            if (model.picks().length >= 3) {
                toastr.warning('Picks already full.');
                return;
            }


            model.picks.push(
                {
                    game: game,
                    teamId: teamId,
                    teamName: teamName,
                    teamImg: teamImg
                });
        }



        model.pointVal = function (i) {
            console.log(i);
            if (i == 0) return 5;
            return 4 - i;
        }

        model.moveUp = function (pick) {
            var currentIndex = model.picks.indexOf(pick);
            if (currentIndex == 0) return; //cant move up!

            model.picks.remove(pick);
            model.picks.splice(currentIndex - 1, 0, pick);

        };
        model.removePick = function (pick) {
            model.picks.remove(pick);
        };

        model.isGamePicked = function (game) {
            return (model.pickedGames().indexOf(game) >= 0);
        };
        model.isTeamPicked = function (teamId) {
            return (model.pickedTeamIds().indexOf(teamId) >= 0);
        };

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "API/Games.asmx/ByWeek",
            data: "{ week: 1 }",
            dataType: "json",
            success: function (data) {
                x = JSON.parse(data.d);
                console.log(x);

                ko.utils.arrayForEach(x, function (item) {
                    model.games.push(
                        $.extend(item,
                            {
                                isPicked: false,
                                homePicked: false,
                                visPicked: false
                            }
                            ));
                    if (moment(item.date).format('ddd') == 'Mon')
                        model.mondayNightGuesses.push(
                            {
                                game: item,
                                guess: 10   
                            });
                });
            }
        });

    }

    // Activates knockout.js
    ko.applyBindings(new AppViewModel());
}
