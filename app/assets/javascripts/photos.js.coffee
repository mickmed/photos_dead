# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  if $('#infinite-scrolling').size() > 0
    $(window).on 'scroll', ->
      more_photos_url = $('.pagination a[rel=next]').attr('href')
      if more_photos_url && $(window).scrollTop() > $(document).height() - $(window).height() - 450
          $('.pagination').html("")
          $.ajax
            url: more_photos_url
            success: (data) ->
              $("#photos").append(data)
      if !more_photos_url
        $('.pagination').html("")
    return