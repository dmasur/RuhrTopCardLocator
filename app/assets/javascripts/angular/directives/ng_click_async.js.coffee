angular.module('ruhrTopCardLocator').directive 'ngClickAsync', ['$parse', ($parse) ->
  compile: ($element, attr) ->
    fn = $parse(attr.ngClickAsync)
    (scope, element) ->
      element.on 'click', (event) ->
        scope.$evalAsync ->
          fn(scope, {$event: event})
]