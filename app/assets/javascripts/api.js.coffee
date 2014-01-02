class ZosimaApi
  login: (token) ->
    data = access_token: token
    ret = $.postAsObservable('/api/logins', data)
    ret.select (x) -> x.data.token

  cachedLogin: (token) ->
    login = Rx.Observable.defer () => 
      this.login(token).do((x) -> localStorage['apiKey'] = x)

    return if localStorage['apiKey'] then Rx.Observable.return(localStorage['apiKey']) else login

window.Zosima = new ZosimaApi()
