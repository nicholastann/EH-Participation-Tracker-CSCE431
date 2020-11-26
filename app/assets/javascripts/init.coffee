window.App ||= {}

customScripts =
  headroom: ->
    header = document.querySelector('#header')
    if window.location.hash
      header.classList.add 'slide--up'
    new Headroom(header,
      tolerance:
        down: 10
        up: 20
      offset: 150
      classes:
        initial: 'slide'
        pinned: 'slide--reset'
        unpinned: 'slide--up'
      onPin: ->
      onUnpin: ->
      onTop: ->
      onNotTop: ->
).init()
    return
  scrollTop: ->
    $(window).scroll ->
      if $(this).scrollTop() > 100
        $('.scroll-top').fadeIn()
      else
        $('.scroll-top').fadeOut()
      return
    # go to anchor when clicked
    $ ->
      $('.topScroll').click ->
        $('html,body').animate { scrollTop: '0px' }, 1000
        false
      return
    return
  toolTips: ->
    $ ->
      $('[data-toggle="tooltip"]').tooltip()
      return
    return
  init: ->
    customScripts.scrollTop()
    customScripts.headroom()
    customScripts.toolTips()
    return

App.init = ->
  customScripts.init()

$(document).on "turbolinks:load", ->
  App.init()