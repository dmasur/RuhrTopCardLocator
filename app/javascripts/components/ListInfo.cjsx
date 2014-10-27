React = require 'react'

module.exports = React.createClass
  displayName: 'ListInfo'

  getDefaultProps: ->
    shownSize: 0
    allSize: 0

  render: ->
    <div className='text-center lead list-info'>
      {@props.shownSize} von {@props.allSize} Angeboten werden angezeigt
    </div>
