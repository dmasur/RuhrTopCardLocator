React = require 'react' 

ListInfo = React.createClass
  getDefaultProps: ->
    shownSize: 0
    allSize: 0
  render: ->
    <div className='text-center lead'>
      {this.props.shownSize} von {this.props.allSize} Angeboten werden angezeigt
    </div>

module.exports = ListInfo
