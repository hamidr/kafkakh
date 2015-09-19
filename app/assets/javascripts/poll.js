// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//=require directives/bars_chart

Kafka.controller('PollCtrl', ['$scope', '$http', function($scope, $http) {

  $scope.init = function(data) {
    $scope.data = data;
  };

  $scope.vote = function(id) {

    if ($scope.data.voted_to == id)
      return;

    if ($scope.data.voted_to && $scope.data.voted_to != id)
      return unvote($scope.data.voted_to, function() { $scope.vote(id); });

    data = {
      poll_id: $scope.data.id,
      option_id: id
    }

    $http.post('/vote', data).then(function(response) {
      $scope.data.voted_to = id;
      $scope.data.total_count += 1;
      angular.forEach($scope.data.options, function(value) {
        if (id == value.id)
          return value.count += 1;
      });
    }, function(response) {
      alert("You can NOT vote!");
    });

  }

  var unvote = function(id, callback) {
   data = {
      poll_id: $scope.data.id,
      option_id: id
    }

   $http.post('/unvote', data).then(function(response) {
     delete $scope.data.voted_to;
     $scope.data.total_count -= 1;

     angular.forEach($scope.data.options, function(value) {
       if (id == value.id)
         return value.count -= 1;
     });

     callback();
   }, function(response) {
     alert("You cant unvote!");
   });

  }

}]);

