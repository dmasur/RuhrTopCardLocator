React = require 'react'

Number::times = (fn) ->
  do fn for [1..@valueOf()] if @valueOf()
  return

module.exports = React.createClass
  stars: (count, iconClass) ->
    code = []
    count.times (key) ->
      code.push <i key={key} className={"fa #{iconClass}"}></i>
    code

  render: ->
    full_star_count = Math.floor @props.count
    empty_stars_count = 5 - full_star_count
    full_stars = @.stars(full_star_count, 'fa-star')
    empty_stars = @.stars(empty_stars_count, 'fa-star-o')
    
    <span>
      {full_stars}
      {empty_stars}
    </span>
