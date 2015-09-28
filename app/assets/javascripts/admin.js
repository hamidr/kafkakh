// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


Kafka.controller('AdminCtrl', function($scope, $http) {

  $scope.init = function(data) {
    $scope.users = data;
    $scope.users_page = 1;
    $scope.reporteds_page = 1;

    $scope.getReporteds(0);
  };


  $scope.getUsers = function(step) {
    if (($scope.users_page + step) <= 0)
      return;

    action = {
      method: 'GET',
      url: '/admin/users',
      params: {
        page: $scope.users_page + step
      }
    };

    $http(action).then(function(response) {
      if (response.data.length == 0)
        return; 

      $scope.users_page += step;
      $scope.users = response.data;
    }, function(resposne) {
      alert('Something bad happend!');
    });

  };

  $scope.getReporteds = function(step) {

    if (($scope.reporteds_page + step) <= 0)
      return;

    action = {
      method: 'GET',
      url: '/admin/reporteds',
      params: {
        page: $scope.reporteds_page + step
      }
    };

    $http(action).then(function(response) {
      if (response.data.length == 0)
        return;
      $scope.reporteds = response.data;
      $scope.reporteds_page += step;
    }, function(resposne) {
      alert('Something bad happend!');
    });
  };


  $scope.activateUser = function(id) {
    $http.put('/admin/user/'+id).then(function(response) {
      angular.forEach($scope.users, function(user) {
        if (user.id == id)
          user.is_active = true;
      });
    }, function(resposne) {
      alert('Something bad happend!');
    });
  };


  $scope.deactivateUser = function(id) {
    $http.delete('/admin/user/'+id).then(function(response) {
      angular.forEach($scope.users, function(user) {
        if (user.id == id)
          user.is_active = false;
      });
    }, function(resposne) {
      alert('Something bad happend!');
    });
  };


  $scope.deletePoll = function(id) {
    $http.delete('/admin/poll/'+id).then(function(response) {
      angular.forEach($scope.reporteds, function(poll) {
        if (poll.id == id)
          poll.removed = true;
      });
    }, function(resposne) {
      alert('Something bad happend!');
    });
  };

});
