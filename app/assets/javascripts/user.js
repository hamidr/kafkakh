// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

Kafka.controller('UserCtrl', ['$scope', '$http', '$modal', function($scope, $http, $modal) {

  $scope.hide_create = true;
  $scope.init = function(data) {
    $scope.voted_polls = data.voted_polls;
    $scope.own_polls = data.own_polls;
    $scope.own_polls_page = $scope.voted_polls_page = 1;
  };

  $scope.range = function(min, max, step){
    step = step || 1;
    var input = [];
    for (var i = min; i <= max; i += step) input.push(i);
    return input;
  };

  $scope.getOwnPolls = function(page) {

    if ($scope.own_polls_page == 1 && page == -1)
      return;

    data = { 
      method: 'GET',
      params: { 
        page: $scope.own_polls_page + page 
      },
      url: '/me/polls'
    };

    $http(data)
      .then(function(response) {

        if (response.data.length == 0) {
          alert("That's it!");
          return;
        }

        $scope.own_polls =  response.data;
        $scope.own_polls_page += page
      }, function(response) {
        alert("something is wrong!");
      });
  };

  $scope.getVotedPolls = function(page) {

    if ($scope.own_polls_page == 1 && page == -1)
      return;

    data = { 
      method: 'GET',
      params: { 
        page: $scope.voted_polls_page + page 
      },
      url: '/me/voteds'
    };

    $http(data)
      .then(function(response) {
        if (response.data.length == 0) {
          return;
        }
        $scope.voted_polls =  response.data;
        $scope.voted_polls_page += page
      }, function(response) {
        alert("something is wrong!");
      });
  };


  var submit = function() {
    form = $scope.form;
    poll = form.poll;

    if (!poll.title || !poll.tags || poll.title == '' || poll.options.length == 1)
      return alert("Fill the form please!");

    poll.tags = poll.tags.split(' ');

    $http.post('/polls', poll).then(function(response) {
      $scope.created_poll = response.data;
      $scope.open(response.data);
    }, function(response) {
      alert("Something is wrong! Are you connected to the internet?");
    });
  };

  $scope.form = {
    poll: {
      options: [''],
      tags: ''
    },

    submit: submit,
  };

  $scope.open = function (poll) {

    var modalInstance = $modal.open({
      animation: true,
      templateUrl: 'myModalContent.html',
      controller: function($scope, $modalInstance) {
        $scope.poll = poll;
        $scope.ok = function() {
          $modalInstance.close();
        }
      }
    });

    modalInstance.result.then(function () {
    }, function () {
    });
  };

}]);
