window.signinCallback = (authResult) ->
  console.log(authResult)

  return if authResult.error
  $('.navbar-gplus').fadeOut(700)
  $('.navbar-signout').fadeIn(700)

signOut = () ->
  gapi.auth.signOut()

  $('.navbar-signout').fadeOut(700)
  $('.navbar-gplus').fadeIn(700)

$(document).ready ->
  $('#navbar-signout-link').click ->
    signOut()
    false
