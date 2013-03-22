# Client Code

console.log 'App Loaded'

ss.rpc 'authentication.signedIn', (response) ->
  if response.status is 'success'
    showLoginState response.user
  else
    console.log 'showLogoutState'
    showLogoutState()

jQuery(document).on 'click', '#navigator ul li#login', ->
  showLogoutState()

jQuery(document).on 'click', '#navigator ul li#reg', ->
  showRegState()
