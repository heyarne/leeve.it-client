/* globals fetch */
'use strict'

require('./tags/app.tag')
var riot = require('riot')

var app = require('ampersand-app')
var Router = require('./router')

var Me = require('./models/me')
var Note = require('./models/note')
var _url = require('./helpers')._url

app.extend({

  init: function () {
    this.initUI()
    this.initRouter()
  },

  initUI: function () {
    this.tags = riot.mount('*')
  },

  router: new Router(),
  initRouter: function () {
    this.router.history.start({ pushState: false })
  },

  navigate: function (page) {
    var url = (page.charAt(0) === '/') ? page.slice(1) : page
    this.router.history.navigate(url, { trigger: true })
  },

  isLoggedIn: function () {
    return !!this.me
  }

})

// the auth event indicates that we successfully authentified against the server,
// having established a session cookie that we can use to further request
// sensbile data (in this case our profile and notes).
app.on('auth', function () {
  fetch(_url('users/me'), { credentials: 'include' })
    .then(res => { return res.json() })
    .then(me => {
      app.me = new Me(me)
      app.trigger('login', app.me)
    })
    .catch(() => {
      console.error('Unable to fetch me', arguments)
    })

  fetch(_url('notes/me'), { credentials: 'include' })
    .then(res => { return res.json() })
    .then(notes => {
      app.notes = notes.map(note => new Note(note))
      app.trigger('notes:changed', app.notes)
    })
    .catch(() => {
      console.error('Could not fetch notes', arguments)
    })
})

app.on('logout', function () {
  app.me = null
})

// initialize crypto on login with some sensible defaults
var Crypto = require('./crypto')
app.on('login', function (me) {
  app.crypto = new Crypto({
    numBits: 2048,
    userId: me.keyIdentifier,
    passphrase: '$HARD$CODED$PASSWORDS$ARE$A$BAD$IDEA'
  })
})

// TODO: Put this into a store
app.on('notes:new', function (note) {
  note.save()
  app.notes.push(note)
  app.trigger('notes:changed', app.notes)
})

// expose for debugging:
window.app = app

app.init()
