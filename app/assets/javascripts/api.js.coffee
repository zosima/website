class ZosimaApi
  authedGet: (url, data) ->
    data ?= {}
    return Rx.Observable.throw(new Error('No token')) unless localStorage['apiKey']

    dataWithToken = $.extend(data, {"access_token": localStorage['apiKey']})
    $.getAsObservable(url, dataWithToken)
      .select (x) -> x.data

  authedPost: (url, data) ->
    data ?= {}
    return Rx.Observable.throw(new Error('No token')) unless localStorage['apiKey']

    dataWithToken = $.extend(data, {"access_token": localStorage['apiKey']})
    $.postAsObservable(url, dataWithToken)
      .select (x) -> x.data

  login: (token) ->
    data = access_token: token
    ret = $.postAsObservable('/api/logins', data)
    ret.select (x) -> x.data.token

  getProfileData: ->
    this.authedGet '/api/logins/current'
      
  cachedLogin: (token) ->
    login = Rx.Observable.defer () => 
      this.login(token).do((x) -> localStorage['apiKey'] = x)

    return this.getProfileData()
      .select((x) -> localStorage['apiKey'])
      .catch(login)

window.Zosima = new ZosimaApi()
