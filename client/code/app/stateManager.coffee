# USAGE
#
#    accountState = new StateManager('JQUERY_SELECTOR_FOR_SECTION')
#
#    accountState.addState 'STATE_NAME', -> jQuery('JQUERY_SELECTOR_FOR_SECTION').html HTML_TEMPLATE_FOR_HOMEPAGE
#
# In the case of app, we pass a JSON object to it containing a username, so that we can render it in the template
#
#    accountState.addState 'STATE_NAME', (data) -> jQuery('JQUERY_SELECTOR_FOR_SECTION').html(HTML_TEMPLATE_FOR_HOMEPAGE_WITH_RENDER(JSON_OBJECT))
#
# When we then want to render the a state i.e (the homepage), we call:
#
#    accountState.setState 'STATE_NAME'
#
# If the state receives data to render into the html template, we call:
#
#    accountState.setState 'STATE_NAME', JSON_OBJECT
#
class window.StateManager
  constructor: (@domId) ->
    @currentState = null
    @prevState = null
    @states = {}

  # Adds the state to the list of states for the stateManager class
  addState: (domClass, render) ->
    @states[domClass] = render

  getPrevState: ->
    console.log @prevState
    @prevState

  getCurrentState: ->
    @currentState

  # Sets the state. Will fade out the existing state if one has
  # been set before, and fade in the new one.
  setState: (state, data=null) ->
    if @currentState is state
      return
    if @currentState?
      @prevState = @currentState
      jQuery("#{@domId}").fadeOut 'slow', =>
        @currentState = state
        @states[state] data
        jQuery("#{@domId}").hide().fadeIn 'slow'
    else
      @currentState = state
      @states[state] data
      jQuery("#{@domId}").hide().fadeIn 'slow'
