window.showLogoutState = ->
  console.log 'Current state: Logout'
  window.currentState = 'logout'
  navigatorState.setState 'logout'
  mainState.setState 'logout'
  $('#navigator ul li#login').addClass '_active_'
  $('#navigator ul li#reg').removeClass '_active_'
  $('input#login').keyup () ->
    if @.value is ''
      $('form#form-login span#login').removeClass '-success-'
      $('form#form-login span#login').addClass '-error-'
    ss.rpc 'validate.login', @.value, (res) ->
      if res.status is 'failure'
        $('form#form-login span#login').addClass '-error-'
      if res.status is 'success'
        $('form#form-login span#login').removeClass '-error-'
        $('form#form-login span#login').addClass '-success-'
  $('input#password').keyup () ->
    if @.value is ''
      $('form#form-login span#password').removeClass '-success-'
      $('form#form-login span#password').addClass '-error-'
    ss.rpc 'validate.password', @.value.length, (res) ->
      if res.status is 'failure'
        $('form#form-login span#password').addClass '-error-'
      if res.status is 'success'
        $('form#form-login span#password').removeClass '-error-'
        $('form#form-login span#password').addClass '-success-'
  $('#fblogin').button
    action: ->
      ss.rpc 'authentication.signedIn', (response) ->
        console.log response
        if response.status is 'success' and response.user.fb?
          $.notify 'Facebook аккаунт уже подключен',
            header: 'Подключено!'
            theme: 'success'
            type: 9000
        if (response.status is 'success' and !response.user.fb?) or response.status is 'failure'
          console.log $('#fblogin').attr 'authlink'
          window.location = $('#fblogin').attr 'authlink'
    beforeAction: ->
      $(this).addClass "_loading_ _active_"
      d = $.Deferred()
      setTimeout (->
        d.resolve()
      ), 1000
      d.promise()
    ifNotAction: ->
      alert "Oh no!"
    clicked: ->
      $(this).removeClass "_loading_"
    beforeUnset: ->
      $(this).addClass "_loading_"
      d = $.Deferred()
      setTimeout (->
        d.resolve()
      ), 1000
      d.promise()
    unsetted: ->
      $(this).removeClass "_active_"
    ifUnsettedOrNot: ->
      $(this).removeClass "_loading_"
  selectors = "[data-radio=\"radio1\"]," + " [data-checkbox=\"checkbox1\"]," + " .js-button"
  $(selectors).button
    action: (data) ->
      login = $('#form-login input#login')[0].value
      password = $('#form-login input#password')[0].value
      ss.rpc 'authentication.login', {identifier: login, password: password}, (response) ->
        if response.status is 'success'
          showLoginState response.user
        $.notify response.reason,
          header: 'Fail!'
          theme: 'error'
          type: 9000
      $(this).addClass "_active_"

    beforeAction: ->
      $(this).addClass "_loading_ _active_"
      d = $.Deferred()
      setTimeout (->
        d.resolve()
      ), 1000
      d.promise()

    ifNotAction: ->
      alert "Oh no!"

    clicked: ->
      $(this).removeClass "_loading_"

    beforeUnset: ->
      $(this).addClass "_loading_"
      d = $.Deferred()
      setTimeout (->
        d.resolve()
      ), 1000
      d.promise()

    unsetted: ->
      $(this).removeClass "_active_"

    ifUnsettedOrNot: ->
      $(this).removeClass "_loading_"
