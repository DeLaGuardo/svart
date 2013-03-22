window.navigatorState = new StateManager('#navigator')
navigatorState.addState 'logout', ->
  jQuery('#navigator').html ss.tmpl['navigator-state_logout'].r()
  activateNav()
  navToAffix()
navigatorState.addState 'login', (user) ->
  jQuery('#navigator').html ss.tmpl['navigator-state_login'].render username: user.username
  navToAffix()
navigatorState.addState 'reg', ->
  activateNav()
  navToAffix()

window.mainState = new StateManager('#main')
mainState.addState 'logout', ->
  jQuery('#main').html ss.tmpl['main-state_logout'].r()
  prepSocialButtons true
mainState.addState 'login', ->
  jQuery('#main').html ss.tmpl['main-state_login'].r()
mainState.addState 'reg', ->
  jQuery('#main').html ss.tmpl['main-state_reg'].r()
  prepSocialButtons true

activateNav = ->
  $('#navigator ul li').removeClass '_active_'
  if currentState is 'logout'
    $("#navigator ul li#login").addClass '_active_'
    return true
  if currentState is 'reg'
    $("#navigator ul li#reg").addClass '_active_'
    return true
  false

prepSocialButtons = (enabled) ->
  $('.-tooltip').remove()
  $('#fblogin.fb-tooltip').popup
    enabled: enabled
    trigger: 'hover'
    animation: 'rotateIn'
    animationDuration: 400
    template: ss.tmpl['helpers-tooltip'].render {layout: '_bottom_'}
    content: 'Facebook'
    placement: 'bottom'
    onlyOne: false
  $('#vklogin.vk-tooltip').popup
    enabled: enabled
    trigger: 'hover'
    animation: 'rotateIn'
    animationDuration: 400
    template: ss.tmpl['helpers-tooltip'].render {layout: '_bottom_'}
    content: 'Vkontakte'
    placement: 'bottom'
    onlyOne: false
  $('#ghlogin.gh-tooltip').popup
    enabled: enabled
    trigger: 'hover'
    animation: 'rotateIn'
    animationDuration: 400
    template: ss.tmpl['helpers-tooltip'].render {layout: '_bottom_'}
    content: 'GitHub'
    placement: 'bottom'
    onlyOne: false
  $('#twlogin.tw-tooltip').popup
    enabled: enabled
    trigger: 'hover'
    animation: 'rotateIn'
    animationDuration: 400
    template: ss.tmpl['helpers-tooltip'].render {layout: '_bottom_'}
    content: 'Twitter'
    placement: 'bottom'
    onlyOne: false
  true

navToAffix = ->
  $('.js-affix').affix {inside: $('body')}

# window.showLogoutState = ->
#   console.log 'Current state: Logout'
#   navigatorState.setState 'logout'
#   mainState.setState 'logout'
#   prepSocialButtons false
#   $('#navigator ul li#login').addClass '_active_'
#   $('#navigator ul li#reg').removeClass '_active_'
#   navToAffix()
#   prepSocialButtons true
#   $('input#login').keyup () ->
#     if @.value is ''
#       $('form#form-login span#login').removeClass '-success-'
#       $('form#form-login span#login').addClass '-error-'
#     ss.rpc 'validate.login', @.value, (res) ->
#       if res.status is 'failure'
#         $('form#form-login span#login').addClass '-error-'
#       if res.status is 'success'
#         $('form#form-login span#login').removeClass '-error-'
#         $('form#form-login span#login').addClass '-success-'
#   $('input#password').keyup () ->
#     if @.value is ''
#       $('form#form-login span#password').removeClass '-success-'
#       $('form#form-login span#password').addClass '-error-'
#     ss.rpc 'validate.password', @.value.length, (res) ->
#       if res.status is 'failure'
#         $('form#form-login span#password').addClass '-error-'
#       if res.status is 'success'
#         $('form#form-login span#password').removeClass '-error-'
#         $('form#form-login span#password').addClass '-success-'
#   selectors = "[data-radio=\"radio1\"]," + " [data-checkbox=\"checkbox1\"]," + " .js-button"
#   $(selectors).button
#     action: (data) ->
#       login = $('#form-login input#login')[0].value
#       password = $('#form-login input#password')[0].value
#       login = $('#form-login input#login')[0].value
#       password = $('#form-login input#password')[0].value
#       ss.rpc 'authentication.login', {identifier: login, password: password}, (response) ->
#         if response.status is 'success'
#           showLoginState response.user
#         $.notify response.reason,
#           header: 'Fail!'
#           theme: 'error'
#           type: 9000
#       $(this).addClass "_active_"

#     beforeAction: ->
#       $(this).addClass "_loading_ _active_"
#       d = $.Deferred()
#       setTimeout (->
#         d.resolve()
#       ), 1000
#       d.promise()

#     ifNotAction: ->
#       alert "Oh no!"

#     clicked: ->
#       $(this).removeClass "_loading_"

#     beforeUnset: ->
#       $(this).addClass "_loading_"
#       d = $.Deferred()
#       setTimeout (->
#         d.resolve()
#       ), 1000
#       d.promise()

#     unsetted: ->
#       $(this).removeClass "_active_"

#     ifUnsettedOrNot: ->
#       $(this).removeClass "_loading_"


  # $('.js-affix').affix {inside: $('body')}

# window.showRegState = ->
#   console.log 'Curent state: reg'
#   mainState.setState 'reg'

  # navToAffix()
  # prepSocialButtons true

window.onresize = ->
  $('.-dropdown').css('display', 'none')
  if $(window).width() < 800
    settings =
      trigger: 'hover, click'
      animation: 'rotateIn'
      animationDuration: 400
      template: TEMPLATES.dropdownMainMenu
      content: $('.main-menu-major').clone().removeClass('_horizontal_ main-menu-major')
      placement: 'bottom'
      onlyOne: false
    $('.js-tooltip').popup(settings)

# window.accountState = new StateManager('#account')
# # The homepage state for the account element (render template with login link)
# accountState.addState 'homepage', -> jQuery("#account").html ss.tmpl["homepage-account"].r()
# # The app state for the account element (render template with username and logout link)
# accountState.addState 'app', (data) -> jQuery("#account").html ss.tmpl["app-account"].render data

# # The nav element (the links in the top bar, like the Dashboards menu)
# window.navState = new StateManager('#nav')
# # The homepage state for the nav element (render template which contains no menus/links)
# navState.addState 'homepage', -> jQuery("#nav").html ss.tmpl["homepage-nav"].r()

# navState.addState 'app', -> jQuery('#nav').html ss.tmpl['app-nav'].r()

# navState.addState 'min', -> jQuery('#nav').html ss.tmpl['min-nav'].r()

# # The main element (the main part of the page)
# window.mainState = new StateManager('#main')
# # The homepage state for the main element (render homepage template, and adjust screen size if it was set to fluid by a dashboard)
# mainState.addState 'homepage', ->
#   jQuery('#main').html ss.tmpl['homepage-main'].r()

# # The account state for the main element (render account template with data)
# mainState.addState 'account', (data) ->
#   jQuery('#main').html ss.tmpl['account-main'].render data

# # The docs state for the main element (render docs template)
# mainState.addState 'docs', (data) ->
#   jQuery('#newWidget').remove()
#   jQuery('#main').html ss.tmpl['docs-main'].r()

# window.showLogoutState = ->
#   console.log 'Current state is logout'
#   accountState.setState 'homepage'
#   navState.setState 'homepage'
#   mainState.setState 'homepage'

# window.showLoginState = (data) ->
#   console.log 'Current state is login'
#   accountState.setState 'app', data
#   navState.setState 'app'
#   $('.js-tooltip').popup({
#     trigger: 'hover'
#   , animation: 'dropIn'
#   , animationDuration: 4000
#   , template: '<div id="tooltip-template"><div class="-tooltip -info- _bottom_ _big"><i class="-arrow"></i><div class="js-content"></div></div></div>'
#   , content: 'Click to show your account'
#   , placement: 'bottom'
#   , onlyOne: true
#   })

# window.showAccountState = (data) ->
#   console.log "Current state is main account"
#   mainState.setState 'account', data
#   $('.js-tabs').tabs
#     animation: 'true'
#     itemsSelector: 'li'



# dropdownMainMenu = '<div class="-dropdown -dark-">  <i class="-arrow"></i>  <div class="js-content"></div> </div>'

# window.onresize = () ->
#   if $(window).width() < 800
#     # $('.js-main-menu-minor').append $('.js-main-menu-major').clone().removeClass('_horizontal_ main-menu-major')
    # $('.js-main-menu-minor li').popup
    #     template: dropdownMainMenu,
    #     content: '!',
    #     placement: 'bottom',
    #     trigger: 'click',
    #     animation: 'dropIn',
    #     animationDuration: 400
#     # $('.js-main-menu-major').css("display", "none")
