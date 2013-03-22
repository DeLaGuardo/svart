window.showRegState = ->
  console.log 'Current state: Registration'
  window.currentState = 'reg'
  navigatorState.setState 'reg'
  mainState.setState 'reg'

  setButtonAction = ->
    selectors = "[data-radio=\"radio1\"]," + " [data-checkbox=\"checkbox1\"]," + " .js-button"
    $('.js-button').button
      action: (data) ->
        login = $('#form-login input#login')[0].value
        email = $('#form-login input#email')[0].value
        password = $('#form-login input#password')[0].value
        ss.rpc 'authentication.signup', {username: login, email: email, password: password}, (response) ->
          if response.status is 'success'
            showLoginState response.user
          if response.status is 'failure'
            reason = JSON.parse response.reason
            if reason.name is 'ValidationError'
              for name, error of reason.errors
                console.log name
                if name is 'email'
                  $('span#email').addClass '-error-'
                if name is 'username'
                  $('span#login').addClass '-error-'
              $.notify 'Введите корректные данные в поля Email и Логин. Поле Логин не должно содержать отличных от латинских символов или цифр.',
                header: 'Fail!'
                theme: 'error'
                type: 9000
        $(this).removeClass "_active_"
        $(this).removeClass '_loading_'

      beforeAction: ->
        $(this).addClass "_loading_ _active_"
        d = $.Deferred()
        setTimeout (->
          d.resolve()
        ), 1000
        d.promise()

      ifNotAction: ->
        alert "Oh no!"

      # clicked: ->
      #   $(this).removeClass "_loading_"

      # beforeUnset: ->
      #   $(this).addClass "_loading_"
      #   d = $.Deferred()
      #   setTimeout (->
      #     d.resolve()
      #   ), 1000
      #   d.promise()

      # unsetted: ->
      #   $(this).removeClass "_active_"

      # ifUnsettedOrNot: ->
      #   $(this).removeClass "_loading_"

  setTimeout setButtonAction, 1000
