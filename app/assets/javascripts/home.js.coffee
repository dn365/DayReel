# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
  $('#loginBtn').click ->
    email = $('#emailLogin').val()
    password = $('#passwordLogin').val()
    rebme = $('#remember_me').val()
    $.post "/login", {'user':{'email':email,'password':password}},
    (data) ->
      if data
#        alert data.error
        if data.error
          $('#error-info').html(data.error)
#        else if data.success
#          alert data.success
        else
          location.reload()


  $('#search-sortOption').change ->
    sort_type = $(this).val()
    key = $("#filter-key").val()
    window.location.href = "/search?sort_type="+sort_type+"&key="+key

