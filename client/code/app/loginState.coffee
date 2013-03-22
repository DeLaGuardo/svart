humanFileSize = (bytes, si) ->
  thresh = (if si then 1000 else 1024)
  return bytes + " B"  if bytes < thresh
  units = (if si then ["kB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"] else ["KiB", "MiB", "GiB", "TiB", "PiB", "EiB", "ZiB", "YiB"])
  u = -1
  loop
    bytes /= thresh
    ++u
    break unless bytes >= thresh
  bytes.toFixed(1) + " " + units[u]

window.showLoginState = (user) ->
  console.log 'Current state: Login'
  navigatorState.setState 'login', user
  mainState.setState 'login'

  connectToBinaryServer = ->
    doNothing = (e) ->
      e.preventDefault()
      e.stopPropagation()

    # TODO: Mega hack !!! Need to replace with something else.
    ss.rpc 'user.get_files', (response) ->
      for file in response.files
        file_view = ss.tmpl['helpers-file'].render
          id: file.id
          name: file.filename
          size: humanFileSize file.size, 'to reg'
          type: file.filetype
          url: "http://localhost/gridfs/#{file.filename}"
        $('tbody#file-list').append(file_view)
    client = new BinaryClient("ws://localhost:9000", {chunckSize: 256 * 1024})
    client.on "open", ->
      box = $("#box")
      box.on "dragenter", doNothing
      box.on "dragover", doNothing
      box.text "Drag files here"
      box.on "drop", (e) ->
        e.originalEvent.preventDefault()
        file = e.originalEvent.dataTransfer.files[0]
        console.log file
        # $('tbody#file-list').append($("<tr></tr>").text(file.name).prop("href", "/" + file.name))

        stream = undefined
        ss.rpc "authentication.account", (response) ->
          stream = client.send(file,
            name: file.name
            size: file.size
            user: response.user._id
          )
          tx = 0
          stream.on "data", (data) ->
            if data.rx?
                $("#progress").text Math.round(tx += data.rx * 100) + "% complete"
            if data.file?
              ss.rpc 'user.save_file', {_id: data.file._id}, (response) ->
                if response.status is 'failure'
                  $.notify 'Не удалось сохранить файл в базу данных!',
                    header: 'Ошибка!'
                    theme: 'error'
                    type: 9000
                  return
                # console.log data.file
                file_view = ss.tmpl['helpers-file'].render
                  id: data.file.id
                  name: data.file.filename
                  size: humanFileSize data.file.size, 'to reg'
                  type: data.file.filetype
                  url: "http://localhost/gridfs/#{data.file.filename}"
                $('tbody#file-list').append(file_view)

  setTimeout connectToBinaryServer, 1000
  # setCalendar()

  # if user.fb.id?
  #   $('#fblogin').removeClass '-primary-'
  #   $('#fblogin').addClass '-success-'
  #   $('#fblogin').addClass '_loading_'

  # $('#fblogin').button
  #   action: ->
  #     ss.rpc 'authentication.signedIn', (response) ->
  #       if response.status is 'success' and response.user.fb.id?
  #         $.notify 'Facebook аккаунт уже подключен',
  #           header: 'Подключено!'
  #           theme: 'success'
  #           type: 9000
  #       if (response.status is 'success' and !response.user.fb.id?) or response.status is 'failure'
  #         window.location = $('#fblogin').attr 'authlink'
  #   beforeAction: ->
  #     $(this).addClass "_loading_ _active_"
  #     d = $.Deferred()
  #     setTimeout (->
  #       d.resolve()
  #     ), 1000
  #     d.promise()
  #   ifNotAction: ->
  #     alert "Oh no!"
  #   beforeUnset: ->
  #     $(this).addClass "_loading_"
  #     d = $.Deferred()
  #     setTimeout (->
  #       d.resolve()
  #     ), 1000
  #     d.promise()
  #   unsetted: ->
  #     $(this).removeClass "_active_"
  #   ifUnsettedOrNot: ->
  #     $(this).removeClass "_loading_"

