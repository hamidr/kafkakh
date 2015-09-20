// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

Kafka.controller('HomeCtrl', ['$scope', '$http', function($scope, $http) {
  $scope.init = function(polls) {
    $scope.polls = polls;
  }

  $scope.searcheds = [];
  $scope.search_attrs = {
    page: 1,
    tags: '',
    title: ''
  };

  $scope.old_search = {};
  
  $scope.search = function(page) {
    if (page == 0)
      $scope.search_attrs.page = 1

    search_attrs = $scope.search_attrs;

    if (search_attrs != $scope.search_attrs)
      $scope.search_attrs.page = 1;

    $scope.old_search = search_attrs;

    params = {
      title: search_attrs.title,
      tags: search_attrs.tags.split(' '),
      page: search_attrs.page + page
    };

    if (params.page <= 0)
      return;

    data = {
      params: params,
      url: '/search',
      method: 'GET'
    };

    $http(data).then(function(response) {
      if (response.data.length == 0)
        return;

      $scope.searcheds = response.data;
      $scope.search_attrs.page += page;

    }, function(response) {
      alert("Something is wrong!");
    });
  };
}]);
