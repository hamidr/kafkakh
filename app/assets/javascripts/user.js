// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require angular-ui-bootstrap-tpls

Kafka.controller('UserCtrl', ['$scope', '$http', '$modal', function($scope, $http, $modal) {

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
          alert("That's it!");
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

    $http.post('/polls', poll).then(function(response) {
      $scope.created_poll = response.data;
      console.log('polllll');
      $scope.open(response.data);
      console.log(response.data);
    }, function(response) {
      alert("Something is wrong! Are you connected to the internet?");
    });
  };

  $scope.form = {
    poll: {
      options: [''],
    },

    submit: submit,
    add_option: function(title) {
      this.poll.options.push(title);
    },
    remove_option: function(index) {
      delete this.poll.options[index];
    }
  };

  $scope.open = function (poll) {

      console.log('polllll');
      console.log(poll);
    var modalInstance = $modal.open({
      animation: true,
      templateUrl: 'myModalContent.html',
      controller: function($scope, $modalInstance) {
        $scope.poll = poll;
        $scope.ok = function() {
          console.log(poll);
          $modalInstance.close();
        }
      }
    });

    modalInstance.result.then(function () {
      console.log("wwgsfsd");
    }, function () {
    });
  };

}]);
