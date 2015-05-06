var app = angular.module('infohealthhubApp', ['ui.bootstrap']);
app.factory('infohealthhubHomePageService', function ($http) {
	return {
		
		// getTopHealthNews: function (count, skip) {
		// 	return $http.get('/api/news/topnews?c=Health&n=' + count + '&s=' + skip).then(function (result) {
		// 		return result.data.rows;
		// 	});
		// },
		// getTopNewsWithImages: function (count) {
		// 	return $http.get('/api/news/topnews_with_images?n=' + count).then(function (result) {
		// 		// return result.data.rows;
		// 		return result.data.articles;
		// 	});
		// },

		// getMoreTopNewsWithImages: function (count, skip) {
		// 	return $http.get('/api/news/topnews_with_images_count_and_skip?n=' + count + '&s=' + skip).then(function (result) {
		// 		return result.data.rows;
		// 	});
		// },
		

	};
});
app.controller('InfohealthhubHome', function ($scope, infohealthhubHomePageService) {

	$scope.currentYear = (new Date).getFullYear();
	//the clean and simple way
	// $scope.topNewsWithImages 	= infohealthhubHomePageService.getTopNewsWithImages(3);
	
	// Non Featured Videos i.e all Videos
	$scope.newsPerPage = 10;

	// Get all Video's Count
	$scope.newsCount = 150;

	// Generate the numberOfPages and pages content based on the videoCount
	$scope.$watch('newsCount', function (newsCount) {
		if (newsCount !== undefined) {
			$scope.numberOfPages = (Math.ceil(newsCount/$scope.newsPerPage)).toString();

			// Pagination plugin
			$scope.bigTotalItems = newsCount;
		}
	});

	// Javascript Custom Function to get teh URL params, decode them
	function getURLParameter (name) {
		return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null;
	}

	// Get noneFeaturedVideos list based on the page(number) we are hitting from.
	$scope.currentPageNumber = parseInt(getURLParameter('p'), 10);
	
	if (isNaN($scope.currentPageNumber)) {
		skipValue = 0;
		$scope.currentPageNumber = 1;
	} else {
		skipValue = parseInt(($scope.currentPageNumber - 1) * $scope.videosPerPage, 10);
	}

	// Pagination plugin
	$scope.bigCurrentPage = $scope.currentPageNumber;
	$scope.maxSize = 6; // Max number of pages to be displayed at a time


	// Pagination plugin
	// This function is triggred when user tends to change the page using the plugin.
	$scope.pageChanged = function (page) {
		location.replace('/morehealthnews?p=' + page);
	};
});


app.controller('InfohealthhubFitness', function ($scope, infohealthhubHomePageService) {

	$scope.currentYear = (new Date).getFullYear();

	//the clean and simple way
	// $scope.topNewsWithImages 	= infohealthhubHomePageService.getTopNewsWithImages(3);
	
	// Non Featured Videos i.e all Videos
	$scope.newsPerPage = 10;

	// Get all Video's Count
	$scope.newsCount = 110;

	// Generate the numberOfPages and pages content based on the videoCount
	$scope.$watch('newsCount', function (newsCount) {
		if (newsCount !== undefined) {
			// Sample Output: {"rows":[{"key":null,"value":650}]}
			$scope.numberOfPages = (Math.ceil(newsCount/$scope.newsPerPage)).toString();

			// Pagination plugin
			$scope.bigTotalItems = newsCount;
		}
	});

	// Javascript Custom Function to get teh URL params, decode them
	function getURLParameter (name) {
		return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null;
	}

	// Get noneFeaturedVideos list based on the page(number) we are hitting from.
	$scope.currentPageNumber = parseInt(getURLParameter('p'), 10);
	
	if (isNaN($scope.currentPageNumber)) {
		skipValue = 0;
		$scope.currentPageNumber = 1;
	} else {
		skipValue = parseInt(($scope.currentPageNumber - 1) * $scope.videosPerPage, 10);
	}

	// Pagination plugin
	$scope.bigCurrentPage = $scope.currentPageNumber;
	$scope.maxSize = 6; // Max number of pages to be displayed at a time


	// Pagination plugin
	// This function is triggred when user tends to change the page using the plugin.
	$scope.pageChanged = function (page) {
		location.replace('/morefitnessnews?p=' + page);
	};
});

